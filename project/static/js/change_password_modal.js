// Generated by CoffeeScript 1.6.3
(function() {
  var fail_template, form_submit, remove_alert, succes_alert, success_template;

  success_template = function() {
    return "<div class=\"alert alert-success alert-dismissable\">\n<button type=\"button\" id =\"success_alert_closer\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>\n<p>Zmena hesla prebehla úspešne. Návrat na <a href=\"${request.route_path('profile')}\"><strong>Profil</strong></a></p>\n</div>";
  };

  fail_template = function() {
    return "<div id=\"wrong_password\" class=\"alert alert-danger alert-dismissable\">\n<button type=\"button\" id =\"alert_closer\"class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>\n<p>Zadal si nesprávne heslo, skús znovu</p>\n</div>";
  };

  remove_alert = function() {
    $("#alert_closer").click();
    return false;
  };

  succes_alert = function() {
    $('#error_alert').append(success_template());
    return setTimeout((function() {
      return window.location.href = post_url;
    }), 1500);
  };

  form_submit = function(post_url) {
    jQuery.validator.addMethod("notEqual", (function(value, element, param) {
      return this.optional(element) || value !== $(param).val();
    }), "Nové heslo musí byť odlišné od pôvodného");
    $('#form-change_password').validate({
      rules: {
        password: {
          required: true
        },
        password_repeat: {
          required: true,
          equalTo: "#new_password"
        },
        new_password: {
          required: true,
          minlength: 6,
          notEqual: "#current_password"
        }
      },
      messages: {
        password: {
          required: "Prosím zadajte vaše aktuálne heslo"
        },
        password_repeat: {
          required: "Prosím zadajte opätovne nové heslo ",
          equalTo: "Heslá sa nezhodujú",
          notEqual: "Nové heslo musí byť odlišné od pôvodného"
        },
        new_password: {
          required: "Prosím zadajte nové heslo",
          minlength: "Heslo musí mať aspoň 6 znakov"
        }
      }
    });
    if ($('#form-change_password').valid()) {
      $.ajax({
        url: post_url,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
          current_password: $("#current_password").val(),
          new_password: $("#new_password").val(),
          new_password2: $("#password_repeat").val(),
          con: 0
        }),
        success: function(response) {
          if (response['errors']) {
            $('#error_alert').append(fail_template());
          } else {
            succes_alert();
          }
          return false;
        }
      }).done(function(response) {
        return console.log("Done");
      }).fail(function(response) {
        return console.log(response);
      });
      return false;
    }
  };

  $(document).ready(function() {
    return $('#submit').click(function() {
      remove_alert();
      return form_submit(post_url);
    });
  });

}).call(this);
