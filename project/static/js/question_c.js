// Generated by CoffeeScript 1.6.3
(function(){var e,t,n,r,i,s,o;i=1;e=function(){return'<div class="answerblock">\n<input class="checkInputC" name="check'+i+'" type="checkbox" value="">\n<input name="text'+i+'" class="checkInput form-control">\n<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>\n</div>'};t=function(){return"<a class=\"btn btn-default btn-sm\" id='submit'> Pridať odpoveď </a> <br>"};s=function(){$("#answer").append(e());i++;return o()};o=function(){var e;return e=$(".checkInput").length};n=function(e){return $(e.target).parent().remove()};r=function(e){var t,n,r,i;$("#form_c").validate({rules:{text:{required:!0},points:{number:!0}},messages:{text:"Prosím zadajte text otázky",points:{number:"Body musia byť číslo"}}});if($("#form_c").valid()){i=$("textarea[name='text']").val();n=$("input[name='points']").val();t=$("input.checkInput").serializeArray();r=$("input.checkInputC").serializeArray();$.ajax({url:post_url,type:"POST",contentType:"application/json; charset=utf-8",data:JSON.stringify({text:i,points:n,answers:t,correctness:r})}).done(function(t){return top.location.href=e}).fail(function(e){return console.log(e)})}return!1};$(document).ready(function(){var e,i,o,u,a;e=$("#answer");e.html(t());$("#submit").click(s);$("#answer").on("click",".delete-button",n);$("#form_c").submit(function(){return!1});a=test_url+"/new-phrase-question";i=test_url+"/new-checkbox-question";u=test_url+"/new-radio-question";o=test_url+"/new-open-question";$("#save_and_add_s").click(function(){return r(a)});$("#save_and_add_c").click(function(){return r(i)});$("#save_and_add_r").click(function(){return r(u)});$("#save_and_add_o").click(function(){return r(o)});return $("#save_and_end").click(function(){return r(test_url)})})}).call(this);