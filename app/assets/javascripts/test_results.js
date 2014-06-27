
var clearFields = function(){
  $('.clear_fields').each(function(){
    var element = $(this);
    var type = element.prop("type");

    if(type === "checkbox" || type === "radio"){
      element.removeAttr("checked");
    }
    else if(type === "select-one"){
      element.prop('selectedIndex', 0)
    }else{
      element.val('');
    }

  });
};