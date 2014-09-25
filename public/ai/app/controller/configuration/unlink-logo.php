<?php
require_once('./model/configuration/configuration.php');
$configObj = new configuration($db_obj);
$resultSet = $configObj->load_configuration_details();
$siteLogo = $resultSet['site_logo_path'];
$data['site_logo_path'] = '';
//unlink file
$targetfile = IMAGE_PHYSICAL_PATH.'/'.SITE_HEADER_IMG;
if(@unlink($targetfile)){
	if($configObj->save_configuration_data($data)){
	    $masterArray['CustomError'] = false;
	    $masterArray['message'] = t("Logo has been deleted successfully.");
	    die(json_encode(encode_json_array($masterArray)));
	}else{
		$masterArray['CustomError'] = true;
	    $masterArray['message'] = t("Logo could not be deleted.");
	    die(json_encode(encode_json_array($masterArray)));
	}
}else{
	$masterArray['CustomError'] = true;
    $masterArray['message'] = t("Logo could not be deleted.");
    die(json_encode(encode_json_array($masterArray)));
}
die(json_encode($masterArray)); 
?>