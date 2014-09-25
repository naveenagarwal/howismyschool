function svgClear() {
   svg.clear();
}

$(function() {
	$.globalVars = {
	    minTop: $('#dropZone').offset().top,
	    minLeft: $('#dropZone').offset().left
	};
});

function svgDrawLine(eTarget, eSource) {

	joiningLinesDrawn = 1;
    
    isIE = false
	jQuery.each(jQuery.browser, function(i, val) {
      if(i == 'msie' && val){
      	isIE = true;
      }
    });

    // wait 1 sec before draw the lines, so we can get the position of the draggable
    setTimeout(function () {
        var $source = eSource;
        var $target = eTarget;

        var containerTop = $('#dropZone').offset().top;
        //alert($source.offset().left);
        
        var ieX = 0;
        if(isIE){
          ieX = 3.5;
        }

        // origin -> ending ... from left to right
        // 10 + 10 (padding left + padding right) + 2 + 2 (border left + border right)
		//RULE : Width of dialog div - 70
		var distance = 0;
		var s = 248 + ($(window).width()-1007)/4.8;
		var s2 = 45 + ($(window).width()-1007)/5;

        //var originX = $source.offset().left + 165 + 4;
		//var originX = $source.offset().left -64 -ieX;
		var originX = $source.parent().parent().parent().parent().offset().left - s2 -ieX;
//		var originX = $source.offset().left +  4;
//		alert($source.offset().left+ '='+ $source.width())



        var originY = $source.offset().top + (($source.height() + 20 + 4) / 2)-12 - containerTop;
        //alert(originY)

        //var endingX = $target.offset().left - 246 - ieX;
        var endingX = $target.offset().left - s -ieX;
        var endingY = $target.offset().top + (($target.height() + 20 + 4) / 2)-15 - containerTop;

        var space = 20;
        //var color = colours[random(9)];
		var color = 'blue';

        // draw lines
        // http://raphaeljs.com/reference.html#path			
        var a = "M" + originX + " " + originY + " L" + (originX + space) + " " + originY; // beginning
        var b = "M" + (originX + space) + " " + originY + " L" + (endingX - space) + " " + endingY; // diagonal line
        var c = "M" + (endingX - space) + " " + endingY + " L" + endingX + " " + endingY; // ending
        var all = a + " " + b + " " + c;

       /*
        // log (to show in FF (with FireBug), Chrome and Safari)			
        console.log("New Line ----------------------------");
        console.log("originX: " + originX + " | originY: " + originY + " | endingX: " + endingX + " | endingY: " + endingY + " | space: " + space + " | color: " + color );				
        console.log(all); 
        */

        // write line
		var id = $target.attr('id')+'__'+$source.attr('id');
        var obj = svg
				.path(all)
				.attr({
				   "stroke": '#000b9d',
				   "stroke-width": 3,
				   "stroke-dasharray": "",
				   "fill" : "#245EDC"
				}).node.id = 'path_'+id;
		
		$('#path_'+id).bind('click',function(){
			deleteJoinLinks(id);
		});
        
        myLines[myLines.length] = obj;
		
		var cir = svg.circle(originX, originY, 5);
		cir.attr("fill", "#245EDC").node.id='cir1_'+id;
		var cir = svg.circle(endingX, endingY, 5);
		cir.attr("fill", "#245EDC").node.id='cir2_'+id;;

    }, 10);

}

function deleteJoinLinks(id){
	if(!confirm("Do you want to delete this join ?")){
		return false;
	}

	var pathId = $('#path_'+id);
	var cir1Id = $('#cir1_'+id);
	var cir2Id = $('#cir2_'+id);

	id = id.replace('__',',');
	var cnt = joinArray.length;
    for(var i =0;i<cnt;i++){
	   if(joinArray[i] == id){
		   joinArray.splice(i,1);
		   break;
	   }
    }
	pathId.remove();
	cir1Id.remove();
	cir2Id.remove();

	adjustTableMinHeighResizeLimit();
}

function random(range) {
    return Math.floor(Math.random() * range);
}
var gLeftPos = 0;
var gTopPos = 0;
var maxWidth = 175;var minHeight = 60;var minWidth = 175;


function addTableStructure(ele){
	   var id   = $(ele).attr('id');
	   var parentId = $(ele).parent().attr('id');
	   //fetch column lists
	   $('#'+parentId+' .expandable-hitarea').trigger('click');

	   var idArr = id.split('__');
	   //var name = idArr[1]+ ' of '+idArr[0];
	   var name = idArr[1].substring(0,19);

	   id = id.replace('.','_');
       
	   var cnt = divArray.length;
	   for(var i=0;i<cnt;i++){
		   if(divArray[i] == '#div_'+id){
			   alert("You can not add same table more than once");
			   return false; //can not add same table twice
		   }
	   }
	   divArray.push('#div_'+id);

	   var lis  = $(ele).parent().find('ul>li');
	   var size = lis.length;
	   var html = '';
	   html += '<ul>';
	   var row = 'odd';
	   for(var i =0;i<size;i++){
		   row = row == 'odd'?'even':'odd';
		   html += '<li id="'+$(lis[i]).attr("id")+'" class="'+row+'">';
		   var fname = $(lis[i]).find('a').html().substring(0,14);
		   html += '<input type="checkbox" name="chk" onclick="addToCondition(this);" alt="'+$(lis[i]).html()+'" /><a id="a_'+$(lis[i]).attr("id")+'">'+fname+'</a>';
		   html += '</li>';
	   }
	   html += '</ul>';
	   var maxSize = (size*18+35);
	   var minSize = minHeight;
	   var inp = '<input type="hidden" name="minSize" id="minSize_'+id+'" value="'+minHeight+'" />';
	   html += inp;
	   html = '<div id="div_'+id+'" class="divTables"><div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"><span id="ui-id-1" class="ui-dialog-title">'+name+'</span><a href="javascript:void(0);" class="ui-dialog-titlebar-close ui-corner-all" role="button" onclick=closeTableStructure("'+id+'");><span class="ui-icon ui-icon-closethick">close</span></a></div><div class="innerDivTable">'+html+'</div></div>';
	   $('#dropZone').append(html);
       
       $('#div_'+id).wrap('<div class="ui-wrapper"/>');
	   $('#div_'+id).resizable({
		   maxHeight: maxSize,
		   maxWidth:maxWidth,
		   minHeight:minHeight,
		   minWidth:minWidth,
		   stop:function(){
            //redrawJoiningLines();
  		   }
	   });

     $('#div_'+id+' ul').sortable({
        zIndex: 10000,
        revert: true
       });

       $('#div_'+id+' ul>li>a').draggable({
        appendTo: "body",
        helper: "clone",
        zIndex: 10000
       });

	   $('#div_'+id+' ul>li').droppable({
        //activeClass: "ui-state-default",
        //hoverClass: "ui-state-hover",
        drop: function(event, ui) {
			  //alert(ui.draggable.parent().attr("id")+'--'+$(this).attr('id'));
			  //return;
			  var draggableId = ui.draggable.parent().attr("id");

			  var draggableTable = ui.draggable.parent().parent().parent().parent().attr("id").replace('div_','');
			  var dragColumnSize = ((ui.draggable.parent().parent().find('li').index(ui.draggable.parent())+1)*18+35);
			  var minSize = $('#minSize_'+draggableTable);
			  if(dragColumnSize > minSize.val()){
				  minSize.val(dragColumnSize);
				  $('#'+ui.draggable.parent().parent().parent().parent().attr("id")).resizable({
					   minHeight:dragColumnSize,
				   });
			  }
			  var draggableTableArr = draggableTable.split('_');
			  var name1 = draggableTableArr[1]+' table of ' + draggableTableArr[0]+' database';

			  /*
			  var droppableId = $(this).parent().attr("id");
			  var droppableTable = $(this).parent().parent().parent().parent().attr("id").replace('div_','');
			  var droppableTableArr = droppableTable.split('_');
			  var name2 = droppableTableArr[1]+' table of ' + droppableTableArr[0]+ ' database';
			  */
			  var droppableId = $(this).attr("id");
			  var droppableTable = $(this).parent().parent().parent().attr("id").replace('div_','');
			  var dragColumnSize = (($(this).parent().find('li').index($(this))+1)*18+35);
			  var minSize = $('#minSize_'+droppableTable);
			  if(dragColumnSize > minSize.val()){
				  minSize.val(dragColumnSize);
				  $('#'+$(this).parent().parent().parent().attr("id")).resizable({
					   minHeight:dragColumnSize,
				  });
			  }

			  var droppableTableArr = droppableTable.split('_');
			  var name2 = droppableTableArr[1]+' table of ' + droppableTableArr[0]+ ' database';

			  if(draggableTable == droppableTable){
				  return false; //can not self-join
			  }

			  if( ('a_'+droppableId == 'a_dropZone') || ('a_'+draggableId == 'a_dropZone')){
			  	 return false;
			  }

			  $(this).find('a').attr('id','a_'+droppableId);
			  $(ui.draggable).attr('id','a_'+draggableId);

			  //alert('Dr='+droppableId);

			  joinArray.push($(this).find('a').attr('id')+','+ $(ui.draggable).attr('id'));

			  svgDrawLine($(this).find('a'), $(ui.draggable));

			  //alert('JOIN='+draggableId+' column of '+name1+' to '+droppableId+ ' column of '+name2);
			//alert(ui.draggable.text()+'---'+ui.droppable.text())
            //$("<li></li>").text(ui.draggable.text()).appendTo(this);
        }
       })
       
       /*stop the dialog ?*/
	   var cnt = divArray.length;
	   if(cnt){
		   gLeftPos = $(divArray[cnt-1]).width() -125;
		   if(gLeftPos>= 850){
			   gLeftPos = 215;
			   gTopPos = $(divArray[cnt-1]).parent().offset().top + $(divArray[cnt-1]).parent().height() + 30;
		   }
	   }else{
         gLeftPos = gTopPos = 0;
	   }

	   
	   $('#div_'+id).parent('.ui-wrapper').draggable({
		   'handle' : '.ui-dialog-titlebar',
		   containment: [$.globalVars.minLeft,$.globalVars.minTop-25] ,
		   //containment: '#dropZone' ,
		   start: function(e, ui) {
			   //alert(e.originalEvent.target)
				if ($(e.originalEvent.target).is(".scroll")){
					e.preventDefault();
				}
		   },

		   stop:function(e, ui){
            redrawJoiningLines();
		   }
	   });


	   $('#div_'+id).addClass('ui-dialog ui-widget ui-widget-content ui-corner-all');

	   /*

       var d = $('#div1_'+id).dialog(
		                     {
		                       position: { my: "left top",at:"left top", of: '#dropZone' },
							   title : name,
							   width : 175,
							   //height:120,
							   resizable:true,
							   autoOpen:"false", 
							   stack:"true",
							   dialogClass : 'dlgClass',
							  // appendTo : '#dropZone',
							   dragStop: function( event, ui ) {
								   redrawJoiningLines();
							   },
							   close: function( event, ui ) {
								   var cnt = divArray.length;
								   for(var i =0;i<cnt;i++){
									   if(divArray[i] == '#'+$(this).attr('id')){
										   divArray.splice(i,1);
										   break;
									   }
								   }
								   removeTablesFieldFromCondition($(this).attr('id'));
								   //alert(divArray);
								   $(this).html('');
								   $(this).dialog('destroy').remove();
                                   redrawJoiningLines();
							   }
							 }
						 ).parent().draggable({
							scroll: true,
						    scrollSensitivity: 100,
							containment: '#dropZone',
        				});
		*/

		
		//alert("L="+gLeftPos+" T="+gTopPos);

		if(divArray.length>1){
			//$('#div_'+id).css('left','50px');
		}
		if(gLeftPos){
			//$('#div_'+id).css('left',gLeftPos+'px');
		}
		if(gTopPos){
			//$('#div_'+id).parent().css('top',gTopPos+'px');
		}
}

   function closeTableStructure(id){
	   var cnt = divArray.length;
	   for(var i =0;i<cnt;i++){
		   if(divArray[i] == '#div_'+id){
			   divArray.splice(i,1);
			   break;
		   }
	   }
	   removeTablesFieldFromCondition('div_'+id);
	   $('#div_'+id).remove();
	   redrawJoiningLines();

	   adjustTableMinHeighResizeLimit();
   }

   function redrawJoiningLines(){
		   var cnt = joinArray.length;
		   if(cnt){
			   svgClear();
		   }
		   var tempArr = new Array();
		   for(var i=0;i<cnt;i++){
			   var argArr = joinArray[i].split(',');
			   if($('#'+argArr[0]).length && $('#'+argArr[1]).length){
			    svgDrawLine($('#'+argArr[0]), $('#'+argArr[1]));
			   }
			   else{
				   //joinArray.splice(i,1); //deleting here causing problem with array indexing
				   tempArr.push(joinArray[i]);
			   }
		   }

		   var cnt = tempArr.length;
		   for(var i=0;i<cnt;i++){
              if(tempArr[i]!='' && joinArray[0]!=''){
               joinArray.splice(joinArray.indexOf(tempArr[i]),1);
			  }
		   }
   }

   function adjustTableMinHeighResizeLimit(){
	   var cnt = joinArray.length;
	   var tempJoinArray = new Array();
	   for(var i=0;i<cnt;i++){
		   if(joinArray[i] == ''){
			   continue;
		   }
		   var arr = joinArray[i].split(',');
		   
		   var a = arr[0].replace('a_','');
		   var b = arr[1].replace('a_','');
		   if($.inArray(a,tempJoinArray) == '-1'){
			   tempJoinArray.push(a);
		   }
		   if($.inArray(b,tempJoinArray) == '-1'){
			   tempJoinArray.push(b);
		   }
	   }
	   var cnt = divArray.length;
	   for(var i=0;i<cnt;i++){
		   var lis = $(divArray[i]+' .ui-sortable').find('li');
		   var liCnt = lis.length;
		   var maxIndex = 1;
		   for(var j=0;j<liCnt;j++){
			   if($.inArray($(lis[j]).attr('id'),tempJoinArray)!='-1'){
				   var gIndex = lis.index($(lis[j]))+1;
				   if(gIndex>maxIndex){
					   maxIndex = gIndex;
				   }
			   }
		   }
           
		   var dragColumnSize = minHeight;

		   if(maxIndex!='1'){
			   var dragColumnSize = (maxIndex*18+35);
		   }
		   //alert("D="+divArray[i]+" I="+dragColumnSize);
		   $(divArray[i]+' input[name^="minSize"]').val(dragColumnSize);
		   $(divArray[i]).resizable({
		    minHeight:dragColumnSize,
		  });
		  if(dragColumnSize>minHeight){
		   $(divArray[i]).css('height',dragColumnSize);
		  }
	   }
   }



function addToCondition(ele){
 //var originX = $(ele).offset().left + $(ele).width() + 20 + 4;
 ele = $(ele);
 var parent  = $(ele).parent();
 //alert(ele.attr('checked'))
 //var parentA = parent.find('a');
 //var fieldName = $(ele).attr('alt')+'('+parent.attr('id').replace(/-/g,'.')+')';
 var fieldName = $(ele).attr('alt');
 if(!ele.attr('checked')){
   removeFromCondition(parent.attr('id'));
   return false;
 }

 var dbField = parent.attr('id');

 //var chk = '<input type="checkbox" name="chk" id="chk_'+parent.attr('id')+'" />';
 var remove = '<a href="javascript:void(0);" onclick=removeFromCondition("'+parent.attr('id')+'");><strong>X</strong></a>';
 
 var aggr = '<select name="agrSelect" id="agrSel_'+parent.attr('id')+'"><option value=""> </option><option value="Avg">Avg</option><option value="Count">Count</option><option value="Max">Max</option><option value="Min">Min</option><option value="Sum">Sum</option></select>';

 var alias = '<input type="textbox" name="aliasTxt" id="aliasTxt_'+parent.attr('id')+'" style="width:50px;" value="" />';

 var sortType = '<select name="sortType" id="sortTypeSel_'+parent.attr('id')+'" onchange=generateSortOrder("'+parent.attr('id')+'");><option value=""></option><option value="ASC">ASC</option><option value="DESC">DESC</option></select>';

 var sortOrder = '<input type="textbox" name="sortOrderTxt" id="sortOrderTxt_'+parent.attr('id')+'" style="width:70px;" value="" />';

 var groupingChk = '<input type="checkbox" name="groupingChk" id="groupingChk_'+parent.attr('id')+'" />';

 var criteriaFor = '<select name="criteriaFor" id="criteriaFor_'+parent.attr('id')+'"><option value="val">Values</option><option value="grp">Groups</option></select>';

 var criteriaTxt = '<input type="textbox" name="criteriaTxt_" id="criteriaTxt_'+parent.attr('id')+'" value="" />';

 var displayType = '<select name="displayType" id="displayType_'+parent.attr('id')+'"><option value="1">Yes</option><option value="0">No</option></select>';

 var tr = '<tr class="dataRow" id="row_'+parent.attr('id')+'"><td class="dragHandle" align="center">&nbsp;&nbsp;'+remove+'</td><td class="dbFieldClass" id="td_'+dbField+'">'+fieldName+'</td><td>'+aggr+'</td><td>'+alias+'</td><td>'+sortType+'</td><td>'+sortOrder+'</td><td>'+groupingChk+'</td><td>'+criteriaFor+'</td><td>'+criteriaTxt+'</td><td>'+displayType+'</td></tr>';

 $('#conditionsTable tr:last').after(tr);

 sortTable();

 fieldsArray.push(parent.attr('id'));
}

function sortTable(){
	 //$('#conditionsTable').tableDnD();
   $('#conditionsTable').tableDnD({
 	    onDragClass: "myDragClass",
        dragHandle: ".dragHandle",
        onDrop:function(table,row){
          if($.trim($('#qDiv').val())!=''){
        	 getQuery(); //update query
          }
        }
  });
  //$("#conditionsTable tr:even").addClass("alt");
  $("#conditionsTable tr").hover(function() {
          $(this.cells[0]).addClass('showDragHandle');
  }, function() {
          $(this.cells[0]).removeClass('showDragHandle');
  });

  //$("#conditionsTable tr:even').addClass('alt')");
}

function removeFromCondition(id){
  var cnt = fieldsArray.length;
  if(cnt){
	  for(var i=0;i<cnt;i++){
		  if(fieldsArray[i] == id){
			  fieldsArray.splice(i,1);
			  $('#row_'+id).remove();
			  $('#'+id+' input[type="checkbox"]').attr('checked',false);
			  break;
		  }
	  }
  }
}

function removeTablesFieldFromCondition(id){
  var lis = $('#'+id).find('ul>li');
  var liCount = lis.length;
  for(var i=0;i<liCount;i++){
    removeFromCondition($(lis[i]).attr('id'));
  }
}

function generateSortOrder(id){
	var rowObj = $('#row_'+id);
	var rowNum   = rowObj.parent().children().index(rowObj);
	if($('#sortTypeSel_'+id).val() == ''){
		$('#sortOrderTxt_'+id).val('');
	}
	else if($.trim($('#sortOrderTxt_'+id).val()) == ''){
       $('#sortOrderTxt_'+id).val(rowNum);
	}
}

function getQuery(){
	if(!validateFieldSelection()){
		return false;
	}
	var cnt1  = fieldsArray.length;
	
	var selectString = '';
	var whereString = '';
	var groupByString = '';
	var havingString = '';
	var sortString = '';

	var tablesArray = new Array();
	var sortArray = new Array();

	var cnt = joinArray.length;
    for(var i=0;i<cnt;i++){
	   var arr = joinArray[i].split(',');
	   
	   var a = arr[0].replace('a_','');
	   var a1= a.split('-');
	   var a2 = a1[0]+'.'+a1[1];
	   
	   var b = arr[1].replace('a_','');
	   var b1= b.split('-');
	   var b2 = b1[0]+'.'+b1[1];


	   if($.inArray(a2,tablesArray) == '-1'){
		   tablesArray.push(a2);
	   }
	   if($.inArray(b2,tablesArray) == '-1'){
		   tablesArray.push(b2);
	   }
    }

	for (var i=0;i<cnt1;i++){
        var id = fieldsArray[i];
		var fArr = fieldsArray[i].split('-');
		var c1 = tablesArray.length;
		var flag = false;
		for(var j=0;j<c1;j++){
			if(tablesArray[j] == fArr[0]+'.'+fArr[1]){
				flag = true;
			}
		}
		if(!flag){
            tablesArray.push(fArr[0]+'.'+fArr[1]);
		}

		if(selectString!=''){
			selectString += ' , ';
		}
		var fieldName = fieldsArray[i].replace(/-/g,'.');
        if($('#agrSel_'+id).val()!=''){
		  //fieldName = $('#agrSel_'+id).val()+'('+fieldName+')';
		}
		selectString += fieldName;

		if($('#aliasTxt_'+id).val()!=''){
			//selectString += ' AS \''+$('#aliasTxt_'+id).val()+'\'';
			selectString += ' AS "'+$('#aliasTxt_'+id).val()+'"';
		}
		if($('#groupingChk_'+id).attr('checked')){
			
			if($('#criteriaFor_'+id).val() == 'val' && $('#criteriaTxt_'+id).val()!=''){
               if($('#criteriaTxt_'+id).val().indexOf('=') == -1){
				 $('#criteriaTxt_'+id).val('='+$('#criteriaTxt_'+id).val());
			   } 
               if(whereString!=''){
				 whereString += ' AND ';
	           }
			   whereString += '('+fieldName+ ' '+$('#criteriaTxt_'+id).val()+')';
			}
			else if($('#criteriaFor_'+id).val() == 'grp' && $('#criteriaTxt_'+id).val()!='' ){
				if($('#criteriaTxt_'+id).val().indexOf('=') == -1){
				 $('#criteriaTxt_'+id).val('='+$('#criteriaTxt_'+id).val());
			    }
				if(havingString!=''){
					havingString += ' AND ';
				}
				havingString += '('+fieldName+ ' '+$('#criteriaTxt_'+id).val()+')';
			}

			if(groupByString!=''){
				groupByString += ',';
			}
			groupByString += fieldName; //as group by & aggerage functions clash
		}
		else if($('#criteriaTxt_'+id).val()!=''){
			if($('#criteriaTxt_'+id).val().indexOf('=') == -1){
				//$('#criteriaTxt_'+id).val('='+$('#criteriaTxt_'+id).val());
			}
            if(whereString!=''){
			 whereString += ' AND ';
	        }
			whereString += '('+fieldName+ ' '+$('#criteriaTxt_'+id).val()+')';
		}


		if($('#sortTypeSel_'+id).val()!=''){
		  var obj = new Object();
		  obj.cond = fieldName+ ' '+$('#sortTypeSel_'+id).val();
		  var sortOrder = 1;
		  if($.trim($('#sortOrderTxt_'+id).val())!=''){
			  sortOrder = $.trim($('#sortOrderTxt_'+id).val());
		  }
		  obj.sortOrder = sortOrder;
          sortArray.push(obj);
		}
	}
    
    //as we are now calculating this from position in the conditions table
	selectString = ''; 

	$('#conditionsTable .dbFieldClass').each(function(){
		var a = $(this).attr('id').replace('td_','');
		var fieldName = a.replace(/-/g,'.');
		
		if($('#displayType_'+a).val() =='1'){ // if,display is set to Yes
			if(selectString!=''){
				selectString +=',';
			}
			
	        if($('#agrSel_'+a).val()!=''){
			  fieldName = $('#agrSel_'+a).val()+'('+fieldName+')';
			}
			selectString += fieldName;

			if($('#aliasTxt_'+a).val()!=''){
	          //selectString += ' AS \''+$('#aliasTxt_'+a).val()+'\'';
	          selectString += ' AS `'+$('#aliasTxt_'+a).val()+'`';
			}
	   }
	})
    
	if(selectString!=''){
		selectString = 'SELECT '+selectString;
	}else{
		alert('No column is being fetched in the query');
		return false;
	}
	if(groupByString!=''){
		groupByString = 'GROUP BY '+groupByString;
	}
	if(havingString!=''){
		havingString = 'HAVING '+havingString;
	}
	var whereFlag = false;
	if(whereString!=''){
       whereFlag = true;
	   whereString = 'WHERE '+whereString;
	}

	var cnt2 = tablesArray.length;
	var fromQuery = '';
	for(var i=0;i<cnt2;i++){
		if(fromQuery!=''){
			fromQuery += ' , ';
		}
		fromQuery += tablesArray[i];
	}

	if(fromQuery!=''){
		fromQuery = ' FROM '+fromQuery;
	}

	var cnt3  = joinArray.length;
	for(var i=0; i<cnt3;i++){
       if(whereString!=''){
			whereString += ' AND ';
	   }
       //var jFieldsArr = joinArray[i].replace(/a_/g,'').split(',');
       var jFieldsArr = joinArray[i].split(',');
       jFieldsArr[0] = jFieldsArr[0].replace('a_','');
       jFieldsArr[1] = jFieldsArr[1].replace('a_','');
       whereString += '('+jFieldsArr[0].replace(/-/g,'.')+'='+jFieldsArr[1].replace(/-/g,'.')+')';
	}

	if(whereString!='' && !whereFlag){
	   whereString = 'WHERE '+whereString;
	}

	var cnt4 = sortArray.length;
	if(cnt4){
		sortArray.sort(function(a,b) { return parseFloat(a.sortOrder) - parseFloat(b.sortOrder) } );
		for(var i =0;i<cnt4;i++){
			if(sortString!=''){
				sortString += ',';
			}
		  sortString += sortArray[i].cond;
	    }
	}

	if(sortString!=''){
		sortString = 'ORDER BY '+sortString;
	}

	$('#qDiv').val(selectString+' '+fromQuery+' '+whereString+' '+groupByString+' '+havingString+' '+sortString);
	return true;
}

function showQueryPane(show){
 if(show){
   $('#queryPane').show();
   if(!joiningLinesDrawn){
   	redrawJoiningLines();
   }
 }else{
 	$('#queryPane').hide();
 }
}

function validateFieldSelection(){
	var cnt1  = fieldsArray.length;
	if(!cnt1){
		alert('No fields selected');
		return false;
	}
	return true;
}
function genReport(){
  /*
  if(!validateFieldSelection()){
		return false;
  }
  */
  if($.trim($('#qDiv').val())==''){
  	alert('No query constructed');
  	return false;
  }
  $.cookie('query',$.trim($('#qDiv').val()));
  $.ajax({
			type: "POST",
			url: jsURL+'?pg=reports/builder/builder-data&ajax=1',
			data: 'query=' + $.trim($('#qDiv').val()),
			success: function (response) {
				$('#reportGridDiv').html(response);
				if(hasJSPagination == '1'){
					applyJSPagination();
				}else{
					$(".datatable").fixedtableheader();
				}
			}
  });
}
var oTable = '';
function applyJSPagination(){
	if(typeof oTable == 'object'){
		$('.fixedHeader').remove();
		try{
		oTable.fnDestroy();
		}catch(e){
			//alert(e)
		}
	}
	$.fn.dataTableExt.oApi.fnPagingInfo = function(oSettings){
		return {
			"iTotalPages": oSettings._iDisplayLength === -1 ?
				0 : Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
		};
   };
   jQuery.fn.dataTableExt.oPagination.iFullNumbersShowPages = js_links_per_page;
   oTable = $('.datatableRecords').dataTable( {
         "bLengthChange": false,
		 "bFilter": false,
		 "bInfo": false,
		 "bSort": false,
		 "iDisplayLength": js_records_per_page,
		 "sPaginationType": "full_numbers",
		 "oLanguage": {
		      "oPaginate": {
		        "sFirst": '<img border="0" align="absmiddle" title="First" src="'+jsImgURL+'/arrow2.gif">',
		        "sPrevious": '<img border="0" align="absmiddle" title="Previous" src="'+jsImgURL+'/arrow1.gif">',
		        "sNext": '<img border="0" align="absmiddle" title="Next" src="'+jsImgURL+'/arrow3.gif">',
		        "sLast": '<img border="0" align="absmiddle" title="Last" src="'+jsImgURL+'/arrow4.gif">',
		      }
      	 },
		 "fnDrawCallback": function(){
            var total = this.fnPagingInfo().iTotalPages;
            $('#totalPageDiv').remove();
            var str = '<div id="totalPageDiv"><span class=""><b>Pages:</b>&nbsp;'+total+'</div>';
            $('.paging_full_numbers').before(str);
            $('.paging_full_numbers').show();
            $('#totalPageDiv').css('margin-left','80%');
            $('#totalPageDiv').css('margin-top','0.');
            if(total <= 1){
              $('#totalPageDiv').css('margin-left','94%');
              $('.paging_full_numbers').hide();
            }
          }
	});
    if(oTable.length) {
     new FixedHeader( oTable );
    }
}

function genProjectData(){
  /*
  if(!validateFieldSelection()){
		return false;
  }
  */
  if($.trim($('#qDiv').val())==''){
  	alert('No query constructed');
  	return false;
  }
  $.cookie('query',$.trim($('#qDiv').val()));
  $.ajax({
			type: "POST",
			url: jsURL+'?pg=project/person-data&ajax=1',
			data: 'query=' + $.trim($('#qDiv').val())+'&pId='+$('#projectId').val()+'&objs='+$('input[name^="objs"]:checked').val(),
			success: function (response) {
				$('#reportGridDiv').html(response);
			}
  });
}

function getGraph(mode){
	var x = $('input[name=xSelect]:radio:checked').val();
	if(!x){
		alert("Please choose a column as X axis");
		return false;
	}
	x = 'a.'+x;
	var y = '';
	$('.ySelect').each(function(){
	   if($(this).is(':checked')){
	       if(y!=''){
	       	 y += ',';
	       }
	       //removed sum
	       //y += 'SUM(a.'+$(this).val()+') AS '+$(this).val();
	       y += 'a.'+$(this).val();
       }
	});
	if(y == ''){
		alert("Please choose a column as Y axis");
		return false;
	}
	$.cookie('x-axis',x);
	$.cookie('y-axis',y);
	$.cookie('report-mode',mode);
	

	$(".iframeClass").colorbox(
		{
			iframe:true, 
			innerWidth:725, 
			innerHeight:344,
			onOpen:function(){
				$('#conditionsDiv').css('position','fixed');
				$('#leftdiv').css('z-index','0');
			},
			onCleanup:function(){ 
				$('#conditionsDiv').css('position','relative');
				$('#leftdiv').css('position','relative');
			},
			onClosed:function(){
				//$('#conditionsDiv').css('position','relative');
			},
		}
	);

	$(".iframeClass").trigger('click');
}

function getExcel(mode){
	window.open(jsURL+'?pg=reports/builder/builder-excel-data&ajax=1&mode='+mode);
}

function getPrint(){
   $(".iframeClassPrint").colorbox(
		{
			iframe:true, 
			innerWidth:725, 
			innerHeight:344,
			onOpen:function(){
				$('#conditionsDiv').css('position','fixed');
				$('#leftdiv').css('z-index','0');
			},
			onCleanup:function(){ 
				$('#conditionsDiv').css('position','relative');
				$('#leftdiv').css('position','relative');
			},
			onClosed:function(){
				//$('#conditionsDiv').css('position','relative');
			},
		}
	);

	$(".iframeClassPrint").trigger('click');	
}

function saveReport(){
	var $reportName = $('#reportName');
	if($.trim($reportName.val()) == ''){
		alert('Please enter name of the report');
		$reportName.focus();
		return false;
	}

	var myLinesString = '';
	var cnt = myLines.length;
	for(var i=0;i<cnt;i++){
		if(myLinesString!=''){
			myLinesString += '~';
		}
		myLinesString += myLines[i];
	}

	var joinArrayString = '';
	var cnt = joinArray.length;
	for(var i=0;i<cnt;i++){
		if(joinArrayString!=''){
			joinArrayString += '~';
		}
		joinArrayString += joinArray[i];
	}

	var divArrayString = '';
	var cnt = divArray.length;
	for(var i=0;i<cnt;i++){
		if(divArrayString!=''){
			divArrayString += '~';
		}
		divArrayString += divArray[i];
	}

	var fieldsArrayString = '';
	var cnt = fieldsArray.length;
	for(var i=0;i<cnt;i++){
		if(fieldsArrayString!=''){
			fieldsArrayString += '~';
		}
		fieldsArrayString += fieldsArray[i];
	}
    
    //var cTable = $('#conditionsTable').html().replace(/&/g,'*');
    var cTable = ''; 
    $('#conditionsTable .dbFieldClass').each(function(){
		if(cTable!=''){
			cTable +='!~~!';
		}
		
		var a = $(this).attr('id').replace('td_','');

		cTable += a+'!@~!';
	    cTable += $('#agrSel_'+a).val()+'!@~!';
		cTable += $('#aliasTxt_'+a).val()+'!@~!';
		cTable += $('#sortTypeSel_'+a).val()+'!@~!';
		cTable += $('#sortOrderTxt_'+a).val()+'!@~!';
		if($('#groupingChk_'+a).attr('checked')){
		  cTable += '1!@~!';
		}else{
		  cTable += '0!@~!';
		}
	    cTable += $('#criteriaFor_'+a).val()+'!@~!';
		cTable += $('#criteriaTxt_'+a).val()+'!@~!';
		cTable += $('#displayType_'+a).val()+'!@~!';

	})


    var data = 'rid='+$('#reportId').val()+'&rName='+$.trim($reportName.val())+'&myLines='+myLinesString+'&joinArray='+joinArrayString+'&divArray='+divArrayString+'&fieldsArray='+fieldsArrayString+'&conditionsTable='+cTable+'&reportQuery='+$('#qDiv').val().replace(/&/g,'*');
    data += '&recordMode='+$('#record_mode').val();
	$.ajax({
		type: "POST",
		url: jsURL+'?pg=reports/builder/save-report&ajax=1',
		data: data,
		success: function (response) {
			if(response == 'Duplicate Report Found'){
			  alertBox('Duplicate Report Found');
			  return false;
			}else if(response == "Error"){
              alertBox(response);
              return false;
			}
			else{
			 alertBox('Report Saved');
			 if($('#reportId').val() == '0'){
				window.location = location.href+'&ModuleId='+response;
			 }
		   }
		}
    });

}


function deleteReport(){
	if(!confirm("Do you want to delete this report ?")){
		return false;
	}
	var data = 'rid='+$('#reportId').val();
	$.ajax({
		type: "POST",
		url: jsURL+'?pg=reports/builder/delete-report&ajax=1',
		data: data,
		success: function (response) {
			if(response == 'OK'){
				alert('Report Deleted');
				window.location = jsURL+'?pg=reports/builder/builder';
			}else{
              alert(response);
		   }
		}
    });
}

function toggleUserSelection(state){
 $('#reportGridDiv input[name^="persons"]').attr('checked',state);
}
function saveTargetUsers(){
    
    var persons = $('#reportGridDiv input[name^="persons"]');
    var cnt     = persons.length;
    
    var checkedFlag = false;
    var personsString = '';
    for(var i=0;i<cnt;i++){
    	if($(persons[i]).attr('checked')){
          checkedFlag = true;
          if(personsString!=''){
          	personsString += ',';
          }
          //personsString += $(persons[i]).val()+'~@:@~'+$(persons[i]).attr('alt');
          personsString += $(persons[i]).val();
    	}
    }
    if(!checkedFlag){
    	//do not restrict user
    	//alert('Please select at least one checkbox');
    	//return false;
    }
	var myLinesString = '';
	var cnt = myLines.length;
	for(var i=0;i<cnt;i++){
		if(myLinesString!=''){
			myLinesString += '~';
		}
		myLinesString += myLines[i];
	}

	var joinArrayString = '';
	var cnt = joinArray.length;
	for(var i=0;i<cnt;i++){
		if(joinArrayString!=''){
			joinArrayString += '~';
		}
		joinArrayString += joinArray[i];
	}

	var divArrayString = '';
	var cnt = divArray.length;
	for(var i=0;i<cnt;i++){
		if(divArrayString!=''){
			divArrayString += '~';
		}
		divArrayString += divArray[i];
	}

	var fieldsArrayString = '';
	var cnt = fieldsArray.length;
	for(var i=0;i<cnt;i++){
		if(fieldsArrayString!=''){
			fieldsArrayString += '~';
		}
		fieldsArrayString += fieldsArray[i];
	}
    
    //var cTable = $('#conditionsTable').html().replace(/&/g,'*');
    var cTable = ''; 
    $('#conditionsTable .dbFieldClass').each(function(){
		if(cTable!=''){
			cTable +='!~~!';
		}
		
		var a = $(this).attr('id').replace('td_','');

		cTable += a+'!@~!';
	    cTable += $('#agrSel_'+a).val()+'!@~!';
		cTable += $('#aliasTxt_'+a).val()+'!@~!';
		cTable += $('#sortTypeSel_'+a).val()+'!@~!';
		cTable += $('#sortOrderTxt_'+a).val()+'!@~!';
		if($('#groupingChk_'+a).attr('checked')){
		  cTable += '1!@~!';
		}else{
		  cTable += '0!@~!';
		}
	    cTable += $('#criteriaFor_'+a).val()+'!@~!';
		cTable += $('#criteriaTxt_'+a).val()+'!@~!';
		cTable += $('#displayType_'+a).val()+'!@~!';

	})


    var data = 'pId='+$('#projectId').val()+'&myLines='+myLinesString+'&joinArray='+joinArrayString+'&divArray='+divArrayString+'&fieldsArray='+fieldsArrayString+'&conditionsTable='+cTable+'&reportQuery='+$('#qDiv').val().replace(/&/g,'*')+'&objs='+$('input[name^="objs"]:checked').val();
	$.ajax({
		type: "POST",
		url: jsURL+'?pg=project/save-person-mapping&ajax=1',
		data: data+'&persons='+personsString,
		success: function (response) {
			if(response == 'OK'){

				 alertBox("Data Saved", "window.location.href = 'index.php?pg=project/project-list'");

			}
			else{
				alertBox(response);
			}
		}
    });
}

function displayPopUpInfo(val,mode){
	var h = 550;
	if(mode == '1'){
		var h = 450;
	}

	$.ajax({
		type: "POST",
		url: jsURL+'?pg=project/get-popup-data&ajax=1',
		data: 'val='+val+'&mode='+mode,
		success: function (response) {
		 $("#infoDiv").html(response);
		 $("#infoDiv").dialog({
          resizable: false,
          height:h,
          width:950,
          modal: true
         });
         $('#infoDiv').parent().css({
          position:"fixed",
          top:'15px'
          });
		}
    });
    

}

$(document).ready(function() {
  $('.personDetails').live('click',function(){
    displayPopUpInfo($(this).attr('value'),1);
  });
  $('.houseDetails').live('click',function(){
    displayPopUpInfo($(this).attr('value'),2);
  });
});