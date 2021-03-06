<%inherit file="default.mako" />
<%block name="title">Úvodná stránka</%block>
<%block name="before_content">
    <script src="${request.static_path('project:static/js/home.js')}"></script>
    <script type="text/javascript">
        post_url="${request.route_path('home')}"
    </script>

    <div class="headrow">
        <div class="container">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 whyt">
                        <h2>Prečo si vybrať testingo?</h2>
                        <ul class="list-unstyled checks">
                            <li><span class="glyphicon glyphicon-ok"></span> Vytvorte si test kedykoľvek a kdekoľvek potrebujete</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Nestrácajte čas opravovaním papierových testov</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Žiadne ponocovanie! Testy opravuje a vyhodnocuje Testingo</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Meškajúce termíny a nervózni študenti sú Vašou minulosťou</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Vytvorte rovnocenné podmienky riešenia pre svojich študentov</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Výsledok sa respondent dozvie okamžite</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Majte všetko pod kontrolou!</li>
                        </ul>
                    </div>
                    <div class="col-lg-2">
                    </div>
                    <div class="col-lg-4">
                        <div class="pull-left">
							% if request.userid is None:
                                <form class="form-signin" method="post" action="" id="form-signin">
                                    <h2 class="form-signin-heading">Rýchla registrácia</h2>

                                    <div class="control-group">
                                        <div class="controls">
                                            <input size="50" name="login" id="login" value="" type="text" class="form-control" placeholder="Meno" autofocus="autofocus" required>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <div class="controls">
                                            <input size="50" name="email" id="email" value="" type="email" class="form-control" placeholder="E-Mail" required>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <div class="controls">
                                            <input size="50" name="password" id="password" value="" type="password" class="form-control" placeholder="Heslo" required>
                                        </div>
                                    </div>

                                    <button name="submit" id="submit" value="" type="submit" class="btn btn-large btn-primary btn-block">Registrovať</button>
                                    <p class="help-block text-right">
                                        <a href="${request.route_path('dashboard')}">Prihlásenie</a> |
                                        <a href="${request.route_path('beg_for_recovery')}" >Zabudnuté heslo</a>
                                    </p>
                                </form>
							% else:
                                <div class="form-signin">
                                    <div class="user-pic"> <img src="${request.static_path('project:static/img/icons/User.png')}"> </div>
                                    <p class="text-center">
                                        Prihlásený <a href="${request.route_path('profile')}">${request.user.name}</a><br>
                                        <em>${request.user.email}</em> <br>
                                    </p>
                                    <form action="${request.route_path('logout')}" method="POST">
                                        <p class="text-center"><button type="submit" class="btn btn-primary btn-sm">Odhlásiť</button></p>
                                    </form>
                                </div>
							% endif
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</%block>

<%block name="page_content">
    <script src="${request.static_path('project:static/js/lightbox-2.6.min.js')}"></script>

    <div class="page-header text-center">
        <h1 class="text-center">Testingo je lepšie ako čakajúca kopa papierov :)<br>
            <small class="text-center">Jednoduchý systém tvorby online testov s automatickým vyhodnocovaním</small></h1>
    </div>

    <div class="howitwork">
        <div class="wrapper">
            <h2>Ako to funguje?</h2>
            <div class="row">

                <!-- ###   Feature 1 ### -->
                <div class="col-md-4 featu">
                    <div class="icon"> <img src="${request.static_path('project:static/img/icons/Lock.png')}"> </div>
                    <h6> 1. Registrujte sa</h6>
                    <p> Po registrácii získate prístup k vytváraniu testov, ich riešeniu a k užitočným štatistikám </p>
                    <div class="step"><p>Krok 1</p></div>
                </div>

                <!-- ###   Feature 2 ### -->
                <div class="col-md-4 featu">
                    <div class="icon"> <img src="${request.static_path('project:static/img/icons/Dashboard.png')}"> </div>
                    <h6> 2. Vytvorte test</h6>
                    <p> Po vytvorení testu môžete pridávať ľubovoľný počet otázok s rôznymi typmi odpovedí </p>
                    <div class="step"><p>Krok 2</p></div>
                </div>

                <!-- ###   Feature 2 ### -->
                <div class="col-md-4 featu">
                    <div class="icon"> <img src="${request.static_path('project:static/img/icons/Mail3.png')}"> </div>
                    <h6> 3. Zdieľajte test</h6>
                    <p> Keď budete so zadaním spokojní, jednoducho pošlite svoj test svojim respondentom </p>
                    <div class="step"><p>Krok 3</p></div>
                </div>


            </div>
        </div>
    </div>

    <div class="screenshots">
        <h2>Ako to vyzerá?</h2>
        <div class="row">
            <div class="col-md-3">
                <a href="${request.static_path('project:static/img/sshots/st-dashboard.png')}" data-lightbox="Dashboard" class="thumbnail">
                    <img data-src="holder.js/100%x180" src="${request.static_path('project:static/img/sshots/st-dashboard.png')}" alt="">
                </a>
            </div>
			<div class="col-md-3">
                <a href="${request.static_path('project:static/img/sshots/st-newtest.png')}" data-lightbox="Nový test" class="thumbnail">
                    <img data-src="holder.js/100%x180" src="${request.static_path('project:static/img/sshots/st-newtest.png')}" alt="">
                </a>
            </div>
	        <div class="col-md-3">
                <a href="${request.static_path('project:static/img/sshots/st-ncq.png')}" data-lightbox="Nová otázka s viacerými odpoveďami" class="thumbnail">
                    <img data-src="holder.js/100%x180" src="${request.static_path('project:static/img/sshots/st-ncq.png')}" alt="">
                </a>
            </div>
	        <div class="col-md-3">
                <a href="${request.static_path('project:static/img/sshots/st-solve.png')}" data-lightbox="Riešenie testu" class="thumbnail">
                    <img data-src="holder.js/100%x180" src="${request.static_path('project:static/img/sshots/st-solve.png')}" alt="">
                </a>
            </div>
        </div>
    </div>

	<hr>

    <div class="team">
        <h2>Kto je za tým?</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="fotka">
                    <img src="${request.static_path('project:static/img/fotky/basa.jpg')}" alt="Barbora Brocková">
                </div>
                <h4>Barbora Brocková</h4>
            </div>
	        <div class="col-md-4">
                <div class="fotka">
                    <img src="${request.static_path('project:static/img/fotky/adam.jpg')}" alt="Adam Lieskovský">
                </div>
                <h4>Adam Lieskovský</h4>
            </div>
	        <div class="col-md-4">
                <div class="fotka">
                    <img src="${request.static_path('project:static/img/fotky/tomas.jpg')}" alt="Tomáš Vestenický">
                </div>
                <h4>Tomáš Vestenický</h4>
            </div>
        </div>
	    <p class="lead text-center">Sme študenti FIIT STU a Testingo vzniklo ako náš projekt v rámci The Spot Startup Summerschool 2013</p>
    </div>

    <div id="fb-root"></div>
    <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=57820298747";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
</%block>
