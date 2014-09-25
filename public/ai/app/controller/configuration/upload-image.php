<?php
$targetPath = IMAGE_PHYSICAL_PATH;
if (!empty($_FILES)) {
	$tempFile = $_FILES['site_logo_path']['tmp_name'];
	$tempName = $_FILES['site_logo_path']['name'];
	$fileParts = pathinfo($_FILES['site_logo_path']['name']);
	$logoFile = 'logo'.time().'.'.$fileParts['extension'];
	$targetFile = rtrim($targetPath,'/') . '/' . $logoFile;
	$fileTypes = array('jpg','jpeg','gif','png');
    if($_FILES['site_logo_path']['name'] !='' 
     && $_FILES['site_logo_path']['tmp_name'] == ''){
		$arr['success'] = false;
		$arr['msg'] = t('Mamimum file size exceeds');
	}
	else if($_FILES['site_logo_path']['size']>IMAGE_MAX_UPLOAD_B){
		$arr['success'] = false;
		$arr['msg'] = t('Mamimum file size exceeds');
	}
	else if (in_array(strtolower($fileParts['extension']),$fileTypes)){
		include_once('./model/configuration/configuration.php');
		$configObj = new configuration($db_obj);
		$resultSet = $configObj->load_configuration_details();
		$prevSiteLogo = $resultSet['site_logo_path'];
		//delete previous logo file name
		if(!empty($prevSiteLogo) && file_exists(IMAGE_PHYSICAL_PATH.'/'.$prevSiteLogo)){
			@unlink(IMAGE_PHYSICAL_PATH.'/'.$prevSiteLogo);//delete previous logo
		}
		//create thumbnail image
		$utility_obj->make_thumbnail_image($tempFile,$targetFile,SITE_HEADER_IMG_WIDTH);
		$input = array('site_logo_path'=>$logoFile,
		'modified_by'=>$_SESSION['USER_ID'],'modified_at'=>time());
		//update logo file name
		$configObj->save_configuration_data($input);
		$arr['success'] = true;
		$arr['logo_path'] = IMAGE_URL.'/'.$logoFile;
		$arr['msg'] = t('Site logo uploaded successfully');
	} else {
		$arr['success'] = false;
		$arr['msg'] = t('Invalid file type.');
	}
}else{
   $arr['success'] = false;
   $arr['msg'] = t('No input file specified or 
   	file size is too large');	
}
die(json_encode(encode_json_array($arr)));
?>