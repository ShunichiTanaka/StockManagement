// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
// require bootstrap
// require bootstrap-material-design
//
//= require jquery
//= require jquery_ujs
//= require_tree
//= require turbolinks
//= require admin-lte/bootstrap/js/bootstrap
//= require admin-lte/dist/js/app
//= require moment
//= require bootstrap-datetimepicker
//= require chart.js/dist/Chart.js

$(function() {
  var $body = $("body");
  var controller = $body.data("controller").replace(/\//g, "_");
  var action = $body.data("action");

  var activeController = StockManagement[controller]

  if (activeController !== undefined) {
    if ($.isFunction(activeController[action])) {
      activeController[action]();
    }
  }

  $("input.datepicker").datetimepicker({
    format: "yyyy/MM/dd",
    icons: {
            previous: "fa fa-arrow-left",
            next: "fa fa-arrow-right"
           }
  });
});
