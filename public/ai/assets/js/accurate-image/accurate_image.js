/*
  Description: This is library is developed with intent to let the user design their walls using tiles mortar etc.
               Users can save and edit their designs developed using this library.
               This allows, staggering, coursing, multiple tiles style, etc. kind of features.

  Dependency:
    External: jquery.contextMenu.js // developed using version 1.01
              html2canvas.js // developed using version 0.4.1
              JQuery.js // developed using version 1.11.0

    Internal: json_data.js, accurate_image_events.js

  Author: Naveen Agarwal (A Ruby Specialist, Ruby on Rails professional, JavaScript Lover)
  Developed At: Q3 Technologies
  Contact: nagarwal@q3tech.com

*/
var HALF = 2,
    ONE_THIRD = 3,
    NONE = 0,
    STANDARD = 0,
    RUNNING = 1,
    HEADERS = 2,
    FEET = 1,
    METERS = 2,
    UNDEFINED = "undefined";

var staggerArray = [NONE, HALF, ONE_THIRD];

var AccurateImage = {
  products: null,
  mortars: null,
  currentProduct: null,
  drawProduct: null,
  selectedProduct: null,
  selectedMortar: null,
  initialSelectedMortar: null,
  selectedBrick: null,
  initialSelectedBrick: null,
  useInitiallySelectedBrick: false,
  useInitiallySelectedMortar: false,
  initialCoursing: null,
  useInitiallySelectedCoursing: false,
  selectedBrickType: null,
  productIndex: null,
  currentMortar: null,
  mortarIndex: null,
  brickTypes: null,
  currentBrickType: null,
  brickTypeIndex: null,
  currentBrick: null,
  brickIndex: null,
  rowNumber: null,
  defaultZoomSize: 1,
  selectedZoomSize: 1,
  scale: 1,
  currentStagger: HALF,
  selectedStagger: HALF,
  selectedWallDimesions: null,
  undoRedoStackMaxLevel: 26,
  currentUndoRedoLevel: -1,
  undoRedoStack: [],
  coursingTypes: ["standard", "running", "headers"], // order of array matters dont change it
  selectedCoursing: 0, // 0 means standard, it is the index of coursingtypes array
  bricksArray: [],
  thisBrickItem: null,
  maxImageVariant: 100,
  imgIndex: null,
  thisBrickItemX: 0,
  thisBrickItemY: 0,
  useDefaultWallBricksArray: false,
  defaultWallBricksArray: null,
  seamlessDimensionY: null,
  seamlessDimensionX: 2,
  useSeamlessDimensions: false,
  randmoizedFillArray: null,
  maxWallDimensionX: 50,
  maxWallDimensionY: 50,
  currentMortarManufacturer: null,
  mortarManufacturerIndex: null,
  mortarManufacturers: null,
  selectedMortarManufacturer: null,
  textures: null,
  selectedTexture: null,
  currentTexture: null,
  colors: null,
  selectedColor: null,
  currentColor: null,
  plants: null,
  selectedPlant: null,
  currentPlant: null,
  plantIndex: null,
  colorIndex: null,
  textureIndex: null,
  sizes: null,
  bricks: null,

  baseUnit: 1, // in pxels
  inchPixels: 32, // one inch is 32 pixles

  unsignedInt: function(value){
    if(value >= 0){
      return value;
    }else{
      return (value + (-2 * value));
    }
  },

  pushChangeToUndoRedoStack: function(){
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
    this.enableContextMenu();
  },

  redo: function(){
    if(this.currentUndoRedoLevel == (this.undoRedoStack.length - 1) ){
      return;
    }
    this.currentUndoRedoLevel++;
    $("#full-wall").html(this.undoRedoStack[this.currentUndoRedoLevel]);
    this.enableContextMenu();
  },

  notDefinedProducts: function(){
    if(typeof(this.products) === UNDEFINED || this.products == null){
      return true;
    }else{
      return false;
    }
  },

  notDefinedMortars: function(){
    if(typeof(this.mortarManufacturers) === UNDEFINED || this.mortarManufacturers == null){
      return true;
    }else{
      return false;
    }
  },

  notDefined: function(element){
    if(typeof(element) === UNDEFINED || element == null){
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

  getCoursing: function(){
    if(this.useInitiallySelectedCoursing){
      return this.initialCoursing;
    }else{
      return this.selectedCoursing;
    }
  },

  previousRowOk: function(i,x,y){
    if(typeof(this.bricksArray[x - 1]) === UNDEFINED){
      return true;
    }else if(i != this.bricksArray[x - 1][y - 1] && i != this.bricksArray[x - 1][y] && i != this.bricksArray[x - 1][y + 1]){
      return true;
    }else{
      return false;
    }
  },

  currentRowOk: function(i,x,y){
    if(i != this.bricksArray[x][y - 1] && i != this.bricksArray[x][y + 1]){
      return true;
    }else{
      return false;
    }
  },

  nextRowOk: function(i,x,y){
    if(typeof(this.bricksArray[x + 1]) === UNDEFINED){
      return true;
    }else if(i != this.bricksArray[x + 1][y - 1] && i != this.bricksArray[x + 1][y] && i != this.bricksArray[x + 1][y + 1]){
      return true;
    }else{
      return false;
    }
  },

  getRandomArray: function(length, randomRange){
    if(this.notDefined(length)){
      var length = 16;
    }

    if(this.notDefined(randomRange)){
      var randomRange = 16;
    }

    var val, array = [];

    for(var i=0; i < length;){
      val = Math.floor(Math.random() * randomRange);
      if(array.indexOf(val) == -1){
        array.push(val);
        i++;
      }
      if(array.length >= length){
        break;
      }
    }
    return array;
  },

  setRandomBrick: function(element){
    var i,x,y, imgIndex = parseInt(element.data("imgindex")),array = this.getRandomArray();

    if(this.useDefaultWallBricksArray){
      this.imgIndex = this.defaultWallBricksArray[this.thisBrickItemX][this.thisBrickItemY];
    }else{
      x = this.thisBrickItemX;
      y = this.thisBrickItemY;
      for(i=0; i < array.length; i ++){
        if(this.previousRowOk(array[i],x,y) && this.currentRowOk(array[i],x,y) && this.nextRowOk(array[i],x,y) && imgIndex != array[i]){
          element.find("img:first").attr("src", this.getBrick().imgUrlArray[array[i]]);
          element.data("imgindex", array[i]);
          this.imgIndex = this.bricksArray[x][y] = array[i];
          break;
        }
      }
    }
  },

  setImageIndex: function(){
    var i,x,y, array = this.getRandomArray();

    if(this.useDefaultWallBricksArray){
      this.imgIndex = this.defaultWallBricksArray[this.thisBrickItemX][this.thisBrickItemY];
    }else{
      x = this.thisBrickItemX;
      y = this.thisBrickItemY;
      for(i=0; i < array.length; i ++){
        if(this.previousRowOk(array[i],x,y) && this.currentRowOk(array[i],x,y) && this.nextRowOk(array[i],x,y) ){
          this.imgIndex = this.bricksArray[x][y] = array[i];
          break;
        }
      }
    }
  },

  getBrick: function(){
    var brick, coursing;

    if(this.useInitiallySelectedBrick){
      brick = this.initialSelectedBrick;
    }else{
      brick = this.selectedBrick;
    }

    if(this.useInitiallySelectedCoursing){
      coursing = this.initialCoursing;
    }else{
      coursing = this.selectedCoursing;
    }

    if(!this.seamlessDesign){
      switch(coursing){
        case STANDARD:
          break;
        case RUNNING:
          brick = brick.running
          break;
        case HEADERS:
          brick = brick.header;
          break;
      }
    }

    if(!this.brickForCalculation){
      this.setImageIndex();
      brick.imgUrl = brick.imgUrlArray[this.imgIndex];
    }else{
      brick.imgUrl = brick.imgUrlArray[0];
    }
    return brick;
  },

  getMortar: function(){
    var mortar;

    if(this.useInitiallySelectedMortar){
      mortar = this.initialSelectedMortar;
    }else{
      mortar = this.selectedMortar;
    }
    return mortar;
  },

  productListHtml: function(){
    return  '\
              <div class="accordion-item product product-div" data-product_index="'+ this.productIndex +'" data-product_id="'+ this.currentProduct.id+ '">\
                <div class="row">\
                  <div class="col-xs-10 text-center"><img src="'+ this.currentProduct.imgUrl +'"/></div>\
                </div>\
              </div>\
            ';
  },

  mortarsListHtml: function(){
    return  '\
              <div class="accordion-item mortar" data-mortar_index="'+ this.mortarIndex +'" data-mortar_id="'+ this.currentMortar.id +'">\
                <div class="row">\
                  <div class="col-xs-10 text-center"><img src="'+ this.currentMortar.imgUrl +'"/></div>\
                </div>\
              </div>\
            ';

  },
  mortarManufacturersListHtml: function(){
    return  '\
              <div class="accordion-item mortar-manufacturer" data-mortar_manufacturer_index="'+ this.mortarManufacturerIndex +'" data-mortar_manufacturer_id="'+ this.currentMortarManufacturer.id +'">\
                <div class="row">\
                  <div class="col-xs-10 text-center"><img src="'+ this.currentMortarManufacturer.imgUrl +'"/></div>\
                </div>\
              </div>\
            ';

  },
  brickTypesListHtml: function(){
    return  '\
              <div class="accordion-item brick-type" data-brick_type_index="'+ this.brickTypeIndex +'" data-brick_type_id="'+ this.currentBrickType.id +'">\
                <div class="row">\
                  <div class="col-xs-10 text-center"><img src="'+ this.currentBrickType.imgUrl +'"/></div>\
                </div>\
              </div>\
            ';
  },
  innerDivStyleCalc: function(){
    var mortar = this.getMortar();
    return mortar.top + "px " + mortar.right + "px " + mortar.bottom + "px " + mortar.left + "px;";
  },
  innerDivstyle: function(){
    return "margin:" + this.innerDivStyleCalc();
  },
  brickImgStyle: function(brick){
    return "height:" + brick.height + "px; width:" + brick.width + "px;";
  },

  bricksListHtml: function(){
    return  '\
              <div class="accordion-item brick" data-brick_index="'+ this.brickIndex +'" data-brick_id="'+ this.currentBrick.id +'" >\
                <div class="row">\
                  <div class="col-xs-10 text-center"><img src="'+ this.currentBrick.imgUrl +'"/></div>\
                </div>\
              </div>\
            ';
  },

  texturesListHtml: function(){
    return  '\
              <div class="accordion-item texture" data-texture_index="'+ this.textureIndex +'" data-texture_id="'+ this.currentTexture.id +'" >\
                <div class="row">\
                  <div class="col-xs-10 text-center"><img src="'+ this.currentTexture.imgUrl +'"/></div>\
                </div>\
              </div>\
            ';
  },

  colorsListHtml: function(){
    return  '\
              <div class="accordion-item color" data-color_index="'+ this.colorIndex +'" data-color_id="'+ this.currentColor.id +'" >\
                <div class="row">\
                  <div class="col-xs-10 text-center"><img src="'+ this.currentColor.imgUrl +'"/></div>\
                </div>\
              </div>\
            ';
  },

  plantsListHtml: function(){
    return  '\
              <div class="accordion-item plant" data-plant_index="'+ this.plantIndex +'" data-color_id="'+ this.currentPlant.id +'" >\
                <div class="row">\
                  <div class="col-xs-10 text-center"><img src="'+ this.currentPlant.imgUrl +'"/></div>\
                </div>\
              </div>\
            ';
  },

  renderEvenWallHtml: function(elementPosition){
    var brick = this.getBrick();
    var mortar = this.getMortar();
    var imgIndex = brick.imgUrlArray.indexOf(brick.imgUrl);
    var itemID = "item-";

    if(this.seamlessDesign){
      itemID = "seamless-item-";
    }

    return  '\
              <span id="'+ itemID + elementPosition +'" data-imgIndex="'+ imgIndex +'" data-coursing="'+ this.getCoursing() +'" class="item" data-row="'+ this.rowNumber +'" data-brick_index="'+ elementPosition +'" data-image_id="'+ brick.id +'">\
                <span style="'+ this.innerDivstyle() +'">\
                  <img style="'+ this.brickImgStyle(brick) +'" src="'+ brick.imgUrl +'">\
                </span>\
              </span>\
            ';
  },

  calcNumberOfBricksX: function(width, brick){
    var mortar = this.getMortar();
    var brickWithMortarSize = brick.width + mortar.left + mortar.right;

    return parseInt((width / brickWithMortarSize));
  },

  calcNumberOfBricksY: function(width, brick){
    var mortar = this.getMortar();
    var brickWithMortarSize = brick.height + mortar.left + mortar.right;

    return parseInt((width / brickWithMortarSize));
  },

  calcOccupiedWidth: function(row){
    var width = 0;

    row.find("span.item").each(function(){
      width = width + $(this).width();
    });

    return width;
  },

  fillCoursingFor: function(element, coursingType, performRowCoursing){
    var elementCoursing = parseInt(element.data("coursing"));
    var row = element.parent();
    var rowCoursing = parseInt(element.parent().data("coursing"));
    var lastBrickIndex, lastElWidth, lastElImgWidth;
    var margin = occupiedWidth = width = 0, brick;
    var stagger, rowWidth, numberOfBricksX, elementPosition, mortar, el;

    this.thisBrickItemX = parseInt(row.data("row")) - 1;
    this.thisBrickItemY = parseInt(element.data("brick_index").split("-")[1]);
    brick = this.getBrick();

    // if brick height is different we will perform row coursing
    if(!(row.height() == (brick.height + this.selectedMortar.top + this.selectedMortar.bottom))){
      performRowCoursing = true;
    }

    this.rowNumber = parseInt(row.data("row"));
    stagger = parseInt(row.data("stagger"));

    if(performRowCoursing){
      rowWidth = row.width();
      numberOfBricksX = this.calcNumberOfBricksX(rowWidth, brick);
      row.html("");
      // Empty bricks array as we going to redraw the full row
      this.bricksArray[this.rowNumber] = [];
      this.thisBrickItemX = this.rowNumber - 1;

      for(var j=0; j < numberOfBricksX; j++){
        this.thisBrickItemY = j;
        elementPosition = this.rowNumber - 1 + "-" + j
        row.append(this.renderEvenWallHtml(elementPosition));
      }

      if(stagger != NONE){
        margin = this.staggeredFirstElementLeftMarginStyle();
        row.find("span.item:first").css("margin-left", "-" + margin + "px");
      }

      occupiedWidth = this.calcOccupiedWidth(row) - margin;
      if(row.width() != occupiedWidth){
        this.thisBrickItemY = j;
        elementPosition = this.rowNumber - 1 + "-" + j;
        row.append(this.renderEvenWallHtml(elementPosition));
        width = row.width() - occupiedWidth;
        maxWidth = this.getBrick().width + this.selectedMortar.left + this.selectedMortar.right;
        if(width > maxWidth){
          this.thisBrickItemY = j + 1;
          elementPosition = this.rowNumber - 1 + "-" + (j + 1);
          row.append(this.renderEvenWallHtml(elementPosition));
          width = width - maxWidth;
        }
        row.find("span.item:last").css("width", width + "px");
      }

      row.css("height", this.calulateRowHeight());
      row.data("coursing", coursingType);
      this.fillRowMortar();
    } // End if for performRowCoursing
    else{
      this.thisBrickItemX = parseInt(row.data("row")) - 1;
      this.thisBrickItemY = parseInt(element.data("brick_index").split("-")[1]);
      brick = this.getBrick();
      mortar = this.getMortar();

      if(stagger != NONE){
        if(element.data("brick_index").split("-")[1] == "0"){
          marginFront = this.staggeredFirstElementLeftMarginStyle();
        }else{
          marginFront = parseInt(row.find("span.item:first").css("margin-left"));
          marginFront = this.unsignedInt(marginFront);
        }
      }else{
        marginFront = 0;
      }

      element.find("img").attr("src", brick.imgUrl);
      element.find("img").css({"height": brick.height, "width": brick.width});
      element.find("img").css({"width": brick.width });
      element.css({"width": brick.width + mortar.right + mortar.left});
      element.data("coursing", coursingType);

      row.find("span.item:first").css({"margin-left": "-" + marginFront + "px"});

      lastElWidth = row.find(".item:last").width();
      lastElImgWidth = row.find(".item:last").find("img").width();

      occupiedWidth = this.calcOccupiedWidth(row) - marginFront;

      if(lastElWidth != lastElImgWidth && lastElWidth < lastElImgWidth && row.width() > occupiedWidth){
        row.find(".item:last").css("width", lastElImgWidth + mortar.right + mortar.left);
        occupiedWidth = this.calcOccupiedWidth(row) - marginFront;
      }

      if(((this.initialCoursing == RUNNING && this.selectedCoursing == RUNNING) ||(this.initialCoursing == STANDARD || this.initialCoursing == HEADERS) && (this.selectedCoursing == STANDARD || this.selectedCoursing == HEADERS))){
        this.useInitiallySelectedCoursing  = this.useInitiallySelectedBrick = this.useInitiallySelectedMortar = true;
      }

      numberOfBricksX = this.calcNumberOfBricksX(width, brick);

      for(var i=0; i < numberOfBricksX; i ++){
        j = (i + 1 + parseInt(row.find(".item:last").data("brick_index").split("-")[1]));
        this.thisBrickItemY = j;
        elementPosition = this.rowNumber - 1 + "-" + j;
        row.append(this.renderEvenWallHtml(elementPosition));
        this.fillMortarItem(row.find("span.item:last"));
      }

      occupiedWidth = this.calcOccupiedWidth(row) - marginFront;
      lastBrickIndex = parseInt(row.find(".item:last").data("brick_index").split("-")[1]);

      brick = this.getBrick();

      if(row.width() > occupiedWidth){
        j = (lastBrickIndex + 1);
        this.thisBrickItemY = j;
        elementPosition = this.rowNumber - 1 + "-" + j;
        row.append(this.renderEvenWallHtml(elementPosition));
        this.fillMortarItem(row.find("span.item:last"));

        width = row.width() - occupiedWidth;
        maxWidth = brick.width + this.selectedMortar.left + this.selectedMortar.right;

        if(width > maxWidth){
          j = (lastBrickIndex + 2);
          this.thisBrickItemY = j;
          elementPosition = this.rowNumber - 1 + "-" + j;
          row.append(this.renderEvenWallHtml(elementPosition));
          this.fillMortarItem(row.find("span.item:last"));
          width = width - maxWidth;
        }
      }else if(row.width() < occupiedWidth){
        width = row.width() - this.calcOccupiedWidth(row) + marginFront;
        width = row.find("span.item:last").width() + width;
      }else if(row.width() == occupiedWidth){
        width = row.find("span.item:last").width();
      }
      row.find("span.item:last").css("width", width + "px");
      //Incase ethe width becomes zero - it happens when width goes in negative
      if(row.find("span.item:last").width() == 0){
        while(true){
          el = row.find("span.item:last");
          row.find("span.item:last").remove()
          width = this.calcOccupiedWidth(row) - marginFront;
          if(row.width() > width){
            row.append(el);
            this.fillMortarItem(row.find("span.item:last"));
            break;
          }
        }
        //recalculate the width for the last item to be set
        width = row.width() - this.calcOccupiedWidth(row) + row.find("span.item:last").width() + marginFront;
        row.find("span.item:last").css("width", width + "px");
      }
      this.useInitiallySelectedCoursing  = this.useInitiallySelectedBrick = this.useInitiallySelectedMortar = false;
    } // End of else part

  },

  handleItemClick: function(el){
    AccurateImage.fillMortarItem(el);
    AccurateImage.fillCoursing(el);
    AccurateImage.setRandomBrick(el);
  },

  fillRowEvenCoursing: function(){
    var row = $('.row-' + this.rowNumber),
        elements = row.find("span.item:nth-child(odd)"),
        lastElement, index;

    elements.each(function(index){
      // Instead of triggering click manually calling the trigger related actions
      AccurateImage.handleItemClick($(this));
      lastElement = $(this);
    });

    if(parseInt(row.data("coursing")) != this.selectedCoursing){
      //reassign elements as number of elements may have changed if different coursing has been set
      elements = row.find("span.item:nth-child(odd)");

      elements.each(function(){
        var el = $(this);
        if(el.next().html() != undefined && el.find("img").attr("src") == el.next().find("img").attr("src")){
          // el.trigger("click");
          AccurateImage.handleItemClick(el);
          lastElement = el
          el.nextAll("span.item:nth-child(odd)").each(function(){
            // Instead of triggering click manually calling the trigger related actions
            AccurateImage.handleItemClick($(this));
            lastElement = $(this);
          });
        }
      });
    }

    index = parseInt(lastElement.data("brick_index").split("-")[1]);

    if((row.find("span.item").length - index) > 2){
      this.fillRowEvenCoursing();
    }

  },

  fillRunningCoursing: function(element){
    var rowCoursing = parseInt(element.parent().data("coursing")),
        performRowCoursing = true;

    performRowCoursing = !(rowCoursing == RUNNING);

    this.fillCoursingFor(element, RUNNING, performRowCoursing);
  },

  fillStandardCoursing: function(element){
    var rowCoursing = parseInt(element.parent().data("coursing")),
        performRowCoursing = true;

    performRowCoursing = !(rowCoursing == HEADERS || rowCoursing == STANDARD);

    this.fillCoursingFor(element, STANDARD, performRowCoursing);
  },

  fillHeaderCoursing: function(element){
    var rowCoursing = parseInt(element.parent().data("coursing")),
        performRowCoursing = true;

    performRowCoursing = !(rowCoursing == HEADERS || rowCoursing == STANDARD);

    this.fillCoursingFor(element, HEADERS, performRowCoursing);
  },

  fillCoursing: function(element){
    switch(this.selectedCoursing){
      case STANDARD:
        this.fillStandardCoursing(element);
        break;
      case RUNNING:
        this.fillRunningCoursing(element);
        break;
      case HEADERS:
        this.fillHeaderCoursing(element);
        break;
    }
  },

  staggeredFirstElementLeftMarginStyle: function(){
    var pixels = "",
        brick = this.getBrick(),
        mortar = this.getMortar(),
        width ;


    if(this.selectedStagger == NONE){
      return "";
    }else{
      width = brick.width + mortar.left + mortar.right;
      pixels = (width / this.selectedStagger);
    }

    return pixels;
  },

  staggeredFirstElementStyle: function(){
    return "margin-left:-" + this.staggeredFirstElementLeftMarginStyle() + "px";
  },

  staggeredLastElementStyle: function(){
    var pixels = "",
        brick = this.getBrick(),
        mortar = this.getMortar(),
        width,
        difference;

    if(this.selectedStagger == NONE){
      return "";
    }else{
      width = brick.width + mortar.left + mortar.right;
      pixels = (width / this.selectedStagger);
    }

    return "overflow:hidden;width:" + pixels + "px";
  },

  staggeredElementStyle: function(elementPosition){
    var dimensionX;
    if(this.useSeamlessDimensions){
      dimensionX = this.seamlessDimensionX;
    }else{
      dimensionX = this.dimensionX;
    }

    var positionX = parseInt(elementPosition.split("-")[1]);
    var firstElement = (positionX == 0) ? true : false;
    var lastElement = (dimensionX == positionX) ? true : false;
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
      var brick = this.getBrick();
      var imgIndex = brick.imgUrlArray.indexOf(brick.imgUrl);
    }

    var itemID = "item-";

    if(this.seamlessDesign){
      itemID = "seamless-item-";
    }

    return  '\
              <span id="'+ itemID + elementPosition +'" data-imgIndex="'+ imgIndex +'" data-coursing="'+ this.selectedCoursing +'" style="'+ style +'" class="item" data-row="'+ this.rowNumber +'" data-brick_index="'+ elementPosition +'" data-image_id="'+ brick.id +'">\
                <span style="'+ this.innerDivstyle() +'">\
                  <img style="'+ this.brickImgStyle(brick) +'" src="'+ brick.imgUrl +'">\
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

  fillMortarFullForSeamlessWall: function(){
    var mortar = this.getMortar();

    $(".seamless-item").css('background-image', 'url('+ mortar.fillImage +')');
    $(".seamless-item").css('background-repeat', 'repeat');
    $(".seamless-item > span").attr('style', this.innerDivstyle());
  },

  fillMortarFull: function(){
    var mortar = this.getMortar();

    $(".item").css('background-image', 'url('+ mortar.fillImage +')');
    $(".item").css('background-repeat', 'repeat');
    $(".item > span").attr('style', this.innerDivstyle());
  },

  fillBricksFull: function(){
    $(".item > span > img").attr('src', this.getBrick().imgUrl);
  },

  fillRowBricks: function(){
    var brick = this.getBrick();
    $('.row-' + this.rowNumber + ' .item > span > img').attr('src', brick.imgUrl);
    $('.row-' + this.rowNumber + ' .item > span > img').css({'width': brick.width, 'height': brick.height });
  },

  fillRowEvenBricks: function(){
    $('.row-' + this.rowNumber + ' .item:nth-child(odd) > span > img').attr('src', this.getBrick().imgUrl);
  },

  fillRowMortar: function(){
    var mortar = this.getMortar();
    $('.row-' + this.rowNumber +  ' .item').css('background-image', 'url('+ mortar.fillImage +')');
    $('.row-' + this.rowNumber +  ' .item').css('background-repeat', 'repeat');
    $('.row-' + this.rowNumber +  ' .item > span').attr('style', this.innerDivstyle());
  },

  fillRowEvenMortar: function(){
    var mortar = this.getMortar();
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd)').css('background-image', 'url('+ mortar.fillImage +')');
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd)').css('background-repeat', 'repeat');
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd) > span').attr('style', this.innerDivstyle());
  },

  fillMortarItem: function(item){
    var mortar = this.getMortar();
    item.css('background-image', 'url('+ mortar.fillImage +')');
    item.css('background-repeat', 'repeat');
    item.find("span:first").attr('style', this.innerDivstyle());
  },

  fillBrickItem: function(item){
    item.find("img:first").attr('src', this.getBrick().imgUrl);
  },

  fillRow: function(){
    var element = $('.row-' + this.rowNumber +  ' span.item:first');
    this.fillCoursingFor(element, this.selectedCoursing, true);
  },

  fillEven: function(){
    this.fillRowEvenCoursing();
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
    $(".row-" + this.rowNumber).data("stagger", NONE);
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
    rowContainer.data("stagger", this.selectedStagger);

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

  setBrickFor: function(el, brickIndex){
    el.find("img:first").attr("src", this.selectedBrick.imgUrlArray[brickIndex])
  },

  enableContextMenu: function(){
    // return true;
    $(".item").contextMenu({
      menu: 'AIMenu'
      }, function(action, el, pos) {
        var regex = /^set-/;
        if(regex.test(action)){
          AccurateImage.setBrickFor(el, (parseInt(action.split("-")[1]) -1));
        }else{
          AccurateImage.rowNumber = parseInt(el.parent().data("row"));
          AccurateImage[action]();
        }

        AccurateImage.pushChangeToUndoRedoStack();
        AccurateImage.enableContextMenu();
    });
  },

  calulateRowWidth: function(){
    this.brickForCalculation = true;
    var brick = this.getBrick();
    var mortar = this.getMortar();
    this.brickForCalculation = false;
    return (this.dimensionX * (brick.width + mortar.left + mortar.right));
  },

  calulateSeamlessRowWidth: function(){
    this.brickForCalculation = true;
    var brick = this.getBrick();
    var mortar = this.getMortar();
    this.brickForCalculation = false;
    return (this.seamlessDimensionX * (brick.width + mortar.left + mortar.right));
  },

  calulateRowHeight: function(){
    this.brickForCalculation = true;
    var brick = this.getBrick();
    var mortar = this.getMortar();
    this.brickForCalculation = false;
    return brick.height + mortar.top + mortar.bottom;
  },

  setInitialDefaults: function(){
    this.initialSelectedBrick = this.selectedBrick;
    this.initialSelectedMortar = this.selectedMortar;
    this.initialCoursing = this.selectedCoursing;
  },

  getRandomImgURLsIndexArrayForWall: function(){
    var i=0, j=0, array=[], x, y;

    if(this.seamlessDesign){
      x = this.seamlessDimensionX;
      y = this.seamlessDimensionY;
    }else{
      x = this.dimensionX + 1;
      y = this.dimensionY + 1;
    }

    while(true){
      if(i > y){
        break;
      }
      array[i] = [];
      while(true) {
        if(array[i].length >= x){
          j = 0;
          break;
        }

        if(i == 0){
          if(j == 0){
            array[i][j] = Math.floor(Math.random() * 16);
          }
          else{
            while(true) {
              z = Math.floor(Math.random() * 16);
              if(array[i][j - 1] != z){
                array[i][j] =  z;
                break;
              }
            }
          }
        }else if( i > 0){
          if( j > 0){
            while(true){
              z = Math.floor(Math.random() * 16);
              if(array[i][j - 1] != z && array[i - 1][j - 1] != z && array[i-1][j] != z && array[i-1][j+1] != z){
                array[i][j] = z;
                break;
              }
            }
          }else{
            while(true){
              z = Math.floor(Math.random() * 16);
              if(array[i - 1][j] != z && array[i-1][j+1] != z){
                array[i][j] = z;
                break;
              }
            }
          }
        }
        ++j;
      }
      ++i;
    }
    return array;
  },

  addLinksForSeamlessWall: function(){
    var el = $('<div class="seamless-links"></div>');

    el.html(
            '\
              <button class="sign-up-button" id="save-seamless-wall"><i class="fa fa-floppy-o"></i> Save as Image</button>\
            '
            );

    $("#seamless-wall-container").before(el);
  },

  notValidDimesions: function() {
    if(this.seamlessDesign){
      if(this.seamlessDimensionX > this.maxWallDimensionX){
        return true;
      }else{
        return false;
      }
    }else{
      if(this.dimensionY > this.maxWallDimensionY || this.dimensionX > this.maxWallDimensionX){
        return true;
      }else{
        return false;
      }
    }

  },

  drawSeamlessWall: function(){

    $("#lightbox-content").html("").html('<div class="custom-overlay"></div><div class="wall-seam"><div id="seamless-wall-container"></div></div>');

    var elementPosition, evenRow, rowContainer, XYDiff, brick, mortar,
        wallContainer = $("#seamless-wall-container");

    wallContainer.html("");

    this.useDefaultWallBricksArray = true;
    this.defaultWallBricksArray = this.getRandomImgURLsIndexArrayForWall();

    for(var i=0; i < this.seamlessDimensionY; i++){
      this.rowNumber  = i;
      evenRow         = i%2 == 0 ? true : false;
      rowContainer    = $('<span data-stagger="'+ (evenRow ? NONE : this.selectedStagger) +'" data-coursing="'+ this.selectedCoursing +'" style="width: '+ this.calulateSeamlessRowWidth() +'px; height:'+ this.calulateRowHeight() +'px;" class="seamless-span-row row-'+ (i + 1) +'" data-row="'+ (i + 1) +'"></span>');
      this.thisBrickItemX = i;

      for(var j=0; j < this.seamlessDimensionX; j++){
        this.thisBrickItemY = j;
        elementPosition = i + "-" + j;
        this.renderWallBrick(evenRow, elementPosition, rowContainer);

        if(!evenRow && this.selectedStagger != NONE && (j+1) == this.seamlessDimensionX){
          ++j;
          this.thisBrickItemY = j;
          elementPosition = i + "-" + j;
          this.renderWallBrick(evenRow, elementPosition, rowContainer);
        }
      }
      wallContainer.append(rowContainer);
      wallContainer.append(this.renderBreakWallBrickHtml());
    }

    wallContainer.css("width", this.calulateSeamlessRowWidth());
    wallContainer.find("span.item").addClass("seamless-item").removeClass("item");

    wallContainer.find(".seamless-span-row:nth-child(odd)").each(function(){
      var el = $(this);
      el.find("span.seamless-item:last img").attr("src", el.find("span.seamless-item:first img").attr("src"));
    });

    brick = this.getBrick();
    mortar = this.getMortar();
    XYDiff = Math.abs((this.seamlessDimensionY * (brick.height + mortar.top + mortar.bottom)) - wallContainer.width());

    if(XYDiff > ((brick.height + mortar.top + mortar.bottom ) / 2 )){
      wallContainer.find(".seamless-span-row:last").remove();
    }

    this.fillMortarFullForSeamlessWall();
    this.rowNumber = null;

    this.addLinksForSeamlessWall();
    this.seamlessDesign = false;
    this.useDefaultWallBricksArray = false;
  },

  drawWall: function(){

    if(this.notValidDimesions()){
      alert("Invalid Wall dimensions max :" + this.maxWallDimensionX);
      return false;
    }

    var elementPosition,
        evenRow,
        rowContainer,
        wallContainer = $("#full-wall");

    wallContainer.html("");
    wallContainer.data("design_id", "");

    this.zoomWallInAndOut(false, false);
    this.setInitialDefaults();
    this.useDefaultWallBricksArray = true;
    this.defaultWallBricksArray = this.getRandomImgURLsIndexArrayForWall();

    for(var i=0; i < this.dimensionY; i++){
      this.rowNumber  = i;
      evenRow         = i%2 == 0 ? true : false;
      rowContainer    = $('<span data-stagger="'+ (evenRow ? NONE : this.selectedStagger) +'" data-coursing="'+ this.selectedCoursing +'" style="width: '+ this.calulateRowWidth() +'px; height:'+ this.calulateRowHeight() +'px;" class="span-row row-'+ (i + 1) +'" data-row="'+ (i + 1) +'"></span>');
      this.thisBrickItemX = i;

      for(var j=0; j < this.dimensionX; j++){
        this.thisBrickItemY = j;
        elementPosition = i + "-" + j;
        this.renderWallBrick(evenRow, elementPosition, rowContainer);

        if(!evenRow && this.selectedStagger != NONE && (j+1) == this.dimensionX){
          ++j;
          this.thisBrickItemY = j;
          elementPosition = i + "-" + j;
          this.renderWallBrick(evenRow, elementPosition, rowContainer);
        }
      }
      wallContainer.append(rowContainer);
      wallContainer.append(this.renderBreakWallBrickHtml());
    }

    this.fillMortarFull();

    this.rowNumber = null;
    this.useDefaultWallBricksArray = false;
    this.bricksArray = $.extend(true, [], this.defaultWallBricksArray);
    this.enableContextMenu();
    $(window).trigger("resize");
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
    this.selectedMortar = this.mortars[index];
  },

  setSelectedBrickType: function(index){
    this.selectedBrickType = this.selectedProduct.sizes[index];
  },

  setSelectedMortarManufacturer: function(index){
    this.selectedMortarManufacturer = this.mortarManufacturers[index];
  },

  setSelectedBrick: function(index){
    this.selectedBrick = this.bricks[index];
  },

  setSelectedCoursing: function(coursing){
    this.selectedCoursing = this.coursingTypes.indexOf(coursing);
    if(this.selectedCoursing == -1){
      this.selectedCoursing = 0;
    }
  },

  enableNiceScroll: function(listContainer){
    listContainer.niceScroll({
      cursorwidth: "5px",
      hidecursordelay: 0
    });
  },

  mortarsContainer: function(){
    return  '\
              <div class="mortar-title">\
                Mortars\
                <a class="items-toggler" href="javascript:void(0);">\
                  <i class="active-submenu pull-right"></i>\
                </a>\
              </div>\
              <div class="mortar-list-container" id="mortar_list_container">\
              </div>\
            ';
  },

  mortarManufacturersContainer: function(){
    return  '\
              <div class="mortar-manufacturer-title">\
                Mortar Manufacturers\
                <a class="items-toggler" href="javascript:void(0);">\
                  <i class="active-submenu pull-right"></i>\
                </a>\
              </div>\
              <div class="mortar-manufacturers-list-container" id="mortar_manufacturers_list_container">\
              </div>\
            ';
  },

  renderMortar: function(listContainer){
    listContainer.append(this.mortarsListHtml());
  },

  renderMortarManufacturer: function(listContainer){
    listContainer.append(this.mortarManufacturersListHtml());
  },

  renderMortars: function(){
    var listContainer = $('#manufacturers_prodcuts_list');

    if($("#mortar_list_container").length == 0){
      if(listContainer.find("#mortar_manufacturers_list_container").length > 0){
        listContainer.find("#mortar_manufacturers_list_container").after(this.mortarsContainer());
      }else{
        listContainer.append(this.mortarsContainer());
      }
    }

    listContainer = listContainer.find("#mortar_list_container");
    listContainer.html('');

    this.mortars = this.selectedMortarManufacturer.mortars;

    for(var i=0; i < this.mortars.length; i++){
      this.currentMortar = this.mortars[i];
      this.mortarIndex = i;
      this.renderMortar(listContainer);
    }

    this.setActiveMortarIfAny(listContainer);
    this.enableNiceScroll(listContainer);
  },

  setActiveMortarManufacturerIfAny: function(listContainer){
    if(this.selectedMortarManufacturer == null){
      return;
    }

    var thisAI = this;

    listContainer.find(".mortar-manufacturer").each(function(){
      if($(this).data("mortar_manufacturer_id") == thisAI.selectedMortarManufacturer.id){
        $(this).addClass("mortar-manufacturer-active");
        return false; // to break the each loop
      }

    });
  },

  renderMortarManufacturersList: function(){
    var listContainer = $('#manufacturers_prodcuts_list');

    // listContainer.html('');
    if($("#mortar_manufacturers_list_container").length == 0){
      listContainer.html(this.mortarManufacturersContainer());
    }

    listContainer = listContainer.find("#mortar_manufacturers_list_container");
    listContainer.html('');

    for(var i=0; i < this.mortarManufacturers.length; i++){
      this.currentMortarManufacturer = this.mortarManufacturers[i];
      this.mortarManufacturerIndex = i;
      this.renderMortarManufacturer(listContainer);
    }

    this.setActiveMortarManufacturerIfAny(listContainer);
    this.enableNiceScroll(listContainer);
  },

  renderMortarManufacturers: function(){
    if(this.mortarManufacturers.length == 1){
      this.selectedMortarManufacturer = this.mortarManufacturers[0];
      this.renderMortars();
    }else if(this.mortarManufacturers.length > 1){
      this.renderMortarManufacturersList();
    }else {
      alert("Error: Invalid Mortars");
    }
  },

  brickTypesContainer: function(){
    return  '\
              <div class="brick-type-title">\
                Sizes\
                <a class="items-toggler" href="javascript:void(0);">\
                  <i class="active-submenu pull-right"></i>\
                </a>\
              </div>\
              <div class="brick-type-list-container" id="brick_type_list_container">\
              </div>\
            ';
  },

  renderBrickType: function(listContainer){
    listContainer.append(this.brickTypesListHtml());
  },

  setActiveSizeIfAny: function(listContainer){
    if(this.selectedBrickType == null){
      return;
    }

    var thisAI = this;

    listContainer.find(".brick-type").each(function(){
      if($(this).data("brick_type_id") == thisAI.selectedBrickType.id){
        $(this).addClass("brick-type-active");
        return false; // to break the each loop
      }

    });
  },

  setSelectedTexture: function(index){
    this.selectedTexture = this.textures[index];
  },
  setSelectedColor: function(index){
    this.selectedColor = this.colors[index];
  },

  setActiveColorIfAny: function(listContainer){
    if(this.selectedColor == null){
      return;
    }

    var thisAI = this;

    listContainer.find(".color").each(function(){
      if($(this).data("color_id") == thisAI.selectedColor.id){
        $(this).addClass("color-active");
        return false; // to break the each loop
      }

    });
  },

  setActiveTextureIfAny: function(listContainer){
    if(this.selectedTexture == null){
      return;
    }

    var thisAI = this;

    listContainer.find(".texture").each(function(){
      if($(this).data("texture_id") == thisAI.selectedTexture.id){
        $(this).addClass("texture-active");
        return false; // to break the each loop
      }

    });
  },

  sizesContainer: function(){
    return this.brickTypesContainer();
  },

  renderBrickTypes: function(){
    var listContainer = $('#manufacturers_prodcuts_list');

    if(listContainer.find("#brick_type_list_container").length == 0){
      listContainer.append(this.sizesContainer());
    }

    listContainer = listContainer.find("#brick_type_list_container");
    listContainer.html('');

    for(var i=0; i < this.sizes.length; i++){
      this.currentBrickType = this.sizes[i];
      this.brickTypeIndex = i;
      this.renderBrickType(listContainer);
    }

    this.setActiveSizeIfAny(listContainer);
    this.enableNiceScroll(listContainer);
  },

  bricksContainer: function(){
    return  '\
              <div class="brick-title">\
                Bricks\
                <a class="items-toggler" href="javascript:void(0);">\
                  <i class="active-submenu pull-right"></i>\
                </a>\
              </div>\
              <div class="brick-list-container" id="brick_list_container">\
              </div>\
            ';
  },

  texturesContainer: function(){
    return  '\
              <div class="texture-title">\
                Textures\
                <a class="items-toggler" href="javascript:void(0);">\
                  <i class="active-submenu pull-right"></i>\
                </a>\
              </div>\
              <div class="texture-list-container" id="texture_list_container">\
              </div>\
            ';
  },

  colorsContainer: function(){
    return  '\
              <div class="color-title">\
                Colors\
                <a class="items-toggler" href="javascript:void(0);">\
                  <i class="active-submenu pull-right"></i>\
                </a>\
              </div>\
              <div class="color-list-container" id="color_list_container">\
              </div>\
            ';
  },

  renderBrick: function(listContainer){
    listContainer.append(this.bricksListHtml());
  },

  setActiveBrickIfAny: function(listContainer){
    if(this.selectedBrick == null){
      return;
    }

    var thisAI = this;

    listContainer.find(".brick").each(function(){
      if($(this).data("brick_id") == thisAI.selectedBrick.id){
        $(this).addClass("brick-active");
        return false; // to break the each loop
      }

    });
  },

  setActiveMortarIfAny: function(listContainer){
    if(this.selectedMortar == null){
      return;
    }

    var thisAI = this;

    listContainer.find(".mortar").each(function(){
      if($(this).data("mortar_id") == thisAI.selectedMortar.id){
        $(this).addClass("mortar-active");
        return false; // to break the each loop
      }

    });
  },

  renderBricks: function(brickTypeIndex){
    var listContainer = $('#manufacturers_prodcuts_list');
    this.bricks = this.selectedColor.bricks;

    $('.brick').remove();

    if($("#brick_list_container").length == 0){
      listContainer.append(this.bricksContainer);
    }

    listContainer = listContainer.find("#brick_list_container");

    for(var i=0; i < this.bricks.length; i++){
      this.currentBrick = this.bricks[i];
      this.brickIndex = i;
      this.renderBrick(listContainer);
    }

    this.setActiveBrickIfAny(listContainer);
    this.enableNiceScroll(listContainer);
  },

  setDefaultWallDimesions: function(){
    this.selectedWallDimesions = '10x10';
  },

  renderDefaultWallOnProductSelectForFirstTime: function(){
    if($.trim($('#full-wall').html()) == ''){

      if($(".product").length > 0){
        $(".product").trigger("click");

        if($(".mortar-manufacturer").length > 0){
          $(".mortar-manufacturer").trigger("click");
        }

        $(".mortar:first").trigger("click");
        $(".brick-type:first").trigger("click");

        if($(".plant").length > 0){
          $(".plant").trigger("click");
        }

        if($(".texture").length > 0){
          $(".texture").trigger("click");
        }

        if($(".color").length > 0){
          $(".color").trigger("click");
        }

        $(".brick:first").trigger("click");

        this.setDefaultWallDimesions();

        AccurateImage.drawDefaultWall();
        AccurateImage.pushChangeToUndoRedoStack();
      } //End if
    }
  },

  customWallFormHTML: function(){
    return  '\
            <div>\
              <div class="custom-overlay"></div>\
                 <form id="customWallForm" class="sign-up">\
                <h1 class="sign-up-title">Custom Units</h1>\
               <div class="row">\
              <div class="col-md-6">  <input type="number" class="sign-up-input"  id="x" value="10" min="1" required> </div>\
               <div class="col-md-6"> <input type="number"  class="sign-up-input"  id="y" value="10" min="1" required></div>\
               </div>\
                 <div class="row">\
                  <div class="col-md-12">\
                <input type="submit" id="customWallBtn" class="sign-up-button" value="Draw">\
             </div>\
           </div>\
              </form>\
                </div>\
             </div>\
            ';
  },



  createNewDesign: function(){
    $("#lightbox-content").html(this.customWallFormHTML());
    $('.show-popup').trigger("click");
    $('.overlay-content').css({ margin: "auto", });
    $('#lightbox-content').css({ });
  },

  renderTexture: function(listContainer){
    listContainer.append(this.texturesListHtml());
  },

  renderColor: function(listContainer){
    listContainer.append(this.colorsListHtml());
  },

  renderTexturesList: function(){
    var listContainer = $('#manufacturers_prodcuts_list');

    // listContainer.html('');
    if($("#texture_list_container").length == 0){
      listContainer.append(this.texturesContainer());
    }

    listContainer = listContainer.find("#texture_list_container");
    listContainer.html('');

    for(var i=0; i < this.textures.length; i++){
      this.currentTexture = this.textures[i];
      this.textureIndex = i;
      this.renderTexture(listContainer);
    }

    this.setActiveTextureIfAny(listContainer);
    this.enableNiceScroll(listContainer);
  },

  renderColorsList: function(){
    var listContainer = $('#manufacturers_prodcuts_list');

    // listContainer.html('');
    if($("#color_list_container").length == 0){
      listContainer.append(this.texturesContainer());
    }

    listContainer = listContainer.find("#color_list_container");
    listContainer.html('');

    for(var i=0; i < this.colors.length; i++){
      this.currentColor = this.colors[i];
      this.colorIndex = i;
      this.renderColor(listContainer);
    }

    this.setActiveColorIfAny(listContainer);
    this.enableNiceScroll(listContainer);
  },

  plantsContainer: function(){
    return  '\
              <div class="plant-title">\
                Plants\
                <a class="items-toggler" href="javascript:void(0);">\
                  <i class="active-submenu pull-right"></i>\
                </a>\
              </div>\
              <div class="plant-list-container" id="plant_list_container">\
              </div>\
            ';
  },

  renderPlant: function(listContainer){
    listContainer.append(this.plantsListHtml());
  },

  setSelectedPlant: function(index){
    this.selectedPlant = this.plants[index];
  },

  setActivePlantIfAny: function(listContainer){
    if(this.selectedPlant == null){
      return;
    }

    var thisAI = this;

    listContainer.find(".plant").each(function(){
      if($(this).data("plant_id") == thisAI.selectedPlant.id){
        $(this).addClass("plant-active");
        return false; // to break the each loop
      }

    });
  },

  renderPlantsList: function(){
    var listContainer = $('#manufacturers_prodcuts_list');

    if($("#plant_list_container").length == 0){
      listContainer.append(this.plantsContainer());
    }

    listContainer = listContainer.find("#plant_list_container");
    listContainer.html('');

    for(var i=0; i < this.plants.length; i++){
      this.currentPlant = this.plants[i];
      this.plantIndex = i;
      this.renderPlant(listContainer);
    }

    this.setActivePlantIfAny(listContainer);
    this.enableNiceScroll(listContainer);
  },

  renderPlants: function(){
    this.plants = this.selectedBrickType.plants;

    if(this.plants.length == 1){
      this.selectedPlant = this.plants[0];
      this.renderTextures();
    }else if(this.plants.length > 1){
      this.renderPlantsList();
    }else{
      alert("Error: Invalid Plants Data");
    }
  },

  renderTextures: function(){
    this.textures = this.selectedPlant.textures;

    if(this.textures.length == 1){
      this.selectedTexture = this.textures[0];
      this.renderColors();
    }else if(this.textures.length > 1){
      this.renderTexturesList();
    }else{
      alert("Error: Invalid Texture Data");
    }
  },

  renderColors: function(){
    this.colors = this.selectedTexture.colors;

    if(this.colors.length == 1){
      this.selectedColor = this.colors[0];
      this.renderBricks();
    }else if(this.colors.length > 1){
      this.renderColorsList();
    }else{
      alert("Error: Invalid Color Data");
    }
  },

  renderSizesList: function(){
    this.renderBrickTypes();
  },

  renderSizes: function(){
    this.sizes = this.selectedProduct.sizes;

    if(this.sizes.length == 1){
      this.selectedBrickType = this.sizes[0];
      this.renderTextures();
    }else if(this.sizes.length > 1){
      this.renderSizesList();
    }else{
      alert("Error: Invalid Sizes Data");
    }
  },

  renderProductData: function(productIndex){

    this.selectedProduct = this.products[productIndex];
    this.productIndex = productIndex;
    this.renderSizes();

    // this.renderDefaultWallOnProductSelectForFirstTime();
  },


  renderProduct: function(listContainer){
    listContainer.append(this.productListHtml());
  },

  renderProducts: function(){
    var listContainer = $($("#left-boxDiv").data("toggle"));

    for(var i=0; i< this.products.length; i++){
      this.currentProduct = this.products[i];
      this.productIndex = i;
      this.renderProduct(listContainer);
    }
  },

  wallHTML: function(){
    return $("div#full-wall").html();
  },

  wallJSON: function(){
    var data = {};

    return data;
    //TODO No need for this mehod remove it.
    var dataArray = [
          "currentProduct",
          "drawProduct",
          "selectedProduct",
          "selectedMortar",
          "initialSelectedMortar",
          "selectedBrick",
          "initialSelectedBrick",
          "useInitiallySelectedBrick",
          "useInitiallySelectedMortar",
          "initialCoursing",
          "useInitiallySelectedCoursing",
          "selectedBrickType",
          "productIndex",
          "currentMortar",
          "mortarIndex",
          "currentBrickType",
          "brickTypeIndex",
          "currentBrick",
          "brickIndex",
          "rowNumber",
          "defaultZoomSize",
          "selectedZoomSize",
          "currentStagger",
          "selectedStagger",
          "selectedWallDimesions",
          "selectedCoursing",
          "useDefaultWallBricksArray",
          "defaultWallBricksArray",
          "baseUnit",
          "inchPixels"
        ]

    for(var i=0; i < dataArray.length; i++){
      data[dataArray[i]] = this[dataArray[i]];
    }

    return data;
  },

  wallDesignId: function(){
    return $("div#full-wall").data("design_id");
  },

  initialize: function(products){
    this.products = products.brick_manufacturers;
    this.mortarManufacturers = products.mortar_manufacturers

    if(this.notDefinedProducts() || this.notDefinedMortars()){
      alert("1. Aborting. Invalid Initialization!");
      return;
    }

    this.renderProducts();
    this.renderMortarManufacturers();

  },

  openDesign: function(designId, designHTML){
    $("#full-wall").html(designHTML);
    $("#full-wall").data("design_id", designId);
    this.pushChangeToUndoRedoStack();
  },

  getWidthInUnits: function(seamlessDimensionX){
    if(this.notDefined( seamlessDimensionX)){
      this.seamlessDimensionX = prompt('Provide width in units to create seamless image', this.seamlessDimensionX);
    }else{
      this.seamlessDimensionX = seamlessDimensionX;
    }
    if(this.seamlessDimensionX != null){
      if(this.seamlessDimensionX.match(/[^0-9]/)){
        alert("Please provide valid input. Allowed only 0-9 values");
        this.getWidthInUnits(seamlessDimensionX);
      }else if(parseInt(this.seamlessDimensionX) < 2){
        alert("Value should be greater than 1");
        this.getWidthInUnits(seamlessDimensionX);
      }else{
        this.seamlessDimensionX = parseInt(this.seamlessDimensionX);
      }
    }
  },

  setHeightForSeamlessWall: function(){
    var width = this.selectedBrick.width * this.seamlessDimensionX,
        unitsY = parseInt(width / this.selectedBrick.height);

    if((unitsY % 2) != 0){
      unitsY--;
    }

    this.seamlessDimensionY = unitsY;
  },

  previewSeamlessDesign: function(){
    $('.show-popup').trigger("click");
    $('.overlay-content').css({  });
    $('#lightbox-content').css({ });
  },

  resetSeamlessDefaults: function(){
    this.useSeamlessDimensions = false;
    this.seamlessDesign = false;
  },

  setSeamlessDefaults: function(){
    this.useSeamlessDimensions = true;
    this.seamlessDesign = true;
  },

  createSeamlessWall: function(){
    this.setSeamlessDefaults();
    this.getWidthInUnits();

    if(this.seamlessDimensionX != null){
      if(this.notValidDimesions()){
        this.resetSeamlessDefaults();
        alert("Invalid Wall dimensions max : " + this.maxWallDimensionX);
        return false;
      }
      this.setHeightForSeamlessWall();
      this.drawSeamlessWall();
      this.previewSeamlessDesign();
    }else{
      this.seamlessDimensionX = 2;
    }
    this.resetSeamlessDefaults();
  },

  canFillRandom: function(){
    var canFillRandom = true,
        brick = this.getBrick();

    $("span.item img").each(function(){
      var height = $(this).height(),
          width = $(this).width();

      if(brick.height != height || brick.width != width){
        canFillRandom = false;
        return false; // get out of each loop
      }

    });

    return canFillRandom;
  },

  createRandomizedFillArray: function(items, rows){
    if(this.notDefined(items)){
      var items = "span.item";
    }

    if(this.notDefined(rows)){
      var rows = "span.span-row";
    }

    var numberOfbricks = $(items).length;
    var numberOfRows = $(rows).length;
    var randomRange = this.dimensionX + 1;
    var numberOfbricksTobeFilledRandomly = Math.round((numberOfbricks * this.fillPercentage) / 100);
    var numberOfbricksTobeFilledRandomlyInEachRow = Math.round(numberOfbricksTobeFilledRandomly / numberOfRows);

    this.randmoizedFillArray = [];

    for(var i=0; i < numberOfRows; i++){
      this.randmoizedFillArray[i] = this.getRandomArray(numberOfbricksTobeFilledRandomlyInEachRow, randomRange);
    }
  },

  fillWallWithFillRandom: function(item){
    if(this.notDefined(item)){
      var item = "#item-";
    }

    var el;

    for(var i=0; i < this.randmoizedFillArray.length; i++){
      for(var j=0; j < this.randmoizedFillArray[i].length; j++){
        el =  $(item + i + "-" + this.randmoizedFillArray[i][j]);
        if(el.length > 0){
          $(item + i + "-" + this.randmoizedFillArray[i][j]).trigger("click");
        }
      }
    }
  },

  fillRandom: function(fillPercentage){
    if(this.canFillRandom()){
      this.fillPercentage = fillPercentage;
      this.createRandomizedFillArray();
      this.fillWallWithFillRandom();
    }else{
      alert("Wall can't be filled randomly.\nDimesions of the selected product and products in the wall doesn't match.");
    }
  },

  saveAsImage: function(){
    $("div#full-wall-copy").html($("div#full-wall").html());
    $("div#full-wall-copy").show();

    this.zoomWallBy(this.defaultZoomSize, "div#full-wall-copy", false);

    html2canvas($("div#full-wall-copy"), {
      onrendered: function(canvas) {
        var base64Img = canvas.toDataURL("image/jpeg", 1.0);
        var myWindow = window.open("", "_blank", "width=800, height=600");
        myWindow.document.write('<img src="' + base64Img + '">');
        $("div#full-wall-copy").hide();
      }
    });

  },

  setBodyToOnlyWall: function(){
    $('body').html($("div#full-wall"));
  },

  zoomWallBy: function(scale, container, setScale){
    if(typeof(container) === UNDEFINED || container == null){
      container = "div#full-wall";
    }
    if(typeof(setScale) === UNDEFINED || setScale == null){
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
  },

  zoomWallInAndOut: function(zoomIn, zoomOut){
    var scale = this.scale,
        wallContainer = $("div#full-wall");

    if(zoomIn){
      scale += 0.1;
    }else if(zoomOut){
      scale -= 0.1;
    }else{
      scale = 1;
    }

    if(scale > 3){
      scale = 3;
    }else if(scale < 0.2){
      scale = 0.2
    }

    wallContainer.css("-webkit-transform", "scale(" + scale + ")");
    wallContainer.css("-moz-transform", "scale(" + scale + ")");
    wallContainer.css("-ms-transform", "scale(" + scale + ")");
    wallContainer.css("-o-transform", "scale(" + scale + ")");
    wallContainer.css("transform", "scale(" + scale + ")");

    this.scale = scale;
  },

  convertInInches: function(unit, dimensionType) {
    var unitsInInches;

    if(dimensionType == FEET){
      unitsInInches = unit * 12;
    }else if(dimensionType == METERS){
      unitsInInches = unit * 39.38; // Rounded value, actual is 39.37007874
    }

    return unitsInInches;
  },

  sizeToolConvert: function(width, height, dimensionType){
    var area = this.convertInInches(width, dimensionType) * this.convertInInches(height, dimensionType),
        brick = this.getBrick(),
        mortar = this.getMortar(),
        brickArea, bricksRequired;

    brickArea = (brick.occupiedWidth + mortar.occupiedLeft + mortar.occupiedRight) * (brick.occupiedHeight + mortar.occupiedTop + mortar.occupiedBottom)

    return Math.round(area / brickArea) + 1;
  },

  showSizeToolHTML: function(){
    return  '\
                <div id="size_tool_container">\
                 <div class="custom-overlay"></div>\
                    <form name="size_tool_form" id="size_tool_form" class="sign-up">\
                     <h1 class="sign-up-title">Size</h1>\
                      <div id="size_tool_form_input_container">\
                        <div class="row">\
                          <div class="col-xs-4">\
                            <select name="dimension_type" class="sign-up-input right-padding" required id="size_tool_dimension_type" >\
                              <option value="1">Feet</option>\
                              <option value="2">Meters</option>\
                            </select>\
                           </div>\
                       <div class="col-xs-4">\
                            <input type="number" name="width" class="sign-up-input right-padding"  required id="size_tool_width" required placeholder="Width*" />\
                          </div>\
                          <div class="col-xs-4">\
                            <input type="number" name="height" class="sign-up-input right-padding" required id="size_tool_height" required placeholder="Height*" />\
                         </div>\
                      </div>\
                       <div class="vspace"></div>\
                      <input type="submit" value="Convert" class="sign-up-button" id="size_tool_btn" />\
                    </form>\
                       <div class="vspace"></div>\
                   <div class="row font-size-20">\
                      <div class="col-md-12">\
                        <label>Total number of bricks required are : <span class="red" id="total-brikcs-required"></span></label>\
                      </div>\
                    </div>\
                  </div>\
              ';
  },

  sizeTool: function(){
    $("#lightbox-content").html(this.showSizeToolHTML());
    $('.show-popup').trigger("click");
  }

};
