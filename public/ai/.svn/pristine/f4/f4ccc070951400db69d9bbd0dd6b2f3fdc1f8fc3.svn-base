$(document).ready(function() {

  function hidePopUp(){
    $(".close-btn").trigger("click");
    $(".dropdown-menu").hide();
  }

  $(document).on('click', '#logout', function() {
    User.logout();
  });

  $(document).on('click', '#open_list', function() {
    User.openList();
  });

  $(document).on('click', '#file-save-design', function() {
    User.saveDesign();
  });

  $(document).on("submit", "form#login_form", function(evt){
    evt.preventDefault();
    //if(User.validateLogin()) {
      User.login();
      hidePopUp();
    //}
    return false;
  });

  $(document).on("click", "#user_register", function(){
    $("#login_form_input_container").html();
    $("#login_form_input_container").html(User.createRegisterHTML());
    $(".sign-up-title").text('Register');
    $("#user_register").hide();
    $("#user_login").removeClass("hide");
    $(".login-field").remove();
    $("#login_btn").val("Register");
    $('#lightbox-content').css({  });
  });

  $(document).on("click", "#user_login", function(){
    $("#login_form_input_container").html();
    $("#login_form_input_container").html(User.loginFieldsHTML());
    $(".sign-up-title").text('Login');
    $("#user_register").show();
    $("#user_login").addClass("hide");
    $(".registration-field").remove();
    $("#login_btn").val("Login");
    $('#lightbox-content').css({height: "200px", overflow: "none" });
  });

  $(document).on("click", ".open-design-for-edit", function(){
    var designId = $(this).data("design_id");
    User.openDesignForEdit(designId);
    hidePopUp();
  });

  $(document).on("click", "#save-seamless-wall", function(){
    User.saveSeamlessDesign();
  });

  $(document).on("click", "#file-save-image-wall", function(){
    User.saveDesignImage();
  });

  $(document).on("click", "#print-design", function(){
    User.printWall();
  });

  $(document).on("click", "#bring-back-toolbar", function(){
    closeOpenMenus();
    $("#top-tool-bar").fadeIn(500);
    $("#bring-back-toolbar").addClass("hide");
  });

  $(document).on("click", "#tool-bar-hide", function(){
    closeOpenMenus();
    $("#top-tool-bar").fadeOut(500, function(){
      $("#bring-back-toolbar").removeClass("hide");
    });
  });

});