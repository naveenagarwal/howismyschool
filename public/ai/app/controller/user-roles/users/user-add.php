<?php
$returnURL = '';
if ($_REQUEST['rurl'] != '') {
	$returnURL = URL . trim($_REQUEST['rurl']). '&sortField='.
	trim($_REQUEST['sortField'])
	. '&sortOrderBy=' . trim($_REQUEST['sortOrderBy'])
	. '&page=' . trim($_REQUEST['page']);
}
require_once('./model/user-roles/users.php');
$userObj = new users($db_obj);

require_once('./model/user-roles/permission.php');
$permissionObj = new permission($db_obj);   

$rolesData  = $userObj->load_role_list(SUPER_ADMIN_ROLE.','.DELETED_ROLE,3);
$rolesArray = array();
$rolesArray[] = t('Select');
if(is_array($rolesData) && count($rolesData)){
    foreach ($rolesData as $role){
        $rolesArray[$role['id']] = $role['role_code'];
    }
}
$selectedRole = trim($_POST['role_id']);

$pageURL = URL.$_SERVER['QUERY_STRING'];

if (!empty($_POST['submit'])) {

	foreach ($_POST as &$value) {
		$value = trim($value);
	}
	$validationArray[] = array('value' => t('Username'), 'type' => 'input_text',
	'required' => TRUE, 'vtype' => 0, 'vmax' => 20);
	$dataArray[] = array('user_name' => $_POST['user_name']);
	$columnArray[] = 'user_name';

	$validationArray[] = array('value' => t('Password'), 'type' => 'input_text',
	'required' => TRUE, 'vtype' => 0, 'vmax' => 10);
	$dataArray[] = array('user_password' => $_POST['user_password']);
	$columnArray[] = 'user_password';

	$validationArray[] = array('value' => t('Confirm Password'), 
	'type' => 'input_text', 'required' => TRUE, 'vtype' => 0, 'vmax' => 10);
	$dataArray[] = array('confirm_password' => $_POST['confirm_password']);
	$columnArray[] = 'confirm_password';
	
	$validationArray[] = array('value' => t('Full Name'), 
	'type' => 'input_text', 'required' => TRUE, 'vtype' => 3, 'vmax' => 50);
	$dataArray[] = array('full_name' => $_POST['full_name']);
	$columnArray[] = 'full_name';
	
	$validationArray[] = array('value' => t('Email'), 'type' => 'input_text', 
	'required' => TRUE, 'vtype' => 5, 'vmax' => 50);
	$dataArray[] = array('email_id' => $_POST['email_id']);
	$columnArray[] = 'email_id';

    if(empty($_POST['role_id'])){
	    $_POST['role_id'] = '';
	}
	$validationArray[] = array('value' => t('Role'), 'type' => 'select', 
	'required' => TRUE, 'vtype' => 0, 'vmax' => 0);
	$dataArray[] = array('role_id' => $_POST['role_id']);
	$columnArray[] = 'role_id';
	
	$validationArray[] = array('value' => t('Status'), 'type' => 'radio',
	'required' => TRUE, 'vtype' => 0, 'vmax' => 0, 'enum' => '1~0');
	$dataArray[] = array('is_active' => $_POST['is_active']);
	$columnArray[] = 'is_active';

	$cnt = count($validationArray);
	$errorFlag = false;
	$successFlag = false;
	for ($i = 0; $i < $cnt; $i++) {
		if (!$utility_obj->validate_form_field($validationArray[$i], 
		    $dataArray[$i], $columnArray[$i])) {
			$errorFlag = true;
			$utility_obj->set_flash_message($errorMessage, 'error');
			break;
		}
	}

	if (trim($_POST['user_password']) != trim($_POST['confirm_password']) &&
	     !$errorFlag) {
		$errorFlag = true;
		$utility_obj->set_flash_message(t('Passwords do not matched'), 'error');
	}
	if (!$errorFlag) {
		//save the data
		//check duplicate values
		if ($userObj->check_duplicate_username('user_name', 
		    $_POST['user_name'])) {
			$errorFlag = true;
			$utility_obj->set_flash_message(t('This username already exists'), 
			'error');
		}

	    if (isset($_POST['email_id']) && !empty($_POST['email_id'])
            && $userObj->check_duplicate_useremail('email_id', 
            $_POST['email_id']) && !$errorFlag) {
			$errorFlag = true;
			$utility_obj->set_flash_message(t('This email id already exists'), 
			'error');
		}

		if (!$errorFlag) {
			$data['user_name'] = trim($_POST['user_name']);
			$data['user_password'] = trim($_POST['user_password']);
			$data['role_id'] = trim($_POST['role_id']);
			$data['is_active'] = trim($_POST['is_active']);
			$data['full_name'] = trim($_POST['full_name']);
			$data['email_id'] = trim($_POST['email_id']);

			$returnId = $userObj->save_user_data($data);
			if ($returnId) {
				$successFlag = true;
				// Send mail to concern user regarding account
				$utility_obj->send_user_creation_mail($data);
				$utility_obj->set_flash_message(t('Data saved successfully'), 'success');
				//set permission
				$roleId = trim($_POST['role_id']);
				//UPDATE user_permission table				
				$is_insert = $permissionObj->update_user_permission($returnId,
				$roleId);				
				$pageURLArray = explode('rurl', $_SERVER['QUERY_STRING']);
				$utility_obj->redirect_user(URL . 'user-roles/users/user-add&fancy=1');
				exit;
			} else {
				$errorFlag = true;
				$utility_obj->set_flash_message(t('Data could not be saved'), 'error');
			}
		}
	}
}

$noRecords = false;

require_once('./view/user-roles/users/user-add.php');
?>