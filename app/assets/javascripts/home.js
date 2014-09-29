$(document).on('page:load', function() {
  loadCarousel();
  showAjaxCompleteNotification();
  ajaxLoaderDisplay();
  fadeOutFlashMessages();
  initializeSelectOptions();
  initializeSelectOptionsForAjax();
  initializeSubmitNavBarSearchForm();
  highlightText();
  Student.initializeStudentScoreCharts();
  initializeDateTimePicker();
  loadStudentsOnClassRoomSelectForLookUp();
  classRoomCompleteTestResultsToggler();
  loadStudentsOnClassRoomSelectForCompare();
  checkStudentOnStudentSelectForCompare();

});

$(document).ready(function() {
  loadCarousel();
  showAjaxCompleteNotification();
  ajaxLoaderDisplay();
  fadeOutFlashMessages();
  initializeSelectOptions();
  initializeSelectOptionsForAjax();
  initializeSubmitNavBarSearchForm();
  highlightText();
  Student.initializeStudentScoreCharts();
  initializeDateTimePicker();
  loadStudentsOnClassRoomSelectForLookUp();
  classRoomCompleteTestResultsToggler();
  loadStudentsOnClassRoomSelectForCompare();
  checkStudentOnStudentSelectForCompare();

  // var selectedAnswerType;
  // $(document).on("change", "select.answer-type", function(){
  //   $("#last_selected_answer_type").val($(this).data("count"));
  //   selectedAnswerType = $(this);

  //   var val = parseInt($(this).val());
  //   var count = $("#last_selected_answer_type").val();
  //   var el = $(".answer-choices-" + count);

  //   if(val < 2){
  //     $("#answer_type_modal_" + val).modal('show');
  //   }else{
  //     el.html("<br />");
  //     el.append('<textarea placeholder="Student will write the answer here" name="qa[]['+ $("#last_selected_answer_type").val() +'][answer_choices][0]"></textarea>');
  //   }
  // });

  // $(document).on("click", ".add_more_multiple_choices", function(){
  //   var inputType = selectedAnswerType.find("option:selected").text() == "Single choice" ? "radio" : "checkbox";
  //   $('<div><input type="text" class="multiple-choices-input-'+inputType+'"><a href="javascript:void(0);" class="remove-multiple-choice">Remove</a><br></div>').insertBefore($(this));
  // });

  // $(document).on("click", "a.remove-multiple-choice", function(){
  //   $(this).parent().remove();
  // });

  // $(document).on("click", ".add_multiple_choice", function(){
  //   var count = $("#last_selected_answer_type").val();
  //   var el = $(".answer-choices-" + count);
  //   var inputType = selectedAnswerType.find("option:selected").text() == "Single choice" ? "radio" : "checkbox";
  //   el.html("<br />");

  //   $(".multiple-choices-input-" + inputType).each(function(index){
  //     var choice = $.trim($(this).val());
  //     if(choice.length > 0){
  //       if(inputType == "checkbox"){
  //         el.append('<input type="'+ inputType +'" name="qa[]['+ $("#last_selected_answer_type").val() +'][answer_choices]['+ index +']">&nbsp;&nbsp;&nbsp;' + choice + '<br />');
  //       }else{
  //         el.append('<input type="'+ inputType +'" name="qa[]['+ $("#last_selected_answer_type").val() +'][answer_choices][0]">&nbsp;&nbsp;&nbsp;' + choice + '<br />');
  //       }

  //     }
  //     if(index > 0){
  //       $(this).parent().remove();
  //     }
  //   });
  //   $(".modal").modal('hide');
  // });


});

var loadStudentsOnClassRoomSelectForLookUp = function(){
  $(document).on('change', 'select#lookup_class_room_select', function(){
    var url = '/look_ups/class_room_students?class_room=' + $(this).val();
    $.ajax({
      url: url,
      dataType: 'script'
    });
  });
};

var loadStudentsOnClassRoomSelectForCompare = function(){
  $(document).on('change', 'select#compare_class_room_select', function(){
    var url = '/compare/class_room_students?class_room=' + $(this).val();
    $.ajax({
      url: url,
      dataType: 'script'
    });
  });
};

var checkStudentOnStudentSelectForCompare = function(e){
  $(document).on('change', 'select.compare_student_select', function(){
    if($("select#comapre_student_1_select").val() == $("select#comapre_student_2_select").val()){
      bootbox.alert("Please select different students for comparison.");
      $("form#compare_form input[type=submit]").attr("disabled", true);
      return false;
    }else{
      $("form#compare_form input[type=submit]").removeAttr("disabled");
      return true;
    }
  });
};

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

var initializeSelectOptions = function(){
  if($(".select2").length > 0){
    $(".select2").select2("destroy")
    $(".select2").select2();
  }
};

var initializeSelectOptionsForAjax = function(){
  $(document).ajaxComplete(function(event, request) {
    initializeSelectOptions();
  });
};

var initializeSubmitNavBarSearchForm = function(){
  $(".searchbar-custom").click(function(){
    $("form#navigation_searchbar").trigger("submit");
  });

  $("form#navigation_searchbar").submit(function(e){
    e.preventDefault();
  });

}

var highlightText = function(){
  $(document).ajaxComplete(function(event, request) {
    var searhQuery = request.getResponseHeader('x-search-term');
    if(searhQuery){
      searchHighlightText(searhQuery);
    }
  });
};

var searchHighlightText = function(text){
  var html  = $("search-container list-group-item-text").html();
  var matchedText = "";
  var regex = "";

  text      = text.split(/\s+/);

  $("p.list-group-item-text").each(function(){
    var html = $(this).html();
    for(var i=0; i < text.length; i++){
      regex = new RegExp(text[i], "ig");
      matchedText = html.match(regex);

      if(matchedText){
        for(var j=0; j < matchedText.length; j++){
          regex = new RegExp(matchedText[j], "g");
          html = html.replace(regex, '<span class="search-highlight">' + matchedText[j] + '</span>');
        }
      }
    }

    $(this).html(html);
  });

};

var initializeDateTimePicker = function(){
  if($(".datetimepicker-initialize").length > 0){
    $(".datetimepicker-initialize").datetimepicker({
      language: 'en',
      pick12HourFormat: true
    });
  }
};

var classRoomCompleteTestResultsToggler = function() {
  $(document).on("click", "#complete_test_results_toggler", function(){
    if($("#complete_test_results_container").length > 0){
      $("#complete_test_results_container").toggle();
    }
  });
}