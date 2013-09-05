// Generated by CoffeeScript 1.6.1
(function() {
  var form_submit;

  form_submit = function(post_url) {
    $('#form_editPD').validate({
      rules: {
        user_name: {
          required: true
        },
        email: {
          required: true
        }
      },
      messages: {
        user_name: {
          required: "Prosím zadajte Vaše meno a priezvisko"
        },
        email: {
          required: "Prosím zadajte Váš platný e-mail"
        }
      }
    });
    if ($('#form_editPD').valid()) {
      $.ajax({
        url: post_url,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
          user_name: $("#user_name").val(),
          email: $("#email").val(),
          con: 1
        })
      }).done(function(response) {
        return console.log("Done");
      }).fail(function(response) {
        return console.log(response);
      });
      return false;
    }
  };

  $(document).ready(function() {
    return $('#submit_data').click(function() {
      return form_submit(post_url);
    });
  });

}).call(this);
