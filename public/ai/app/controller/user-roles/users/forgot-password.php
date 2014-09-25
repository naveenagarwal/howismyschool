<?php
if (!empty($_POST)) {

	$userName2 = $userName = trim($_POST['username']);
	$userName = $db_obj->mysql_data_encode($userName);
	if(empty($userName)){
		$utility_obj->set_flash_message(t("Username or email id can
		not be empty."), 'error');
		$utility_obj->redirect_user(URL.'user-roles/users/forgot-password');
    	exit;
	}
	//need to apply XSS and mysql injection prevention function
	$return = $login->verify_email_username($userName);
	if($return == FALSE) {
		$utility_obj->set_flash_message(t("We couldn't find an account
		associated with provided username or email."), 'error');
	} else {
		include_once('./model/common/common.php');
		$cmnObj = new common($db_obj);
		//send password reset mail
		$token = base64_encode($return['email_id'].'_'.
     	$return['user_name'].'_'.$return['id']
     	.'_'.$cmnObj->generate_unique_string());
     	include_once('./model/user-roles/users.php');
		$userObj = new users($db_obj);
		//update pwd token
		$start = time();
		$end   = $start + PWD_RESET_TIME_SPAN;
		$userObj->updatePwdResetToken($return['user_name'],
		$token,$end);
		$utility_obj->send_password_reset_mail($return,$token);
		$userName2 = '';
		$utility_obj->redirect_user(URL.'user-roles/users/forgot-password');
		exit;
	}
} else {
	if ($login->is_user_logged_in()) {
		header('Location: ' . URL . 'dashboard');
	}
}
require_once('./view/user-roles/users/forgot-password.php');
?>