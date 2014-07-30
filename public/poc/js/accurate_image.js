var HALF = 2,
    ONE_THIRD = 3,
    NONE = 0,
    STANDARD = 0,
    RUNNING = 1,
    HEADERS = 2;

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
      coursing = this.selectedCoursing
    }

    switch(coursing){
      case STANDARD:
        return brick;
        break;
      case RUNNING:
        return brick.running;
        break;
      case HEADERS:
        return brick.header;
        break;
    }
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
  brickImgStyle: function(){
    var brick = this.getBrick();
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
    return  '\
              <span data-coursing="'+ this.selectedCoursing +'" class="item" data-row="'+ this.rowNumber +'" data-brick_index="'+ elementPosition +'" data-image_id="'+ brick.id +'">\
                <span style="'+ this.innerDivstyle() +'">\
                  <img style="'+ this.brickImgStyle() +'" src="'+ brick.imgUrl +'">\
                </span>\
              </span>\
            ';
  },

  calcNumberOfBricksX: function(width){
    var brick = this.getBrick();
    var mortar = this.getMortar();
    var brickWithMortorSize = brick.width + mortar.left + mortar.right;

    return parseInt((width / brickWithMortorSize));
  },

  calcNumberOfBricksY: function(width){
    var brick = this.getBrick();
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
    var row = element.parent()
    var rowCoursing = parseInt(element.parent().data("coursing"));
    var performCoursing = false, lastBrickIndex, lastElWidth, lastElImgWidth;
    var margin = occupiedWidth = width = 0;
    var stagger, rowWidth, numberOfBricksX, elementPosition, brick;

    row.find("span.item").each(function(){
      if(parseInt($(this).data("coursing")) != coursingType){
        performCoursing = true;
        return false;
      }
    });

    if(!performCoursing){
      return ;
    }

    this.rowNumber = parseInt(row.data("row"));
    stagger = parseInt(row.data("stagger"));

    if(performRowCoursing){
      rowWidth = row.width();
      numberOfBricksX = this.calcNumberOfBricksX(rowWidth);
      row.html("");

      for(var j=0; j < numberOfBricksX; j++){
        elementPosition = this.rowNumber - 1 + "-" + j
        row.append(this.renderEvenWallHtml(elementPosition));
      }

      if(stagger != NONE){
        margin = this.staggeredFirstElementLeftMarginStyle();
        row.find("span.item:first").css("margin-left", "-" + margin + "px");
      }

      occupiedWidth = this.calcOccupiedWidth(row) - margin;
      if(row.width() != occupiedWidth){
        elementPosition = this.rowNumber - 1 + "-" + j;
        row.append(this.renderEvenWallHtml(elementPosition));
        width = row.width() - occupiedWidth;
        maxWidth = this.getBrick().width + this.selectedMortar.left + this.selectedMortar.right;
        if(width > maxWidth){
          elementPosition = this.rowNumber - 1 + "-" + (j + 1);
          row.append(this.renderEvenWallHtml(elementPosition));
          width = width - maxWidth;
        }
        row.find("span.item:last").css("width", width + "px");
      }

      row.css("height", this.calulateRowHeight());
      row.data("coursing", coursingType);
    } // End if for performRowCoursing
    else{
      brick = this.getBrick();

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

      console.log("margin front is - " + marginFront);
      element.find("img").attr("src", brick.imgUrl);
      element.find("img").css({"height": brick.height, "width": brick.width});
      element.css({"width": brick.width });
      row.find("span.item:first").css({"margin-left": "-" + marginFront + "px"});

      lastElWidth = row.find(".item:last").width();
      lastElImgWidth = row.find(".item:last").find("img").width();

      occupiedWidth = this.calcOccupiedWidth(row) - marginFront;
      console.log("occupied width is " + occupiedWidth);

      if(lastElWidth != lastElImgWidth && lastElWidth < lastElImgWidth && row.width() > occupiedWidth){
        console.log("Last El width is " + lastElWidth);
        row.find(".item:last").css("width", lastElImgWidth);
        occupiedWidth = this.calcOccupiedWidth(row) - marginFront;
      }

      this.useInitiallySelectedCoursing  = this.useInitiallySelectedBrick = this.useInitiallySelectedMortar = true;

      numberOfBricksX = this.calcNumberOfBricksX(width);
      console.log("numberOfBricksX - " + numberOfBricksX);

      for(var i=0; i < numberOfBricksX; i ++){
        elementPosition = this.rowNumber - 1 + "-" + (i + 1 + parseInt(row.find(".item:last").data("brick_index").split("-")[1]));
        row.append(this.renderEvenWallHtml(elementPosition));
      }

      occupiedWidth = this.calcOccupiedWidth(row) - marginFront;
      console.log("occupied width after loop - " + occupiedWidth);
      lastBrickIndex = parseInt(row.find(".item:last").data("brick_index").split("-")[1]);

      brick = this.getBrick();

      if(row.width() > occupiedWidth){
        console.log("occupied width is less than row width, occupied width is - " + occupiedWidth);
        elementPosition = this.rowNumber - 1 + "-" + (lastBrickIndex + 1);
        row.append(this.renderEvenWallHtml(elementPosition));

        width = row.width() - occupiedWidth;
        maxWidth = brick.width + this.selectedMortar.left + this.selectedMortar.right;

        if(width > maxWidth){
          elementPosition = this.rowNumber - 1 + "-" + (lastBrickIndex + 2);
          row.append(this.renderEvenWallHtml(elementPosition));
          width = width - maxWidth;
        }
      }else if(row.width() < occupiedWidth){
        width = row.width() - this.calcOccupiedWidth(row) + marginFront;
        console.log("occupied width is greater - extra width is " + width);
        width = row.find("span.item:last").width() + width;
      }else if(row.width() == occupiedWidth){
        console.log("occupied width is equal to row width");
        width = row.find("span.item:last").width();
      }
      row.find("span.item:last").css("width", width + "px");
      //Incase ethe width becomes zero - it happens when width goes in negative
      if(row.find("span.item:last").width() == 0){
        var el;
        while(true){
          el = row.find("span.item:last");
          row.find("span.item:last").remove()
          width = this.calcOccupiedWidth(row) - marginFront;
          if(row.width() > width){
            row.append(el);
            break;
          }
        }
        console.log("width becomes zero");
        //recalculate the width for the last item to be set
        console.log("function returns width is - " + this.calcOccupiedWidth(row));
        width = row.width() - this.calcOccupiedWidth(row) + row.find("span.item:last").width() + marginFront;
        console.log("last width to be set is - " + width);
        row.find("span.item:last").css("width", width + "px");
      }

      this.useInitiallySelectedCoursing  = this.useInitiallySelectedBrick = this.useInitiallySelectedMortar = false;
    } // End of else part

    this.fillRowMortar();
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
    }
    return  '\
              <span data-coursing="'+ this.selectedCoursing +'" style="'+ style +'" class="item" data-row="'+ this.rowNumber +'" data-brick_index="'+ elementPosition +'" data-image_id="'+ brick.id +'">\
                <span style="'+ this.innerDivstyle() +'">\
                  <img style="'+ this.brickImgStyle() +'" src="'+ brick.imgUrl +'">\
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

    for(var i=0; i < this.dimensionY; i++){
      this.rowNumber  = i;
      evenRow         = i%2 == 0 ? true : false;
      rowContainer    = $('<span data-stagger="'+ (evenRow ? NONE : this.selectedStagger) +'" data-coursing="'+ this.selectedCoursing +'" style="width: '+ this.calulateRowWidth() +'px; height:'+ this.calulateRowHeight() +'px;" class="row row-'+ (i + 1) +'" data-row="'+ (i + 1) +'"></span>');

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