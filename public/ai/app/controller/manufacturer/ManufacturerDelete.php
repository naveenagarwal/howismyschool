<?php
//load model class
require_once('./model/manufacturer/Manufacturer.php');
$manufacturer_obj = new Manufacturer($db_obj);

$err_flag = false;
$status = false;
$err_msg  = t('Record deleted succesfully');

$pk_val = trim($db_obj->mysql_data_encode($_REQUEST['delId']));
if(empty($pk_val)){
	$err_flag = true;
	$err_msg  = t('Manufacturer id can not be empty');
}else{
	if($manufacturer_obj->check_active_product($pk_val)){
    $err_flag = true;
    $err_msg = t('This manufacturer can not be deleted as there are active product 
    associated with this manufacturer');
   }
}
if(!$err_flag){
	// DELETE IMAGE IF EXIST 
	$result_set  = $manufacturer_obj->load_manufacturer_details($pk_val);
	$image_path = $result_set['image_path'];
	if(!empty($image_path) && file_exists(MANUFACTURER_IMAGE_PHYSICAL_PATH.'/'.$image_path)){
		@unlink(MANUFACTURER_IMAGE_PHYSICAL_PATH.'/'.$image_path);
	}
	$manufacturer_obj->delete_manufacturer($pk_val);
	$status = true;
}
$output['status'] = $status;
$output['message'] = $err_msg;
die(json_encode($output));
?>