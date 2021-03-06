<?php

//verify sub-module access
$uploadPath     = 'view-logs/log-upload';
$downloadPath   = 'view-logs/log-download';

$uploadAllowed  = $login->verify_module_access($uploadPath);
$downloadAllowed  = $login->verify_module_access($downloadPath);

$logType = USER_LOGIN; //default log type
if(isset($_REQUEST['log_type'])){
    $logType = trim($_REQUEST['log_type']);
}
if($logType == USER_LOGIN){
    $fieldsArray = array(
    	'srNo' => array('label' => t('Sr. No'),'style'=>'width:4%;'),
    	'user_name'=>array('label'=>t('Username'),'style'=>'width:15%;',
    	'sorting'=>TRUE),
    	'user_agent'=>array('label'=>t('User Agent'),'style'=>'width:40%;',
    	'sorting'=>TRUE),
    	'IP'=>array('label'=>t('IP'),'style'=>'width:10%;','sorting'=>TRUE),
    	'created_at' => array('label'=>t('Last Login'),'style'=>'width:12%;',
    	'sorting'=>TRUE)
    );
    $defaultSortField = 'user_name';
    $defaultSortOrder = 'ASC';
}elseif ($logType == DATA_EXPORT){
    $fieldsArray = array(
    	'srNo' => array('label' => t('Sr. No'),'style'=>'width:8%;'),
    	'user_name'=>array('label'=>t('Username'),'style'=>'width:15%;',
    	'sorting'=>TRUE),
        'user_agent'=>array('label'=>t('User Agent'),'style'=>'width:10%;',
    	'sorting'=>TRUE),
    	'IP'=>array('label'=>t('IP'),'style'=>'width:10%;','sorting'=>TRUE),
    	'operation_performed' => array('label'=>t('Operation'),
    	'style'=>'width:10%;','sorting'=>TRUE),
        'module_name' => array('label'=>t('Module'),
    	'style'=>'width:10%;','sorting'=>TRUE),
        'id_range' => array('label'=>t('ID Range'),
    	'style'=>'width:15%;','sorting'=>TRUE),
        'created_at' => array('label'=>t('Date'),'style'=>'width:15%;',
    	'sorting'=>TRUE)
    );
    $defaultSortField = 'module_name';
    $defaultSortOrder = 'ASC';
}elseif ($logType == DATA_IMPORT){
    $fieldsArray = array(
    	'srNo' => array('label' => t('Sr. No'),'style'=>'width:8%;'),
    	'user_name'=>array('label'=>t('Username'),'style'=>'width:15%;',
    	'sorting'=>TRUE),
        'user_agent'=>array('label'=>t('User Agent'),'style'=>'width:10%;',
    	'sorting'=>TRUE),
    	'IP'=>array('label'=>t('IP'),'style'=>'width:10%;','sorting'=>TRUE),
    	'operation_performed' => array('label'=>t('Operation'),
    	'style'=>'width:15%;','sorting'=>TRUE),
        'module_name' => array('label'=>t('Module'),
    	'style'=>'width:15%;','sorting'=>TRUE),
        'total_imported' => array('label'=>t('Imported Rows'),
    	'style'=>'width:11%;','sorting'=>TRUE),
        'created_at' => array('label'=>t('Date'),'style'=>'width:15%;',
    	'sorting'=>TRUE)
    );
    $defaultSortField = 'module_name';
    $defaultSortOrder = 'ASC';
} 

if(isset($_REQUEST['data-list']) && $_REQUEST['data-list'] == '1'){
	/*search*/
	$search      = urldecode($_REQUEST['search']);
	$search      = trim($db_obj->mysql_data_encode($search));
	
	/*Paging*/
	$limit = $utility_obj->get_data_table_limit(RECORDS_PER_PAGE);
	/*Ordering*/
	$sOrder = $utility_obj->get_data_table_order_by($fieldsArray,$defaultSortField,
	$defaultSortOrder);
	
	//load model class
	include_once('./model/common/common.php');
	$modObj = new common($db_obj);

	$totalRecords = $modObj->get_total_system_logs($logType);
	$resultSet    = $modObj->get_system_log_list($sOrder,$limit,$logType);
	
	if(is_array($resultSet) && count($resultSet)){
    	foreach ($resultSet as $key => $value) {
    	  $resultSet[$key]['id_range'] = show_ellipse($value['id_range'],30);  
    	  $resultSet[$key]['user_agent'] = $value['user_agent'];  
     	  $resultSet[$key]['created_at'] 
    	  = $utility_obj->format_date_value($value['created_at'],true);
    	  $resultSet[$key]['operation_performed'] 
    	  = $GLOBALS['glbLogTypes'][$value['operation_performed']];
    	}
	}

	//prepare the record set
	$output = $utility_obj->prepare_data_table_rows($resultSet,$totalRecords,$page,
	RECORDS_PER_PAGE,$fieldsArray);
    die(json_encode(encode_json_array($output)));
}

$recordURL = URL."view-logs/view-logs";
$recordURLAjax = $recordURL."&ajax=1&data-list=1&log_type=".$logType;
$tableId = 'logDivTable';
$dataListInput = array(
                      'TABLE_ID'=>$tableId,
                      'RECORDS_PER_PAGE'=>RECORDS_PER_PAGE,
                      'LINKS_PER_PAGE'=>LINKS_PER_PAGE,
                      'RECORD_URL'=>$recordURLAjax,
                      'FIELDS'=>$fieldsArray,
					  'DEFAULT_SORT_FIELD'=>$defaultSortField,
					  'DEFAULT_SORT_ORDER'=>$defaultSortOrder,
                      'LIST_HEADING'=>$utility_obj->get_page_name($pageURL,2)
                    );


$tableHTML = $utility_obj->display_data_table_listing($dataListInput);
require_once('./view/view-logs/view-logs.php');
?>