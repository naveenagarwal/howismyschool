var oCache = {
    iCacheLower: -1
};
 
function fnSetKey( aoData, sKey, mValue )
{
    for ( var i=0, iLen=aoData.length ; i<iLen ; i++ )
    {
        if ( aoData[i].name == sKey )
        {
            aoData[i].value = mValue;
        }
    }
}
 
function fnGetKey( aoData, sKey )
{
    for ( var i=0, iLen=aoData.length ; i<iLen ; i++ )
    {
        if ( aoData[i].name == sKey )
        {
            return aoData[i].value;
        }
    }
    return null;
}
 
function fnDataTablesPipeline ( sSource, aoData, fnCallback ) {
    var iPipe = 5; /* Ajust the pipe size */
     
    var bNeedServer = false;
    var sEcho = fnGetKey(aoData, "sEcho");
    var iRequestStart = fnGetKey(aoData, "iDisplayStart");
    var iRequestLength = fnGetKey(aoData, "iDisplayLength");
    var iRequestEnd = iRequestStart + iRequestLength;
    oCache.iDisplayStart = iRequestStart;
     
    /* outside pipeline? */
    if ( oCache.iCacheLower < 0 || iRequestStart < oCache.iCacheLower || iRequestEnd > oCache.iCacheUpper )
    {
        bNeedServer = true;
    }
     
    /* sorting etc changed? */
    if ( oCache.lastRequest && !bNeedServer )
    {
        for( var i=0, iLen=aoData.length ; i<iLen ; i++ )
        {
            if ( aoData[i].name != "iDisplayStart" && aoData[i].name != "iDisplayLength" && aoData[i].name != "sEcho" )
            {
                if ( aoData[i].value != oCache.lastRequest[i].value )
                {
                    bNeedServer = true;
                    break;
                }
            }
        }
    }
     
    /* Store the request for checking next time around */
    oCache.lastRequest = aoData.slice();
     
    if ( bNeedServer )
    {
        if ( iRequestStart < oCache.iCacheLower )
        {
            iRequestStart = iRequestStart - (iRequestLength*(iPipe-1));
            if ( iRequestStart < 0 )
            {
                iRequestStart = 0;
            }
        }
         
        oCache.iCacheLower = iRequestStart;
        oCache.iCacheUpper = iRequestStart + (iRequestLength * iPipe);
        oCache.iDisplayLength = fnGetKey( aoData, "iDisplayLength" );
        fnSetKey( aoData, "iDisplayStart", iRequestStart );
        fnSetKey( aoData, "iDisplayLength", iRequestLength*iPipe );
         
        $.getJSON( sSource, aoData, function (json) {
            /* Callback processing */
            oCache.lastJson = jQuery.extend(true, {}, json);
             
            if ( oCache.iCacheLower != oCache.iDisplayStart )
            {
                json.aaData.splice( 0, oCache.iDisplayStart-oCache.iCacheLower );
            }
            json.aaData.splice( oCache.iDisplayLength, json.aaData.length );
             
            fnCallback(json)
        } );
    }
    else
    {
        json = jQuery.extend(true, {}, oCache.lastJson);
        json.sEcho = sEcho; /* Update the echo for each response */
        json.aaData.splice( 0, iRequestStart-oCache.iCacheLower );
        json.aaData.splice( iRequestLength, json.aaData.length );
        fnCallback(json);
        return;
    }
}

$.fn.dataTableExt.oApi.fnReloadAjax2 = function ( oSettings, sNewSource, fnCallback, bStandingRedraw )
{
    if ( typeof sNewSource != 'undefined' && sNewSource != null )
    {
        oSettings.sAjaxSource = sNewSource;
    }
    
    this.oApi._fnProcessingDisplay( oSettings, true );
    var that = this;
    var iStart = oSettings._iDisplayStart;
      
    oSettings.fnServerData( oSettings.sAjaxSource, [], function(json) {
        /* Clear the old information from the table */
        that.oApi._fnClearTable( oSettings );
          
        /* Got the data - add it to the table */
        var aData =  (oSettings.sAjaxDataProp !== "") ?
            that.oApi._fnGetObjectDataFn( oSettings.sAjaxDataProp )( json ) : json;
          
        for ( var i=0 ; i<json.aaData.length ; i++ )
        {
            that.oApi._fnAddData( oSettings, json.aaData[i] );
        }
          
        oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
        that.fnDraw();
          
        if ( typeof bStandingRedraw != 'undefined' && bStandingRedraw === true )
        {
            oSettings._iDisplayStart = iStart;
            that.fnDraw( false );
        }
          
        that.oApi._fnProcessingDisplay( oSettings, false );
          
        /* Callback user function - for event handlers etc */
        if ( typeof fnCallback == 'function' && fnCallback != null )
        {
            fnCallback( oSettings );
        }
    }, oSettings );
}

$.fn.dataTableExt.oApi.fnReloadAjax = function ( oSettings, sNewSource, 
		fnCallback, bStandingRedraw ){
	    /*ISSUE IN CHROME WITH "versionCheck"
	    if ( $.fn.dataTable.versionCheck ) {
	        var api = new $.fn.dataTable.Api( oSettings );
	        if ( sNewSource ) {
	            api.ajax.url( sNewSource ).load( fnCallback, !bStandingRedraw );
	        }
	        else {
	            api.ajax.reload( fnCallback, !bStandingRedraw );
	        }
	        return;
	    }
	    */
	    if ( sNewSource !== undefined && sNewSource !== null ) {
	        oSettings.sAjaxSource = sNewSource;
	    }
	    if ( oSettings.oFeatures.bServerSide ) {
	        this.fnDraw();
	        return;
	    }
	    this.oApi._fnProcessingDisplay( oSettings, true );
	    var that = this;
	    var iStart = oSettings._iDisplayStart;
	    var aData = [];
	    this.oApi._fnServerParams( oSettings, aData );
	    oSettings.fnServerData.call( oSettings.oInstance, oSettings.sAjaxSource, aData, function(json) {
	        that.oApi._fnClearTable( oSettings );
	        var aData =  (oSettings.sAjaxDataProp !== "") ?
	            that.oApi._fnGetObjectDataFn( oSettings.sAjaxDataProp )( json ) : json;
	        for ( var i=0 ; i<aData.length ; i++ ){
	            that.oApi._fnAddData( oSettings, aData[i] );
	        }
	        oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
	        that.fnDraw();
	        if ( bStandingRedraw === true ){
	            oSettings._iDisplayStart = iStart;
	            that.oApi._fnCalculateEnd( oSettings );
	            that.fnDraw( false );
	        }
	        that.oApi._fnProcessingDisplay( oSettings, false );
	        if ( typeof fnCallback == 'function' && fnCallback !== null ){
	            fnCallback( oSettings );
	        }
	    }, oSettings );
	};
	/*THIS FUNCTION IS USED TO ADD SEARCH PARAM TO DATAGRID*/
	var includeSearchParam = false;
	var previousParam = [];
	function addSearchParams(aoData,formId){
		 if(!includeSearchParam){
			 var data = previousParam;
		 }else{
			 var data = $('#'+formId).serializeArray();
		 }
		 var cnt  = data.length;
		 previousParam = [];
		 for(var i=0; i<cnt; i++){
			 aoData.push( { "name": data[i].name, 
				 "value": encodeURIComponent(data[i].value) } );
			 previousParam.push( { "name": data[i].name, 
				 "value": encodeURIComponent(data[i].value) } );
		 }
	}
	var uncheckFlag = true;
	function dataDatableDrawComplete(targeId){
		//give themed look to the checkboxes
		$("#"+targeId+" input[type='checkbox']").each(function(){
	     if($(this).siblings().not('.iCheck-helper')){
	        $(this).iCheck({
	          checkboxClass: 'icheckbox_minimal',
	          inheritID : true
	        });
	     }
	    });
		$('input[name="chkAll"]').parent().on('ifChecked', function(event){
			uncheckFlag = true;	
		   $('input[name="chkSelect"]').parent().iCheck('check');
		   $('input[name="chkAll"]').parent().iCheck('check');
		});

		$('input[name="chkAll"]').parent().on('ifUnchecked', function(event){
			if(uncheckFlag){
		        $('input[name="chkSelect"]').parent().iCheck('uncheck');
		        $('input[name="chkAll"]').parent().iCheck('uncheck');
			}
		});
		//on refresh,make unselect
		//$('input[name="chkAll"]').parent().iCheck('uncheck');
		if($('input[name="chkAll"]').is(':checked')){
			$('input[name="chkSelect"]').parent().iCheck('check');
		}
		
		$('input[name="chkSelect"]').parent().each(function(){
			$(this).on('ifUnchecked', function(event){
				uncheckFlag = false;
				$('input[name="chkAll"]').parent().iCheck('uncheck');
			});
		});
	}
	var scrollEnabled = false;
	var jsScrollPaneAPI = '';
	
	function addJSScrollPaneDelayed(doScroll){
		setTimeout('addJSScrollPane('+doScroll+')',500);
	}
	function addJSScrollPane(doScroll){
		if(typeof doScroll == 'undefined' || !doScroll){
			return false;
		}
		$('#dataTables_scrollBody').css('overflow','hidden');
		if(!$('.dataTables_scrollBody').hasClass('horizontal-only')){
			$('.dataTables_scrollBody').addClass('horizontal-only');
		}
		if(jsScrollPaneAPI!=''){
			jsScrollPaneAPI.destroy();
		}
		scrollEnabled = doScroll;
		var table_header,table_footer,_this = this;	
		table_header = $('.dataTables_scrollHeadInner').css('position', 'relative');
	    table_footer = $('.dataTables_scrollFootInner').css('position', 'relative');
	    var pane = $('.dataTables_scrollBody').bind('jsp-scroll-x', function(event, scrollPositionX, isAtLeft, isAtRight) {
	      table_header.css('right', scrollPositionX);
	      table_footer.css('right', scrollPositionX);
	    }).jScrollPane();
	    jsScrollPaneAPI = pane.data('jsp');
	    //console.log($('.jspContainer').height()+'---'+jsScrollPaneAPI.getContentHeight());
	    jsScrollPaneAPI.reinitialise();
	    //$('.jspContainer').css('height',jsScrollPaneAPI.getContentHeight());
	    $('.jspVerticalBar').hide();
	}
	/**COMMON FUNCTIONS FOR DELETING & REFRESHING RECORDS SET FROM DATATABLE**/
	function deleteRecord(pkVal,tableId,deleteURL,errMsg){
		confirmBox(errMsg,"deleteSuccess('"+pkVal+"','"+tableId+"','"+deleteURL+"')");
	}
	function deleteRecordFromDB(pkVal,deleteURL){
		var retVal = ''
		$.ajax({
	        type: "POST",
	        async : false,
	        url: deleteURL,
	        data: 'delId=' + pkVal,
	        success: function (response) {
	            retVal = response;
	        }
	    });
	    return retVal;
	}
	function deleteSuccess(pkVal,tableId,deleteURL){
		closeConfirmBox();
		var returnVal = deleteRecordFromDB(pkVal,deleteURL);
		try{
		  var response = JSON.parse(returnVal);
		  if(response['status'] == true){
			 alertBox(response['message'],'refreshDataTableAfterDeletion('+tableId+')'); 
		  }else{
			  alertBox(response['message'],'',1); 
		  }
		}catch(e){
		  alertBox('Record could not be deleted','',1);	
		}
	}
	function refreshDataTableAfterDeletion(tableId){
		var target_row = $('#'+deletableRowElement).closest("tr").get(0);
	    try{
	     var aPos = eval(tableId).fnGetPosition(target_row);
	     eval(tableId).fnDeleteRow(aPos);
	    }catch(e){
	        alert('E:'+e);
	    }		
	}
	
