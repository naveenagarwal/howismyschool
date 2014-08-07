var HALF = 2,
    ONE_THIRD = 3,
    NONE = 0,
    STANDARD = 0,
    RUNNING = 1,
    HEADERS = 2,
    UNDEFINED = "undefined";

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
  useInitiallySelectedBrick: false,
  useInitiallySelectedMortar: false,
  initialCoursing: null,
  useInitiallySelectedCoursing: false,
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
  coursingTypes: ["standard", "running", "headers"], // order of array matters dont change it
  selectedCoursing: 0, // 0 means standard, it is the index of coursingtypes array
  bricksArray: [],
  thisBrickItem: null,
  maxImageVariant: 17,
  imgIndex: null,
  thisBrickItemX: 0,
  thisBrickItemY: 0,
  useDefaultWallBricksArray: false,
  defaultWallBricksArray: [
      [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,2],
      [3,14,0,12,10,8,9,15,11,6,4,2,1,5,7,13,0],
      [15,13,11,9,7,5,3,1,2,0,14,12,10,8,6,4,15],
      [14,2,10,8,6,4,12,0,15,13,11,9,7,5,3,1,13],
      [13,11,9,7,5,3,1,2,4,6,8,10,12,14,0,15,8],
      [12,10,8,6,4,2,14,0,1,3,5,7,9,15,11,13,3],
      [11,9,7,5,3,1,13,15,2,4,6,8,10,12,14,0,11],
      [10,8,0,6,14,4,12,1,3,15,2,5,7,9,11,13,9],
      [9,15,14,13,0,2,3,8,7,11,10,12,8,1,4,5,10],
      [8,15,0,7,2,1,9,3,10,4,11,5,12,14,13,6,12],
      [7,0,15,14,13,11,6,12,10,9,8,5,4,3,2,1,14],
      [6,1,2,0,8,9,10,15,14,13,12,11,7,4,5,3,1],
      [5,15,10,1,0,2,13,11,4,3,14,12,8,6,7,9,4],
      [4,9,3,11,8,15,14,12,13,7,6,10,5,2,0,1,5],
      [1,10,0,13,2,11,9,15,14,12,5,4,3,7,6,8,6],
      [2,12,3,11,9,13,0,1,4,7,8,6,10,5,15,14,7]
    ],

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
  },

  redo: function(){
    if(this.currentUndoRedoLevel == (this.undoRedoStack.length - 1) ){
      return;
    }
    this.currentUndoRedoLevel++;
    $("#full-wall").html(this.undoRedoStack[this.currentUndoRedoLevel]);
  },

  notDefinedProducts: function(){
    if(typeof(this.products) === UNDEFINED || this.products == null){
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

  getRandomArray: function(){
    var val, array = [];

    for(var i=0; i < 16;){
      val = Math.floor(Math.random() * 16);
      if(array.indexOf(val) == -1){
        array.push(val);
        i++;
      }
      if(array.length >= 16){
        break;
      }
    }
    return array;
  },

  setRandomBrick: function(element){
    var i,x,y, array = this.getRandomArray();

    if(this.useDefaultWallBricksArray){
      this.imgIndex = this.defaultWallBricksArray[this.thisBrickItemX][this.thisBrickItemY];
    }else{
      x = this.thisBrickItemX;
      y = this.thisBrickItemY;
      for(i=0; i < array.length; i ++){
        if(this.previousRowOk(array[i],x,y) && this.currentRowOk(array[i],x,y) && this.nextRowOk(array[i],x,y) ){
          element.find("img:first").attr("src", this.getBrick().imgUrlArray[array[i]]);
          element.data("imgindex", array[i]);
          console.log(array[i]);
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

    this.setImageIndex();

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

    switch(coursing){
      case STANDARD:
        // return brick;
        break;
      case RUNNING:
        // return brick.running;
        brick = brick.running
        break;
      case HEADERS:
        // return brick.header;
        brick = brick.header;
        break;
    }

    brick.imgUrl = brick.imgUrlArray[this.imgIndex];
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
              <div class="brick">\
                <div>'+ this.currentBrick.name +'</div>\
                <a href="javascript:void(0)" class="brick" data-brick_index="'+ this.brickIndex +'" data-brick_id="'+ this.currentBrick.id +'" >\
                  <img src="' + this.currentBrick.imgUrl + '" />\
                </a>\
              </div>\
            ';
  },

  renderEvenWallHtml: function(elementPosition){
    var brick = this.getBrick();
    var mortar = this.getMortar();
    var imgIndex = brick.imgUrlArray.indexOf(brick.imgUrl);

    return  '\
              <span id=item-"'+ elementPosition +'" data-imgIndex="'+ imgIndex +'" data-coursing="'+ this.getCoursing() +'" class="item" data-row="'+ this.rowNumber +'" data-brick_index="'+ elementPosition +'" data-image_id="'+ brick.id +'">\
                <span style="'+ this.innerDivstyle() +'">\
                  <img style="'+ this.brickImgStyle(brick) +'" src="'+ brick.imgUrl +'">\
                </span>\
              </span>\
            ';
  },

  calcNumberOfBricksX: function(width, brick){
    var mortar = this.getMortar();
    var brickWithMortorSize = brick.width + mortar.left + mortar.right;

    return parseInt((width / brickWithMortorSize));
  },

  calcNumberOfBricksY: function(width, brick){
    var mortar = this.getMortar();
    var brickWithMortorSize = brick.height + mortar.left + mortar.right;

    return parseInt((width / brickWithMortorSize));
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
      element.data("imgindex", brick.imgUrlArray.indexOf(brick.imgUrl));
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

  fillRowEvenCoursing: function(){
    var row = $('.row-' + this.rowNumber),
        elements = row.find("span.item:nth-child(odd)");

    elements.each(function(){
      $(this).trigger("click");
    });

    if(parseInt(row.data("coursing")) != this.selectedCoursing){
      //reassign elements as number of elements may have changed if different coursing has been set
      elements = row.find("span.item:nth-child(odd)");

      elements.each(function(){
        var el = $(this);
        if(el.next().html() != undefined && el.find("img").attr("src") == el.next().find("img").attr("src")){
          el.trigger("click");
          el.nextAll("span.item:nth-child(odd)").each(function(){
            $(this).trigger("click");
          });
        }
      });
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
      var brick = this.getBrick();
      var imgIndex = brick.imgUrlArray.indexOf(brick.imgUrl);
    }
    return  '\
              <span id="item-'+ elementPosition +'" data-imgIndex="'+ imgIndex +'" data-coursing="'+ this.selectedCoursing +'" style="'+ style +'" class="item" data-row="'+ this.rowNumber +'" data-brick_index="'+ elementPosition +'" data-image_id="'+ brick.id +'">\
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

  fillMortarFull: function(){
    var mortar = this.getMortar();

    $(".item").css('background-image', 'url("'+ mortar.fillImage +'")');
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
    $('.row-' + this.rowNumber +  ' .item').css('background-image', 'url("'+ mortar.fillImage +'")');
    $('.row-' + this.rowNumber +  ' .item').css('background-repeat', 'repeat');
    $('.row-' + this.rowNumber +  ' .item > span').attr('style', this.innerDivstyle());
  },

  fillRowEvenMortar: function(){
    var mortar = this.getMortar();
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd)').css('background-image', 'url("'+ mortar.fillImage +'")');
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd)').css('background-repeat', 'repeat');
    $('.row-' + this.rowNumber +  ' .item:nth-child(odd) > span').attr('style', this.innerDivstyle());
  },

  fillMortarItem: function(item){
    var mortar = this.getMortar();
    item.css('background-image', 'url("'+ mortar.fillImage +'")');
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

  enableContextMenu: function(){
    $(".item").contextMenu({
      menu: 'AIMenu'
      }, function(action, el, pos) {
        AccurateImage.rowNumber = parseInt(el.parent().data("row"));
        AccurateImage[action]();
        AccurateImage.pushChangeToUndoRedoStack();
        AccurateImage.enableContextMenu();
    });
  },

  calulateRowWidth: function(){
    var brick = this.getBrick();
    var mortar = this.getMortar();
    return (this.dimensionX * (brick.width + mortar.left + mortar.right));
  },

  calulateRowHeight: function(){
    var brick = this.getBrick();
    var mortar = this.getMortar();
    return brick.height + mortar.top + mortar.bottom;
  },

  setInitialDefaults: function(){
    this.initialSelectedBrick = this.selectedBrick;
    this.initialSelectedMortar = this.selectedMortar;
    this.initialCoursing = this.selectedCoursing;
  },

  drawWall: function(){
    var elementPosition,
        evenRow,
        rowContainer,
        wallContainer = $("#full-wall");

    wallContainer.html("");

    this.setInitialDefaults();
    this.useDefaultWallBricksArray = true;

    for(var i=0; i < this.dimensionY; i++){
      this.rowNumber  = i;
      evenRow         = i%2 == 0 ? true : false;
      rowContainer    = $('<span data-stagger="'+ (evenRow ? NONE : this.selectedStagger) +'" data-coursing="'+ this.selectedCoursing +'" style="width: '+ this.calulateRowWidth() +'px; height:'+ this.calulateRowHeight() +'px;" class="row row-'+ (i + 1) +'" data-row="'+ (i + 1) +'"></span>');
      this.bricksArray[i] = [];
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
    this.bricksArray = this.defaultWallBricksArray;
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

  setSelectedCoursing: function(coursing){
    this.selectedCoursing = this.coursingTypes.indexOf(coursing);
    if(this.selectedCoursing == -1){
      this.selectedCoursing = 0;
    }
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
        var base64Img = canvas.toDataURL("image/jpeg", 1.0);
        var myWindow = window.open("", "_blank", "width=800, height=600");
        myWindow.document.write('<img src="' + base64Img + '">');
        $("div#full-wall-copy").hide();
      }
    });

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
  }

};