<?php
//load model class
require_once('./model/product/Product.php');
$product_obj = new Product($db_obj);

$err_flag = false;
$status = false;
$err_msg  = t('Record deleted succesfully');

$pk_val = trim($db_obj->mysql_data_encode($_REQUEST['delId']));
if(empty($pk_val)){
	$err_flag = true;
	$err_msg  = t('Product id can not be empty');
}
if(!$err_flag){
	// DELETE IMAGE IF EXIST 
	$result_set  = $product_obj->load_product_details($pk_val);
	$image_path = $result_set['image_path'];
	if(!empty($image_path) && file_exists(PRODUCT_IMAGE_PHYSICAL_PATH.'/'.$image_path)){
		@unlink(PRODUCT_IMAGE_PHYSICAL_PATH.'/'.$image_path);
	}
	$product_obj->delete_product($pk_val);
	$status = true;
}
$output['status'] = $status;
$output['message'] = $err_msg;
die(json_encode($output));
?>