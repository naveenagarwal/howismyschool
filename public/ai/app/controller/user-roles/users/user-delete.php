<?php
//load model class
require_once('./model/user-roles/users.php');
$userObj = new users($db_obj);

$errFlag = false;
$status = false;
$errMsg  = t('Record deleted succesfully');

$pkVal = trim($db_obj->mysql_data_encode($_REQUEST['delId']));
if(empty($pkVal)){
	$errFlag = true;
	$errMsg  = t('User id can not be empty');
}
if($pkVal == SUPER_ADMIN_ID){
    $errFlag = true;
	$errMsg  = t('Super admin can not be deleted');
}
if(!$errFlag){
 $userObj->deleteUser($pkVal,$_SESSION['USER_ID'],time());
 $status = true;
}
$output['status'] = $status;
$output['message'] = $errMsg;
die(json_encode($output));
?>