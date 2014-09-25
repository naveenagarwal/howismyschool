var Application = {

  fetchProducts: function(callback, callbackOn, selectFirstProduct) {
    $.ajax({
      url: jsURL + "product-management/GetProducts",
      data: { ajax: 1 },
      dataType: "JSON",
      success: function(result){
        if(typeof(callback) == "function"){
          callback.call(callbackOn, JSON.parse(result.products));
          if(selectFirstProduct){
            $(".product:first").trigger("click");
            //AccurateImage.setBodyToOnlyWall();
          }
        }
      },
      error: function(error){
        console.log(error);
        alert("Error: Could not fetch the products at the moment, please try after sometime.");
      }
    })
  }

}