<?php

//verify sub-module access
$editPath       = 'user-roles/roles/role-edit';
$deletePath     = 'user-roles/roles/role-delete';
$addPath        = 'user-roles/roles/role-add';

$addAllowed     = $login->verify_module_access($addPath);
$editAllowed    = $login->verify_module_access($editPath);
$deleteAllowed  = $login->verify_module_access($deletePath);

 $fieldsArray = array(
	'sr_no' => array('label' => t('Sr. No'),'style'=>'width:10%;'),
	'role_name'=>array('label'=>t('Name'),'style'=>'width:30%;',
	'sorting'=>TRUE),
	'role_code'=>array('label'=>t('Code'),'style'=>'width:25%;',
	'sorting'=>TRUE),
 	'IsActive' => array('label'=>t('Active'),'style'=>'width:15%;',
	'sorting'=>TRUE),
 	'total_users' => array('label'=>t('User Count'),'style'=>'width:20%;',
	'sorting'=>TRUE)
	);
 
 if($editAllowed){
     $fieldsArray[EDIT_OP] = array('label'=>t('Edit'),'style'=>'width:13.5%;',
	'sorting'=>FALSE,'PK_FIELD'=>'id','EDIT_TYPE'=>URL_BASED,
	'EDIT_ACTION'=>$editPath,
 	'NO_EDIT_COLUMN' => 'id','NO_EDIT_COLUMN_VALUE'=>array(SUPER_ADMIN_ID,DELETED_ROLE));
 }
 if($deleteAllowed){
     $fieldsArray[DELETE_OP]= array('label'=>t('Delete'),
     'style'=>'width:13.5%;','sorting'=>FALSE,'PK_FIELD'=>'id',
     'DELETE_TYPE'=>JS_BASED,'DELETE_ACTION'=>'deleteConfirm',
 	'NO_DELETE_COLUMN' => 'id','NO_DELETE_COLUMN_VALUE'=>
     array(SUPER_ADMIN_ID,DELETED_ROLE));
 }

 $defaultSortField = 'role_name';
 $defaultSortOrder = 'ASC';

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
	include_once('./model/user-roles/roles.php');
	$roleObj = new roles($db_obj);

	$totalRecords = $roleObj->get_total_roles($search);
	$resultSet    = $roleObj->get_role_list($sOrder,$limit,$search);

	//prepare the record set
	$output = $utility_obj->prepare_data_table_rows($resultSet,$totalRecords,$page,
	RECORDS_PER_PAGE,$fieldsArray);
    die(json_encode(encode_json_array($output)));
}

$recordURL = URL."user-roles/roles/role-list&ajax=1&data-list=1";
$deleteURL = URL."user-roles/roles/role-delete&ajax=1";
$tableId = 'roleDivTable';
$dataListInput = array(
                      'TABLE_ID'=>$tableId,
                      'RECORDS_PER_PAGE'=>RECORDS_PER_PAGE,
                      'LINKS_PER_PAGE'=>LINKS_PER_PAGE,
                      'RECORD_URL'=>$recordURL,
                      'FIELDS'=>$fieldsArray,
					  'DEFAULT_SORT_FIELD'=>$defaultSortField,
					  'DEFAULT_SORT_ORDER'=>$defaultSortOrder,
                      'LIST_HEADING'=>$utility_obj->get_page_name($pageURL,2),
					  'FANCY_FUNC'=>'addFancyBoxEdit("editCell",1,"100%","100%")'
                    );


$tableHTML = $utility_obj->display_data_table_listing($dataListInput);
require_once('./view/user-roles/roles/role-list.php');
?>