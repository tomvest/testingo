// Generated by CoffeeScript 1.6.3
var answer_template, button_template, process_submit;

answer_template = function() {
  return "<label>\n</label> \n<input name=\"checkOdpoved\" type=\"checkbox\" value=\"\">\n<input name=\"odpoved\" id=\"checkboxName\"> <br> ";
};

button_template = function() {
  return "<a class=\"btn btn-default btn-small\" id='submit'> Pridať odpoveď </a> <br> ";
};

process_submit = function() {
  return $('#answer').append(answer_template());
};

$(function() {
  var answer;
  answer = $('#answer');
  answer.html(answer_template());
  answer.html(button_template());
  return $('#submit').click(process_submit);
});

/*
//@ sourceMappingURL=custom.map
*/
