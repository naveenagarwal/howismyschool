<?php
//load model class
require_once('./model/color/Color.php');
$color_obj = new Color($db_obj);

$err_flag = false;
$status = false;
$err_msg  = t('Record deleted succesfully');

$pk_val = trim($db_obj->mysql_data_encode($_REQUEST['delId']));
if(empty($pk_val)){
	$err_flag = true;
	$err_msg  = t('Color id can not be empty');
}else{
	if($color_obj->check_active_product($pk_val)){
		$err_flag = true;
		$err_msg = t('This color can not be deleted as there are active product 
		associated with this Color');
   }
}
if(!$err_flag){
	// DELETE IMAGE IF EXIST 
	$result_set  = $color_obj->load_color_details($pk_val);
	$image_path = $result_set['image_path'];
	if(!empty($image_path) && file_exists(COLOR_IMAGE_PHYSICAL_PATH.'/'.$image_path)){
		@unlink(COLOR_IMAGE_PHYSICAL_PATH.'/'.$image_path);
	}
	
	$color_obj->delete_color($pk_val);
	$status = true;
}
$output['status'] = $status;
$output['message'] = $err_msg;
die(json_encode($output));
?>