<?php
$returnURL = '';
if ($_REQUEST['rurl'] != '') {
	$returnURL = URL . trim($_REQUEST['rurl']). '&sortField=' .
	trim($_REQUEST['sortField'])
	. '&sortOrderBy=' . trim($_REQUEST['sortOrderBy'])
	. '&page=' . trim($_REQUEST['page']);
}

$pageURL = URL.$_SERVER['QUERY_STRING'];

//load model class
require_once('./model/configuration/configuration.php');
$configObj = new configuration($db_obj);

$resultSet = $configObj->load_configuration_details();
$siteLogo = $resultSet['site_logo_path'];
//process POST vars
if(!empty($_POST['submit'])){
    
	//create validation arrays
	$validationArray[] = array('value' => t('Site Name'),
	'type' => 'input_text','required' => TRUE,'vtype' => 0,
	'vmax' => 255);
	$dataArray[]   = array('site_name' => $_POST['site_name']);
	$columnArray[] = 'site_name';

	$validationArray[] = array('value' => t('Site Email'),
	'type' => 'input_text','required' => TRUE,'vtype' => 5,
	'vmax' => 255);
	$dataArray[]   = array('site_email' => $_POST['site_email']);
	$columnArray[] = 'site_email';

	$cnt = count($validationArray);
	$errorFlag = false;
	$successFlag = false;
	for($i=0;$i<$cnt;$i++){
		if(!$utility_obj->validate_form_field($validationArray[$i],
			$dataArray[$i],$columnArray[$i])){
			$errorFlag = true;
			$utility_obj->set_flash_message($errorMessage,'error');
			break;
		}
	}
	if(!$errorFlag){
		$inputDataArray = array();
		foreach ($dataArray as $value) {
			$keyArr = array_keys($value);
			$inputDataArray[$keyArr[0]] = 
			$db_obj->mysql_data_encode(trim($value[$keyArr[0]]));
		}
		if($configObj->save_configuration_data($inputDataArray)){
			$successFlag = true;
			$utility_obj->set_flash_message(t('Data saved successfully'),'success');
			$pageURLArray = explode('rurl', $_SERVER['QUERY_STRING']);
			$utility_obj->redirect_user(URL.'configuration/configuration');
			exit;
		}else{
			$errorFlag = true;
			$utility_obj->set_flash_message(t('Data could not be saved'),'error');
		}
	}
}
require_once('./view/configuration/configuration.php');
?>