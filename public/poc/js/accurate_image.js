var HALF = 2,
    ONE_THIRD = 3,
    NONE = 0;

var staggerArray = [NONE, HALF, ONE_THIRD];

var AccurateImage = {
  products: null,
  currentProduct: null,
  drawProduct: null,
  selectedProduct: null,
  selectedMortar: null,
  initialSelectedMortar: null,
  selectedBrick: null,
  initialSelectedBrick: null,
  selectedBrickType: null,
  productIndex: null,
  currentMortar: null,
  mortarIndex: null,
  currentBrickType: null,
  brickTypeIndex: null,
  currentBrick: null,
  brickIndex: null,
  rowNumber: null,
  defaultZoomSize: 1,
  selectedZoomSize: 1,
  currentStagger: HALF,
  selectedStagger: HALF,
  selectedWallDimesions: null,
  undoRedoStackMaxLevel: 11,
  currentUndoRedoLevel: -1,
  undoRedoStack: [],

  baseUnit: 1, // in pxels
  inchPixels: 32, // one inch is 32 pixles

  pushChangeToUndoRedoStack: function(){
    // console.log(this.undoRedoStack.length);
    var html = $("#full-wall").html();

    if(this.undoRedoStack.length == 0){
      this.currentUndoRedoLevel = 0;
      this.undoRedoStack[this.currentUndoRedoLevel] = html;
      return;

    }else if(this.undoRedoStack.length == this.undoRedoStackMaxLevel){
      if(html != this.undoRedoStack[this.undoRedoStackMaxLevel - 1]){
        this.undoRedoStack.shift();
        this.undoRedoStack[this.undoRedoStackMaxLevel - 1] = html;
        this.currentUndoRedoLevel = this.undoRedoStackMaxLevel - 1;
      }

    }else if(this.undoRedoStack.length > 0  && this.undoRedoStack.length < this.undoRedoStackMaxLevel ){
      console.log(html != this.undoRedoStack[this.currentUndoRedoLevel]);
      if(html != this.undoRedoStack[this.currentUndoRedoLevel]){
        this.currentUndoRedoLevel++;
        this.undoRedoStack[this.currentUndoRedoLevel] = html;
        this.undoRedoStack.length = this.currentUndoRedoLevel + 1;
      }
    }
  },

  undo: function(){
    if(this.currentUndoRedoLevel <= 0){
      return;
    }

    this.currentUndoRedoLevel--;
    $("#full-wall").html(this.undoRedoStack[this.currentUndoRedoLevel]);
  },

  redo: function(){
    if(this.currentUndoRedoLevel == (this.undoRedoStack.length - 1) ){
      return;
    }
    this.currentUndoRedoLevel++;
    $("#full-wall").html(this.undoRedoStack[this.currentUndoRedoLevel]);
  },

  notDefinedProducts: function(){
    if(typeof(this.products) === "undefined" || this.products == null){
      return true;
    }else{
      return false;
    }
  },

  notDefined: function(element){
    if(typeof(element) === "undefined" || element == null){
      return true;
    }else{
      return false;
    }
  },

  clearSelectedBrick: function(){
    this.selectedBrick = null;
  },

  clearProductSelected: function(){
    this.selectedProduct = null,
    this.selectedMortar = null,
    this.selectedBrickType = null,
    this.clearSelectedBrick();
  },

  productListHtml: function(){
    return  '\
              <div class="product">\
                <div>'+ this.currentProduct.name +'</div>\
                <a href="javascript:void(0)" class="product" data-product_index="'+ this.productIndex +'" data-product_id="'+ this.currentProduct.id+ '" >\
                  <img src="' + this.currentProduct.imgUrl + '" />\
                </a>\
              </div>\
            ';
  },

  mortarsListHtml: function(){
    return  '\
              <div class="mortar">\
                <div>'+ this.currentMortar.name +'</div>\
                <a href="javascript:void(0)" class="mortar" data-mortar_index="'+ this.mortarIndex +'" data-mortar_id="'+ this.currentMortar.id +'" >\
                  <img src="' + this.currentMortar.imgUrl + '" />\
                </a>\
              </div>\
            ';

  },
  brickTypesListHtml: function(){
    return  '\
              <div class="brick-type">\
                <div>'+ this.currentBrickType.name +'</div>\
                <a href="javascript:void(0)" class="brick-type" data-brick_type_index="'+ this.brickTypeIndex +'" data-brick_type_id="'+ this.currentBrickType.id +'" >\
                  <img src="' + this.currentBrickType.imgUrl + '" />\
                </a>\
              </div>\
            ';
  },
  innerDivstyleCalc: function(){
    return this.selectedMortar.top + "px " + this.selectedMortar.right + "px " + this.selectedMortar.bottom + "px " + this.selectedMortar.left + "px;";
  },
  innerDivstyle: function(){
    return "margin:" + this.innerDivstyleCalc();
  },
  brickImgStyle: function(){
    return "height:" + this.selectedBrick.height + "px; width:" + this.selectedBrick.width + "px;";
  },
  bricksListHtml: function(){
    return  '\
              <div class="brick">\
                <div>'+ this.currentBrick.name +'</div>\
                <a href="javascript:void(0)" class="brick" data-brick_index="'+ this.brickIndex +'" data-brick_id="'+ this.currentBrick.id +'" >\
                  <img src="' + this.currentBrick.imgUrl + '" />\
                </a>\
              </div>\
            ';
  },

  renderEvenWallHtml: function(elementPosition){
    return  '\
              <span class="item" data-row="'+ this.rowNumber +'" data-brick_index="'+ elementPosition +'" data-image_id="'+ this.selectedBrick.id +'">\
                <span style="'+ this.innerDivstyle() +'">\
                  <img style="'+ this.brickImgStyle() +'" src="'+ this.selectedBrick.imgUrl +'">\
                </span>\
              </span>\
            ';
  },

  staggeredFirstElementStyle: function(){
    var pixels = "",
        width ;


    if(this.selectedStagger == NONE){
      return "";
    }else{
      width = this.selectedBrick.width + this.selectedMortar.left + this.selectedMortar.right;
      pixels = (width / this.selectedStagger);
    }

    return "margin-left:-" + pixels + "px";
  },

  staggeredLastElementStyle: function(){
    var pixels = "",
        width,
        difference;

    if(this.selectedStagger == NONE){
      return "";
    }else{
      width = this.selectedBrick.width + this.selectedMortar.left + this.selectedMortar.right;
      pixels = (width / this.selectedStagger);
    }

    return "overflow:hidden;width:" + pixels + "px";
  },

  staggeredElementStyle: function(elementPosition){
    var positionX = parseInt(elementPosition.split("-")[1]);
    var firstElement = (positionX == 0) ? true : false;
    var lastElement = (this.dimensionX == positionX) ? true : false;
    var style = "";

    if(firstElement){
      style = this.staggeredFirstElementStyle();
    }
    if(lastElement){
      style = this.staggeredLastElementStyle();
    }

    return style;
  },


  renderOddWallHtml: function(elementPosition){
    if(this.currentStagger == NONE){
      return this.renderEvenWallHtml(elementPosition);
    }else{
      var style = this.staggeredElementStyle(elementPosition);
    }
    return  '\
              <span style="'+ style +'" class="item" data-row="'+ this.rowNumber +'" data-brick_index="'+ elementPosition +'" data-image_id="'+ this.selectedBrick.id +'">\
                <span style="'+ this.innerDivstyle() +'">\
                  <img style="'+ this.brickImgStyle() +'" src="'+ this.selectedBrick.imgUrl +'">\
                </span>\
              </span>\
            ';
  },

  renderBreakWallBrickHtml: function(){
    return  '\
              <div class="clear"><div>\
            ';
  },

  renderWallBrick: function(evenRow, elementPosition, rowContainer){
    if(evenRow){
      rowContainer.append(this.renderEvenWallHtml(elementPosition));
    }else{
      rowContainer.append(this.renderOddWallHtml(elementPosition));
    }
  },

  fillMortarFull: function(){
    $(".item").css('background-image', 'url("'+ this.selectedMortar.fillImage +'")');
    $(".item").css('background-repeat', 'repeat');
    $(".item > span").attr('style', this.innerDivstyle());
  },

  fillBricksFull: function(){
    $(".item > span > img").attr('src', this.selectedBrick.imgUrl);
  },

  fillRowBricks: function(){
    $('.row-' + this.rowNumber + ' .item > span > img').attr('src', this.selectedBrick.imgUrl);
  },

  fillRowEvenBricks: function(){
    $('.row-' + this.rowNumber + ' .item:nth-child(odd) > span > img').attr('src', this.selectedBrick.imgUrl);
  },

  fillRowMortar: function(){
    $('.row-' + this.rowNumber +  ' .item').css('background-image', 'url("'+ this.selectedMortar.fillImage +'")');
    $('.row-' + this.rowNumber +  ' .item').css('background-repeat', 'repeat');
    $('.row-' + this.rowNumber +  ' .item > span').attr('style', this.innerDivstyle());
  },

  fillRowEvenMortar: function(){
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd)').css('background-image', 'url("'+ this.selectedMortar.fillImage +'")');
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd)').css('background-repeat', 'repeat');
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd) > span').attr('style', this.innerDivstyle());
  },

  fillMortarItem: function(item){
    item.css('background-image', 'url("'+ this.selectedMortar.fillImage +'")');
    item.css('background-repeat', 'repeat');
    item.find("span:first").attr('style', this.innerDivstyle());
  },

  fillBrickItem: function(item){
    item.find("img:first").attr('src', this.selectedBrick.imgUrl);
  },

  fillRow: function(){
    this.fillRowBricks();
    this.fillRowMortar();
  },

  fillEven: function(){
    this.fillRowEvenBricks();
    this.fillRowEvenMortar();
  },

  staggerRowNone: function(){
    if($(".row-" + this.rowNumber + " span.item").length > this.dimensionX){
      $(".row-" + this.rowNumber + " span.item").each(function(index){
        if(index >= AccurateImage.dimensionX ){
          $(this).remove();
        }
      });
    }

    $(".row-" + this.rowNumber + " span.item:first").css("margin-left", "0");
  },
  staggerRow: function(){
    this.staggerRowNone();

    // create new first element and prepend it to the row
    var rowContainer = $(".row-" + this.rowNumber),
        elementPosition = this.rowNumber + "-0";

    var width = $(".row-" + this.rowNumber + " span:first img:first").width() + parseInt($(".row-1 span:first span:first").css("margin-left")) + parseInt($(".row-1 span:first span:first").css("margin-right")) ;

    var style = $(".row-" + this.rowNumber + " span:first").attr("style");
    style += 'margin-left:-'+ (width / this.selectedStagger ) +'px; ';


    var html = "<span style='" + style + "' class='item' data-row='"+ this.rowNumber +"' data-brick_index='"+ elementPosition +"' data-image_id='"+ ($(".row-" + this.rowNumber + " span:first").data("image_id") )+"'>";
    html += $(".row-" + this.rowNumber + " span:first").html();
    html += "</span>";

    rowContainer.prepend(html);

    // Change the last element style
    style = $(".row-" + this.rowNumber + " span.item:last").attr("style");
    style += " width:" + (width / this.selectedStagger ) + "px; overflow: hidden;";


    $(".row-" + this.rowNumber + " span.item:last").attr("style", style);

    //Correct the data-brick_index value
    $(".row-" + this.rowNumber + " span.item").each(function(index){
      $(this).data("brick_index", this.rowNumber + "-" + index);
    });

    this.enableContextMenu();

  },

  staggerRowHalf: function(){
    this.selectedStagger = HALF;
    this.staggerRow();
  },

  staggerRowOneThird: function(){
    this.selectedStagger = ONE_THIRD;
    this.staggerRow();
  },

  enableContextMenu: function(){
    $(".item").contextMenu({
      menu: 'AIMenu'
      }, function(action, el, pos) {
        AccurateImage.rowNumber = parseInt(el.parent().data("row"));
        AccurateImage[action]();
    });
  },

  calulateRowWidth: function(){
    return (this.dimensionX * (this.selectedBrick.width + this.selectedMortar.left + this.selectedMortar.right));
  },

  calulateRowHeight: function(){
    return this.selectedBrick.height + this.selectedMortar.top + this.selectedMortar.bottom;
  },

  drawWall: function(){
    var elementPosition,
        evenRow,
        rowContainer,
        wallContainer = $("#full-wall");

    wallContainer.html("");

    this.initialSelectedBrick = this.selectedBrick;
    this.initialSelectedMortar = this.selectedMortar;

    for(var i=0; i < this.dimensionY; i++){
      this.rowNumber  = i;
      evenRow         = i%2 == 0 ? true : false;
      rowContainer    = $('<span style="width: '+ this.calulateRowWidth() +'px; height:'+ this.calulateRowHeight() +'px;" class="row row-'+ (i + 1) +'" data-row="'+ (i + 1) +'"></span>');

      for(var j=0; j < this.dimensionX; j++){
        elementPosition = i + "-" + j;
        this.renderWallBrick(evenRow, elementPosition, rowContainer);

        if(!evenRow && this.selectedStagger != NONE && (j+1) == this.dimensionX){
          ++j;
          elementPosition = i + "-" + j;
          this.renderWallBrick(evenRow, elementPosition, rowContainer);
        }

      }

      wallContainer.append(rowContainer);
      wallContainer.append(this.renderBreakWallBrickHtml());

    }
    this.fillMortarFull();
    this.rowNumber = null;
    this.enableContextMenu();
  },

  drawDefaultWall: function(){
    if(this.notDefined(this.selectedBrick)){
      alert("Please select the brick first");
      return;
    }
    var dimensions = this.selectedWallDimesions.split("x");

    this.dimensionX = parseInt(dimensions[0]);
    this.dimensionY = parseInt(dimensions[1]);

    // this.currentStagger = this.selectedStagger = ONE_THIRD;

    this.drawWall();
  },

  staggerWallBy: function(stagger){
    var validStagger = false;

    for(var i=0; i < staggerArray.length; i++){
      if(staggerArray[i] == stagger){
        validStagger = true;
        break;
      }
    }

    if(!validStagger){
      alert("Invalid Staggering Option -" + stagger);
      return;
    }

    this.selectedStagger = stagger;
    this.drawWall();
  },

  setSelectedMortar: function(index){
    this.selectedMortar = this.selectedProduct.mortars[index];
  },

  setSelectedBrickType: function(index){
    this.selectedBrickType = this.selectedProduct.brickTypes[index];
    this.clearSelectedBrick();
  },
  setSelectedBrick: function(index){
    this.selectedBrick = this.selectedBrickType.bricks[index];
  },

  renderMortar: function(listContainer){
    listContainer.append(this.mortarsListHtml());
  },
  renderMortars: function(){
    var container = $("#mortars_toggle"),
        listContainer = $(container.data("toggle"));

    listContainer.html("");

    var mortars = this.selectedProduct.mortars;

    for(var i=0; i < mortars.length; i++){
      this.currentMortar = mortars[i];
      this.mortarIndex = i;
      this.renderMortar(listContainer);
    }
  },

  renderBrickType: function(listContainer){
    listContainer.append(this.brickTypesListHtml());
  },

  renderBrickTypes: function(){
    var container = $("#bricks_type_toggle"),
        listContainer = $(container.data("toggle"));

    listContainer.html("");

    var brickTypes = this.selectedProduct.brickTypes;

    for(var i=0; i < brickTypes.length; i++){
      this.currentBrickType = brickTypes[i];
      this.brickTypeIndex = i;
      this.renderBrickType(listContainer);
    }

  },
  renderBrick: function(listContainer){
    listContainer.append(this.bricksListHtml());
  },

  renderBricks: function(brickTypeIndex){

    var container = $("#bricks_toggle"),
        listContainer = $(container.data("toggle"));

    listContainer.html("");

    var bricks = this.selectedProduct.brickTypes[brickTypeIndex].bricks;

    for(var i=0; i < bricks.length; i++){
      this.currentBrick = bricks[i];
      this.brickIndex = i;
      this.renderBrick(listContainer);
    }

  },

  renderDefaultWallOnProductSelect: function(){
    $("a.mortar:first").trigger("click");
    $("a.brick-type:first").trigger("click");
    $("a.brick:first").trigger("click");
    $("a.wall-default-dimensions:first").trigger("click");
  },

  renderProductData: function(productIndex){
    this.clearProductSelected();
    this.selectedProduct = this.products[productIndex];
    this.productIndex = productIndex;
    this.renderMortars();
    this.renderBrickTypes();

    this.renderDefaultWallOnProductSelect();
  },


  renderProduct: function(listContainer){
    listContainer.append(this.productListHtml());
  },

  renderProducts: function(){
    var listContainer = $($("#products_toggle").data("toggle"));

    for(var i=0; i< this.products.length; i++){
      this.currentProduct = this.products[i];
      this.productIndex = i;
      this.renderProduct(listContainer);
    }
  },

  initialize: function(products){
    this.products = products;

    if(this.notDefinedProducts()){
      alert("Aborting. Invalid Initialization!");
      return;
    }

    this.renderProducts();
  },

  saveAsImage: function(){
    $("div#full-wall-copy").html($("div#full-wall").html());
    $("div#full-wall-copy").show();

    this.zoomWallBy(this.defaultZoomSize, "div#full-wall-copy", false);

    html2canvas($("div#full-wall-copy"), {
      onrendered: function(canvas) {
        var base64Img = canvas.toDataURL();
        var myWindow = window.open("", "_blank", "width=800, height=600");
        myWindow.document.write('<img src="' + base64Img + '">');
        $("div#full-wall-copy").hide();
      }
    });

  },

  zoomWallBy: function(scale, container, setScale){
    if(typeof(container) === "undefined" || container == null){
      container = "div#full-wall";
    }
    if(typeof(setScale) === "undefined" || setScale == null){
      setScale = true;
    }
    if(setScale){
      this.selectedZoomSize = scale;
    }

    var wallContainer = $(container);
    wallContainer.css("-webkit-transform", "scale(" + scale + ")");
    wallContainer.css("-moz-transform", "scale(" + scale + ")");
    wallContainer.css("-ms-transform", "scale(" + scale + ")");
    wallContainer.css("-o-transform", "scale(" + scale + ")");
    wallContainer.css("transform", "scale(" + scale + ")");
  }


};