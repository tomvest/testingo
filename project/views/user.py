#{{{
import random

from pyramid.view import (
    view_config,
    forbidden_view_config,

    )
from pyramid.httpexceptions import (
    HTTPNotFound,
    HTTPFound,
    HTTPForbidden,
    )
from pyramid_mailer.message import (
    Message,
    )

from ..models.user import (
    User,
    MyPassword
    )
from ..utils import valid_email
from ..authenticator import (
    WrongPasswordError,
    NonExistingUserError,
    )
from bcrypt import (hashpw, gensalt)
#}}}
class RegistrationError(Exception):
    pass


class DuplicateUserError(RegistrationError):
    pass


def register_user(db_session, email, password, name):
    """Registers a new user and returns his ID (single number).

    """
    user = User(email, password, name)

    if db_session.query(User).filter_by(email=email).count() != 0:
        raise DuplicateUserError

    db_session.add(user)
    db_session.flush()

    return user.id

error_messages = {
    'invalid_email':'Zadajte správny e-mail.',
    'duplicate_email':'E-mail je už obsadený.',
    'invalid_password':'Zadajte heslo.',
    'dont_match':'Heslá sa nezhodujú.',
    'need_login':'Je potrebné sa prihlásiť',
    'short_password' : 'Heslo musí mať minimálne 6 znakov/číslic'
    }


@view_config(route_name='home', request_method='GET', renderer='project:templates/home.mako')
def register_view(request):
    """Displays registration form and processes form data.
    """

    return {'errors': {}, 'error_messages': error_messages}


@view_config(route_name='home', request_method='POST', renderer='json')
def register_submission(request):
    """Handles registration form submission.
    """
    json = request.json_body
    errors = validate_registration_data(json)

    if not errors:
        try:
            user_id = register_user(request.db_session, json['email'], json['password'], json['login'])
            succ = "Registrácia úspešná"
            return HTTPFound(location=request.route_path('dashboard'), comment=succ)
        except DuplicateUserError:
            errors['email'] = 'duplicate_email'

    return {'errors': errors, 'error_messages': error_messages}


@view_config(route_name='register_success', renderer='project:templates/register_success.mako')
def register_success(request):
    """Displays success message after registration
    """
    return {'user_id':request.matchdict['user_id']}


def validate_registration_data(form_data):
    """Checkes whether all datas are correct and returns dictionary of errors.
    """
    errors = {}
    if not valid_email(form_data['email']):
        errors['email'] = 'invalid_email'
    if form_data['password'] == "":
        errors['password'] = 'invalid_password'
    #if len(form_data['password']) < 5:
    #     errors['password'] =  'short_password'
    return errors


@view_config(route_name='get_user_info', renderer='json')
def get_user_info(request):
    """Shows user's data in json format.
    Expects request.matchdict['user_id'].
    Return error='no-user-error' if user doesn't exist.
    Data is represented by dict with keys: 'email', 'password'.
    """
    user_id = request.matchdict['user_id']
    user = request.db_session.query(User).filter_by(id=user_id).first()
    data = {'error':'no-user-error'}
    if not user is None:
        data = {'email':user.email}
    return data



@view_config(route_name='login', request_method='GET', renderer='project:templates/login.mako')
@forbidden_view_config(renderer='project:templates/login.mako')
def login(request):
    """Shows login form.
    """
    return {'errors':[]}


@view_config(route_name='login', request_method='POST', renderer='project:templates/login.mako')
def login_submit(request):
    """Processes submit of login data.

    If they are correct, then authorizes and redirect to homepage. Otherwise, shows error.
    """
    POST = request.POST

    email = POST['email']
    password = POST['password']
    errors = []

    try:
        (headers, user) = request.authenticator.login(email, password)
        return HTTPFound(location=request.route_path('dashboard'), headers=headers)
    except WrongPasswordError:
        errors.append('Zadané nesprávne heslo')
        errors.append('passw')
    except NonExistingUserError:
        errors.append('Užívateľ s emailom ' + email + ' neexistuje.')
        errors.append('email')
    return {'errors': errors}


@view_config(route_name='logout')
def logout(request):
    """Unauthorizes user.
    """
    headers = request.authenticator.logout()
    return HTTPFound(location=request.route_path('home'), headers=headers)


@view_config(route_name='beg_for_recovery', request_method='GET', renderer='project:templates/lost_password.mako')
def beg_for_recovery(request):
    """Shows form for email of user's account.
    """
    return {'error':[]}


@view_config(route_name='beg_for_recovery', request_method='POST', renderer='project:templates/lost_password.mako')
def begged_for_recovery(request):
    """Gets email. If exists, generates `recovery_code` and send a recovery link to user and redirect to
    "success_beg". If not, shows error.
    """
    POST = request.POST
    email = POST['email']
    user = request.db_session.query(User).filter_by(email=email).first()
    if user == None:
        return {'error': ['no-email']}

    user.recovery_code = str(random.getrandbits(50))
    link = request.route_url('new_password', user_id=str(user.id), code=user.recovery_code)
    message = Message(subject='Zmena hesla na Testingo.sk',
                      recipients=[email],
                      body='Ak si chcete zmeniť heslo, kliknite na nasledovný odkaz:' + link + '.')
    request.mailer.send(message)

    return HTTPFound(location=request.route_url('recovery_small_success'))


@view_config(route_name='recovery_small_success', renderer='project:templates/small_success.mako')
def recovery_small_success(request):
    """Shows a message with an offer to check email for a link to advance in passweord recovery process.
    """
    return {}

@view_config(route_name='new_password', request_method='GET', renderer='project:templates/new_password.mako')
def recovery_final(request):
    """Shows form for new password. if user_id or recovery code doesn't match, then shows 404.
    """
    user_id = int(request.matchdict['user_id'])
    user = request.db_session.query(User).filter_by(id=user_id).first()

    if user == None:
        return HTTPNotFound("Neplatná obnovovacia URL. Skontrolujte odkaz na zmenu hesla a skúste znova.")
    if request.matchdict['code'] != user.recovery_code:
        return HTTPNotFound("Neplatná obnovovacia URL. Skontrolujte odkaz na zmenu hesla a skúste znova.")
    return {'error':[]}

@view_config(route_name='new_password', request_method='POST', renderer='project:templates/new_password.mako')
def recovery_final_submit(request):
    """Takes two passwords. If they match, then changes it in database and redirect to homepage.
    Otherwise shows error.
    """
    POST = request.POST
    password = POST['password']
    password_repeat = POST['password_repeat']
    if password != password_repeat:
        return {'error':['nonequal-passwords']}
    user = request.db_session.query(User).filter_by(id=request.matchdict['user_id']).first()
    user.password = password
    return HTTPFound(location=request.route_url('home'))

@view_config(route_name='profile', request_method='GET', renderer='project:templates/profile.mako')
def access_user_profile(request):
    """
    Returns user.
    """
    try:
        user = request.db_session.query(User).filter_by(id=request.userid).one()
    except Exception:
        raise HTTPNotFound
    return {'user': user,'errors':[]}

@view_config(route_name='profile', renderer='json')
def change_password(request):
    """
    Returns user.
    """
    user=request.db_session.query(User).filter_by(id=request.userid).one()
    json = request.json_body

    if json['con'] is 0:
        new_password = json['new_password']
        new_password2 = json['new_password2']

        email = user.email
        password= json['current_password']
        errors=[]
        if new_password != new_password2:
            errors.append('Heslá sa nerovnajú, ako si sa sem dostal vôbec, ty hacker')
            return {'errors':errors}
        try:
            (headers, user) = request.authenticator.login(email, password)
            user.password = new_password
            request.db_session.flush()
            succ = "Heslo bolo úspešne zmenené"
            return HTTPFound(location=request.route_path('dashboard'), comment=succ)
        except WrongPasswordError:
            errors.append('Zadané nesprávne heslo')
            return {'errors':errors}
    else: 
        user.name = json['user_name']
        user.email = json['email']

        request.db_session.merge(user)
        request.db_session.flush()

        return HTTPFound(location=request.route_path('profile'))



