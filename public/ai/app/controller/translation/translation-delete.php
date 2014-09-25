<?php
//load model class
require_once('./model/translation/translation.php');
$translationObj = new translation($db_obj);

$errFlag = false;
$status = false;
$errMsg  = t('Record deleted succesfully');

$pkVal = trim($db_obj->mysql_data_encode($_REQUEST['delId']));
if(empty($pkVal)){
	$errFlag = true;
	$errMsg  = t('Translation id can not be empty');
}
if(!$errFlag){
 $translationObj->delete_translation_by_id($pkVal);
 $status = true;
}
$output['status'] = $status;
$output['message'] = $errMsg;
die(json_encode($output));
?>