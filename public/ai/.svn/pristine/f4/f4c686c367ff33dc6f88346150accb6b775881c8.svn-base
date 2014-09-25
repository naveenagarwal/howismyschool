<?php
//only super admin can edit himself
$editNotAllwoed = array(-1);
if($_SESSION['USER_ID'] != SUPER_ADMIN_ID){
    $editNotAllwoed = array(SUPER_ADMIN_ID,$_SESSION['USER_ID']);
}

//verify sub-module access
$editPath       = 'user-roles/users/user-edit';
$deletePath     = 'user-roles/users/user-delete';
$addPath        = 'user-roles/users/user-add';

$addAllowed     = $login->verify_module_access($addPath);
$editAllowed    = $login->verify_module_access($editPath);
$deleteAllowed  = $login->verify_module_access($deletePath);

$fieldsArray = array(
	'sr_no' => array('label' => t('Sr. No'),'style'=>'width:8%;'),
	'user_name'=>array('label'=>t('Username'),'style'=>'width:17%;',
	'sorting'=>TRUE),
	'full_name'=>array('label'=>t('Full Name'),'style'=>'width:20%;',
	'sorting'=>TRUE),
	'email_id'=>array('label'=>t('Email'),'style'=>'width:15%;',
	'sorting'=>TRUE),
	'role_code' => array('label'=>t('Role'),'style'=>'width:15%;',
	'sorting'=>TRUE),
	'last_login_date' => array('label'=>t('Last logged–in'),
	'style'=>'width:18%;','sorting'=>TRUE,'toggle'=>true,'visible'=>true),
	'IsActive' => array('label'=>t('Status'),'style'=>'width:15%;',
	'sorting'=>TRUE)
);

if($editAllowed){
    $fieldsArray[EDIT_OP] = array('label'=>t('Edit'),'style'=>'width:15%;',
	'sorting'=>FALSE,'PK_FIELD'=>'id','EDIT_TYPE'=>URL_BASED,
	'EDIT_ACTION'=>$editPath,'NO_EDIT_COLUMN' => 'id',
	'NO_EDIT_COLUMN_VALUE'=>$editNotAllwoed);
}
if($deleteAllowed){
    $fieldsArray[DELETE_OP] = array('label'=>t('Delete'),'style'=>'width:13.5%;',
	'sorting'=>FALSE,'PK_FIELD'=>'id','DELETE_TYPE'=>JS_BASED,
	'DELETE_ACTION'=>'deleteConfirm','NO_DELETE_COLUMN' => 'id',
	'NO_DELETE_COLUMN_VALUE'=>array(SUPER_ADMIN_ID,$_SESSION['USER_ID']));
}
	 
 $defaultSortField = 'user_name';
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
	include_once('./model/user-roles/users.php');
	$user_obj = new users($db_obj);

	$totalRecords = $user_obj->get_total_users($search);
	$resultSet    = $user_obj->get_user_list($sOrder,$limit,$search);

	foreach ($resultSet as $key => $value) {
	   if(empty($resultSet[$key]['last_login_date'])){
	   	$resultSet[$key]['last_login_date'] = '---';
	   }else{
		$resultSet[$key]['last_login_date'] 
		= $utility_obj->format_date_value($value['last_login_date'],true);
	   }
	}

	//prepare the record set
	$output = $utility_obj->prepare_data_table_rows($resultSet,$totalRecords,$page,
	RECORDS_PER_PAGE,$fieldsArray);
    die(json_encode(encode_json_array($output)));
}

$recordURL = URL."user-roles/users/user-list&ajax=1&data-list=1";
$deleteURL = URL."user-roles/users/user-delete&ajax=1";
$tableId = 'userDivTable';
$dataListInput = array(
                      'TABLE_ID'=>$tableId,
                      'RECORDS_PER_PAGE'=>RECORDS_PER_PAGE,
                      'LINKS_PER_PAGE'=>LINKS_PER_PAGE,
                      'RECORD_URL'=>$recordURL,
                      'FIELDS'=>$fieldsArray,
					  'DEFAULT_SORT_FIELD'=>$defaultSortField,
					  'DEFAULT_SORT_ORDER'=>$defaultSortOrder,
                      'LIST_HEADING'=>$utility_obj->get_page_name($pageURL,2),
                      'COLUMN_TOGGLE'=> FALSE,
 					  'FANCY_FUNC'=>'addFancyBoxEdit("editCell",1,"100%","100%")'  
                    );


$tableHTML = $utility_obj->display_data_table_listing($dataListInput);
require_once('./view/user-roles/users/user-list.php');
?>