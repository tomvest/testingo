// Generated by CoffeeScript 1.6.3
(function() {
  $(document).ready(function() {
    var host;
    host = window.location.host;
    $("#solved_tests").click(function() {
      return window.location.replace("http://" + host + "/dashboard?tab=3");
    });
    $("#filled_tests").click(function() {
      return window.location.replace("http://" + host + "/dashboard?tab=2");
    });
    return $("#own_tests").click(function() {
      return window.location.replace("http://" + host + "/dashboard?tab=1");
    });
  });

}).call(this);

/*
//@ sourceMappingURL=breadcrumb_redirect.map
*/
