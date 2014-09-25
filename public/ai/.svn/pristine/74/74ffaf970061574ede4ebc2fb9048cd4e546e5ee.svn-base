<?php
//load model class
require_once('./model/texture/Texture.php');
$texture_obj = new Texture($db_obj);

$err_flag = false;
$status = false;
$err_msg  = t('Record deleted succesfully');

$pk_val = trim($db_obj->mysql_data_encode($_REQUEST['delId']));
if(empty($pk_val)){
	$err_flag = true;
	$err_msg  = t('Texture id can not be empty');
}else{
	if($texture_obj->check_active_product($pk_val)){
    $err_flag = true;
    $err_msg = t('This texture can not be deleted as there are active product
    associated with this texture');
   }
}
if(!$err_flag){
	// DELETE IMAGE IF EXIST
	$result_set  = $texture_obj->load_texture_details($pk_val);
	$image_path = $result_set['image_path'];
	if(!empty($image_path) && file_exists(TEXTURE_IMAGE_PHYSICAL_PATH.'/'.$image_path)){
		@unlink(TEXTURE_IMAGE_PHYSICAL_PATH.'/'.$image_path);
	}

	$texture_obj->delete_texture($pk_val);
	$status = true;
}
$output['status'] = $status;
$output['message'] = $err_msg;
die(json_encode($output));
?>