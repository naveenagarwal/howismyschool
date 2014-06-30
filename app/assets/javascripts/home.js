$(document).on('page:load', function() {
  loadCarousel();
  showAjaxCompleteNotification();
  ajaxLoaderDisplay();
  fadeOutFlashMessages();

});

$(document).ready(function() {
  loadCarousel();
  showAjaxCompleteNotification();
  ajaxLoaderDisplay();
  fadeOutFlashMessages();

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

    if(msg){
      $("#flash_messages").html(flashMessageHTML(type, msg));
      fadeOutFlashMessages();
    }
  });
};

var flashMessageHTML = function(type, msg){
  if(type == "notice" || type == "success"){
    type = "success";
  }else if(type == "alert" || type == "error"){
    type = "error";
  }

  var html = '<div class="alert fade in alert-' + type + '"><button class="close" data-dismiss="alert">×</button>' + msg + '</div>';

  return html
};


var ajaxLoaderDisplay = function(){
  $(document).bind("ajaxSend", function(){
    $("#ajax-loader").show();
  }).bind("ajaxComplete", function(){
    $("#ajax-loader").hide();
  });
};


var fadeOutFlashMessages = function(){
  setTimeout(function() {
    $("div.alert").removeClass("in");
    $("div.alert button.close").trigger("click");
  }, 2000);
};