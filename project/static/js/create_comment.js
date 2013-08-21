// Generated by CoffeeScript 1.6.3
(function() {
  var comment_template, hide_process, input_template, process_update;

  input_template = function(text, tu) {
    return "<div class=\"form-group\" id=\"textarea_vykresli" + tu + "\">\n    <label for=\"text\"> Komentár: </label>\n    <textarea class=\"form-control\" name=\"area" + tu + "\" id=\"area" + tu + "\"  rows=\"3\" placeholder=\"Obsah komentára...\" required>" + text + "</textarea>\n    <a href=\"#\" class=\"update_b pull-right\" id=\"ulozit" + tu + "\"> Uložiť </a>\n</div> ";
  };

  comment_template = function(koment, tu) {
    return "<div id=\"koment_text" + tu + "\">\n  Komentár:<br>\n  " + koment + "\n</div>";
  };

  hide_process = function(id, text, event) {
    var q_id;
    event.preventDefault;
    q_id = id.substring(11);
    alert(q_id);
    $("#upravit_btn" + q_id).hide();
    $("#koment_text" + q_id).hide();
    $("#koment_area" + q_id).append(input_template(text, q_id));
    return $("#ulozit" + q_id).click(function() {
      return process_update(q_id, post_url);
    });
  };

  process_update = function(id, post_url) {
    var id_area, id_q, new_comment;
    id_q = id;
    id_area = "area" + id_q;
    new_comment = $("textarea[name='" + id_area + "']").val();
    $.ajax({
      url: post_url,
      type: "POST",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify({
        comment: new_comment,
        id_question: id_q,
        nc: 1
      })
    }).done(function(response) {
      $("#koment_area" + id_q).append(comment_template(new_comment, id_q));
      $("#textarea_vykresli" + id_q).hide();
      return $("#upravit_btn" + id_q).show();
    }).fail(function(response) {
      return console.log(response + "neupdatol som comment");
    });
    return false;
  };

  $(document).ready(function() {
    var ebody;
    ebody = $(".zkomment");
    return $(".zkomment").click(function() {
      return hide_process(this.id, this.name, event);
    });
  });

}).call(this);

/*
//@ sourceMappingURL=create_comment.map
*/
