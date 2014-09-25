var closeOpenMenus = function(){
  $(".dropdown-menu").hide();

  if($("#leftpanelDiv").is(":visible")){
    $("a#left-boxDiv").trigger("click");
  }
};

$(document).ready(function(){


  $(document).on("click", "a.tabs", function(){
    var el = $(this);

    $(".tab-pane").removeClass("active");
    $("ul.nav-tabs li").removeClass("active");
    $(el.attr("href")).addClass("active");
    el.parent().addClass("active");

  });

  $(document).on("click", ".product", function(){
    var product = $(this);
    $(".product").removeClass("product-active");
    $(this).addClass("product-active");
    $('.tabs:last').click();
    AccurateImage.renderProductData(parseInt(product.data("product_index") ) );
  });

  $(document).on("click", ".mortar-manufacturer", function(){
    var mortar_manufacturer = $(this);
    $(".mortar-manufacturer").removeClass("mortor-manufacturer-active");
    $(this).addClass("mortor-manufacturer-active");

    AccurateImage.setSelectedMortarManufacturer(parseInt(mortar_manufacturer.data("mortar_manufacturer_index") ) );
    AccurateImage.renderMortars();
  });

  $(document).on("click", ".mortar", function(){
    var mortar = $(this);
    $(".mortar").removeClass("mortar-active");
    $(this).addClass("mortar-active");

    AccurateImage.setSelectedMortar(parseInt(mortar.data("mortar_index") ) );
  });

  $(document).on("click", ".brick-type", function(){
    var brickType = $(this);
    $(".brick-type").removeClass("brick-type-active");
    $(this).addClass("brick-type-active");

    AccurateImage.setSelectedBrickType(parseInt(brickType.data("brick_type_index") ) );
    AccurateImage.renderPlants();

  });

  $(document).on("click", ".plant", function(){
    var plant = $(this);
    $(".plant").removeClass("plant-active");
    $(this).addClass("plant-active");

    AccurateImage.setSelectedPlant(parseInt(plant.data("plant_index") ) );
    AccurateImage.renderTextures();
  });

  $(document).on("click", ".texture", function(){
    var texture = $(this);
    $(".texture").removeClass("texture-active");
    $(this).addClass("texture-active");

    AccurateImage.setSelectedTexture(parseInt(texture.data("texture_index") ) );
    AccurateImage.renderColors();
  });

  $(document).on("click", ".color", function(){
    var color = $(this);
    $(".color").removeClass("color-active");
    $(this).addClass("color-active");

    AccurateImage.setSelectedColor(parseInt(color.data("color_index") ) );
    AccurateImage.renderBricks();
  });

  $(document).on("click", ".brick", function(){
    var brick = $(this);
    $(".brick").removeClass("brick-active");
    $(this).addClass("brick-active");
    AccurateImage.setSelectedBrick(parseInt(brick.data("brick_index") ) );
  });

  $(document).on("click", "#file-new-design", function(){
    AccurateImage.createNewDesign();
  });

  $(document).on("click", ".coursing", function(){
    var coursing = $(this).data("coursing");
    $(".coursing").parent().removeClass("active");
    $(this).parent().addClass("active");
    AccurateImage.setSelectedCoursing(coursing);
    closeOpenMenus();
  });

  $(document).on("click", "a.select-wall-type", function(){
    var wallDimension = $(this).data("wall_type");
    AccurateImage.selectedWallDimesions = wallDimension;

    $("#full-wall").fadeOut('fast', function(){
      AccurateImage.drawDefaultWall();
    }).fadeIn();

    AccurateImage.pushChangeToUndoRedoStack();
    closeOpenMenus();
  });

  $(document).on("click", "span.item", function(){
    if($("#AIMenu").is(":visible")){
      return;
    }

    var el = $(this);

    el.fadeOut('fast', function(){
      AccurateImage.handleItemClick(el);
    }).fadeIn();

    AccurateImage.enableContextMenu();
    AccurateImage.pushChangeToUndoRedoStack();
  });

  $(document).on("click", "a#save_as_image", function(){
    AccurateImage.saveAsImage();
  });

  $(document).on("click", ".zoom", function(){
    if($(this).hasClass("zoom-in")){
      AccurateImage.zoomWallInAndOut(true, false);
    }else{
      AccurateImage.zoomWallInAndOut(false, true);
    }
  });

  $(document).on("click", ".select-stagger", function(){
    var stagger = parseInt($(this).data("stagger"));
    $(".select-stagger").parent().removeClass("active");
    $(this).parent().addClass("active");

    $("#full-wall").fadeOut('fast', function(){
      AccurateImage.staggerWallBy(stagger);
    }).fadeIn();

    AccurateImage.pushChangeToUndoRedoStack();
    closeOpenMenus();
  });

  $(document).on("click", "#undo", function(){
    if(AccurateImage.currentUndoRedoLevel <= 0){
      return;
    }

    $("#full-wall").fadeOut('fast', function(){
      AccurateImage.undo();
    }).fadeIn();
  });

  $(document).on("click", "#redo", function(){
    if(AccurateImage.currentUndoRedoLevel == (AccurateImage.undoRedoStack.length - 1)){
      return;
    }

    $("#full-wall").fadeOut('fast', function(){
      AccurateImage.redo();
    }).fadeIn();
  });

  $(document).on("submit", "form#customWallForm", function(evt){
    evt.preventDefault();
    var wallDimension = $("#x").val() + "x" + $("#y").val();
    AccurateImage.selectedWallDimesions = wallDimension;

    $("#full-wall").fadeOut('fast', function(){
      AccurateImage.drawDefaultWall();
    }).fadeIn();

    AccurateImage.pushChangeToUndoRedoStack();
    $(".close-btn").trigger("click");

    closeOpenMenus();
    return false;
  });

  $(document).on("click", "#file-save-image", function(){
    $("#save-image-sublinks").toggle();
  });

  $(document).on("click", "#file-save-image-seamless", function(){
    AccurateImage.createSeamlessWall();
  });

  $(document).on("click", ".reset-mortor", function(){
    $("#full-wall").fadeOut('fast', function(){
      AccurateImage.fillMortarFull();
    }).fadeIn();

    AccurateImage.pushChangeToUndoRedoStack();
    closeOpenMenus();
  });

  $(document).on("click", "a.fill-random", function(){
    var fillPercentage = parseInt($(this).data("percent"));

    // $("#full-wall").fadeOut('fast', function(){
    AccurateImage.fillRandom(fillPercentage);
    // }).fadeIn();

    AccurateImage.pushChangeToUndoRedoStack();
    closeOpenMenus();
  });

  $(document).on("click", "#size-tool", function(){
    AccurateImage.sizeTool();
  });

  $(document).on("submit", "form#size_tool_form", function(evt){
    evt.preventDefault();

    var width = parseInt($("#size_tool_width").val()),
        height = parseInt($("#size_tool_height").val()),
        dimensionType = parseInt($("#size_tool_dimension_type").val()),
        bricksRequired = AccurateImage.sizeToolConvert(width, height, dimensionType);

    $("#total-brikcs-required").html(bricksRequired);

    return false;
  });

  $(document).on("click", "#manufacturers_list_tab", function(){
    $("#brick_list_container, #brick_type_list_container, #mortor_list_container").niceScroll().hide();
  });

  $(document).on("click", "#manufacturers_prodcuts_list_tab", function(){
    $("#brick_list_container, #brick_type_list_container, #mortor_list_container").niceScroll().show();
  });

  $(document).on("click", ".items-toggler", function(){
    var el = $(this);
    el.parent().next().toggle();

    if(el.parent().next().is(":visible")){
      el.find("i:first").removeClass("plus-icon");
      el.find("i:first").addClass("active-submenu");
    }else{
      el.find("i:first").removeClass("active-submenu");
      el.find("i:first").addClass("plus-icon");
    }

  });

});