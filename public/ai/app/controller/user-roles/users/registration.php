<?php
require_once('./model/user-roles/users.php');
$userObj = new users($db_obj);

require_once('./model/user-roles/permission.php');
$permissionObj = new permission($db_obj);

if ( !empty($_POST) ) {
	$user_name 			= trim($_POST['user_name']);
	$user_password 		= trim($_POST['user_password']);
	$confirm_password 	= trim($_POST['confirm_password']);
	$full_name 			= trim($_POST['full_name']);
	$email_id			= trim($_POST['email_id']);
	$contact_no 		= trim($_POST['contact_no']);

	foreach ($_POST as &$value) {
		$value = trim($value);
	}

	$validationArray[] = array('value' => t('Username'), 'type' => 'input_text', 'required' => TRUE, 'vtype' => 0,
	                           'vmax' => 20);
	$dataArray[] = array('user_name' => $user_name);
	$columnArray[] = 'user_name';

	$validationArray[] = array('value' => t('Password'), 'type' => 'input_text', 'required' => TRUE, 'vtype' => 0,
	                           'vmax' => 10);
	$dataArray[] = array('user_password' => $user_password);
	$columnArray[] = 'user_password';

	$validationArray[] = array('value' => t('Confirm Password'), 'type' => 'input_text', 'required' => TRUE,
	                           'vtype' => 0, 'vmax' => 10);
	$dataArray[] = array('confirm_password' => $confirm_password);
	$columnArray[] = 'confirm_password';

	$validationArray[] = array('value' => t('Full Name'), 'type' => 'input_text', 'required' => TRUE, 'vtype' => 3,
	                           'vmax' => 200);
	$dataArray[] = array('full_name' => $full_name);
	$columnArray[] = 'full_name';

	$validationArray[] = array('value' => t('Email'), 'type' => 'input_text', 'required' => TRUE, 'vtype' => 5,
	                           'vmax' => 200);
	$dataArray[] = array('email_id' => $email_id);
	$columnArray[] = 'email_id';

	$validationArray[] = array('value' => t('Contact No'), 'type' => 'input_text', 'vtype' => 0, 'vmax' => 10);
	$dataArray[] = array('contact_no' => $contact_no);
	$columnArray[] = 'contact_no';

	$cnt = count($validationArray);
	$errorFlag = false;
	$successFlag = false;
	for ($i = 0; $i < $cnt; $i++) {
		if (!$utility_obj->validate_form_field($validationArray[$i], $dataArray[$i], $columnArray[$i])) {
			$errorFlag = true;
			$utility_obj->set_flash_message($errorMessage, 'error');
			break;
		}
	}

	if ($user_password != $confirm_password && !$errorFlag) {
		$errorFlag = true;
		$utility_obj->set_flash_message(t('Passwords do not match'), 'error');
	}

	if (!$errorFlag) {
		//save the data
		//check duplicate values
		if ($userObj->check_duplicate_username('user_name', $user_name)) {
			$errorFlag = true;
			$utility_obj->set_flash_message(t('This username already exists'), 'error');
		}

	    if (isset($email_id) && !empty($email_id) && $userObj->check_duplicate_useremail('email_id', $email_id)
	        && !$errorFlag) {
			$errorFlag = true;
			$utility_obj->set_flash_message(t('This email id already exists'), 'error');
		}

		if (!$errorFlag) {
			$data['user_name'] 		= $user_name;
			$data['user_password'] 	= $user_password;
			$data['full_name'] 		= $full_name;
			$data['email_id'] 		= $email_id;
			$data['contact_no']		= ( !empty($contact_no) ) ? $contact_no : '';
			$data['role_id'] 		= ENDUSER_ROLE_ID;
			$data['is_active'] 		= 1;
			$_SESSION['USER_ID']	= 0; // It shows that no admin user created this account as this is an end user

			$returnId = $userObj->save_user_data($data);
			if ($returnId) {
				$successFlag = true;
				// Send mail to concern user regarding account
				$utility_obj->send_user_creation_mail($data);
				$utility_obj->set_flash_message(t('Data saved successfully'), 'success');
				$utility_obj->redirect_user(URL . 'user-roles/users/registration&fancy=1');
				exit;
			} else {
				$errorFlag = true;
				$utility_obj->set_flash_message(t('Data could not be saved'), 'error');
			}
		}
	}
}
else {
	if ($login->is_user_logged_in()) {
		header('Location: ' . URL . 'dashboard');
	}
}
require_once('./view/user-roles/users/registration.php');
?>