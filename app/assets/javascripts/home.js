$(document).on('page:load', function() {
  loadCarousel();
  showAjaxCompleteNotification();

});

$(document).ready(function() {
  loadCarousel();
  showAjaxCompleteNotification();

});

var loadCarousel = function(){
  $("#myCarousel").carousel({
    interval: 2000
  });
};

var showAjaxCompleteNotification = function(){
  $(document).ajaxComplete(function(event, request) {
    var msg = request.getResponseHeader('X-Message');
    var type = request.getResponseHeader('X-Message-Type');
    console.log(msg);

    if(msg){
      $("#flash_messages").html(flashMessageHTML(type, msg));
    }
  });
};

var flashMessageHTML = function(type, msg){
  var html = '<div class="alert fade in alert-success"><button class="close" data-dismiss="alert">×</button>' + msg + '</div>';

  return html
};