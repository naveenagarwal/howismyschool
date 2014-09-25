<?php
/**
 * Description : This file used to define all configuration settings
 * @author 		: rasingh - Q3tech
 * @created on 	: Aug 25, 2014
 * @modified on : Aug 25, 2014
 */

	//set time zone
	date_default_timezone_set('Asia/Calcutta');

	// Turn off all error reporting
	ini_set('display_errors', '1');

	//error_reporting (E_ALL ^ E_NOTICE);

	ob_start();
	if (session_id() == ""){
		session_start();
	}

	//DATABASE CONNECTION CONSTANTS

	define('DB_SERVER', '192.168.13.57');
	define('DB_USERNAME', 'root');
	define('DB_PASSWORD', 'Q3tech123');
	define('DB_PORT', '3306');
	define('DB_DATABASE', 'masonry_designer');

	define('ABSPATH', str_replace('\\', '/', dirname(__FILE__)) . '/');

	$tempPath1 = explode('/', str_replace('\\', '/', dirname($_SERVER['SCRIPT_FILENAME'])));
	$tempPath2 = explode('/', substr(ABSPATH, 0, -1));
	$tempPath3 = explode('/', str_replace('\\', '/', dirname($_SERVER['PHP_SELF'])));

	$tc = count($tempPath1);
	for ($i = count($tempPath2); $i < $tc; $i++){
		array_pop ($tempPath3);
	}

	//remove "app" from the path
	$urladdr = $_SERVER['HTTP_HOST'] . str_replace('app','', implode('/', $tempPath3));
	if(isset($_SERVER['QUERY_STRING'])){
		$_SERVER['QUERY_STRING'] = str_replace('pg=', '', $_SERVER['QUERY_STRING']);
	}

	if ($urladdr{strlen($urladdr) - 1}== '/'){
		define('URLADDR', 'http://' . $urladdr);
	}
	else{
		define('URLADDR', 'http://' . $urladdr . '/');
	}

	define('BASEDIR',$_SERVER['DOCUMENT_ROOT'].implode('/', $tempPath3));

	$tempArr = array();
	$tempCnt3 = count($tempPath3)-1;
	for($i=0;$i<$tempCnt3;$i++){
		$tempArr[] = $tempPath3[$i];
	}

	//upto "custom" folder
	define('CUSTOMDIR',$_SERVER['DOCUMENT_ROOT'].implode('/', $tempArr));
	define('CUSTOMWEBPATH','http://'.$_SERVER['HTTP_HOST'].implode('/', $tempArr));

	unset($tempPath1, $tempPath2, $tempPath3, $urladdr);

	define("URL",URLADDR);
	define("IMAGE_URL",URLADDR.'assets/images');
	define("CSS_URL",URLADDR.'assets/css');
	define("JS_URL",URLADDR.'assets/js');
	define("SYS_IMG_URL",URLADDR.'assets/images/');
	define("MEDIA_IMAGE_URL",URLADDR.'media/');
	define("VENDOR_URL",URLADDR.'vendors/');
	define("VENDOR_PHYSICAL_PATH",CUSTOMDIR.'/vendors/');
	define("IMAGE_PHYSICAL_PATH",CUSTOMDIR.'/assets/images');
	define("CSS_PHYSICAL_PATH",CUSTOMDIR.'/assets/css');
	define("JS_PHYSICAL_PATH",CUSTOMDIR.'/assets/js');
	define("CACHE_PHYSICAL_PATH",CUSTOMDIR.'/assets/cache');
	define("CACHE_WEB_PATH",URLADDR.'assets/cache');

	require_once("../class/ModelClass.php");
	$db_obj = new ModelClass;

	require_once("../class/Utility.php");
	$utility_obj = new Utility($db_obj);

	//get site configuration
	$config_array = $utility_obj->get_site_configuration();

	define('SITE_NAME',  $config_array['site_name']);
	define('SITE_EMAIL', $config_array['site_email']);
	define('SITE_OFFLINE_MESSAGE',  $config_array['offline_message']);
	DEFINE('SITE_HEADER_IMG',$config_array['site_logo_path']);
	DEFINE('SITE_FOOTER_TEXT','Copyright &copy; '.date('Y').'
	lilulei gmbh. All Rights Reserved.');
	DEFINE('SITE_HEADER_IMG_WIDTH','100');


	define(RECORDS_PER_PAGE,25);
	define(LINKS_PER_PAGE,5);

	define(MENU_DATA_BUILDING,1);
	define(PERMISSION_DATA_BUILDING,1);

	define('STYLE_PATH', 'css/');

	$serverSW = strtolower($_SERVER["SERVER_SOFTWARE"]);
	if(strpos($serverSW,'nginx') !== false){ //for nginx
	 define('FORGOT_PASSWORD_LINK', '/user-roles/users/forgot-password');
	 define('RESET_PASSWORD_LINK', '/user-roles/users/reset-password');
	 define('ABOUT_US_LINK', '/about-us');
	 define('REGISTRATION_LINK', '/user-roles/users/registration');
	}else{//for apache
	 define('FORGOT_PASSWORD_LINK', 'user-roles/users/forgot-password');
	 define('RESET_PASSWORD_LINK', 'user-roles/users/reset-password');
	 define('ABOUT_US_LINK', 'about-us');
	 define('REGISTRATION_LINK', 'user-roles/users/registration');
	}


	//include common function's file
	require_once('CommonFunctions.php');

	//include database field related constant file
	require_once('Constants.Inc.php');


	if(check_query_string()){
		print "<font color='#ff0000' size='4'>".
		t('Sorry ! Please contact Administrator')."</font>";
		exit;
	}
?>
