<?php
if (!empty($_POST)) {
	$newpassword = trim($_POST['newpassword']);
	$confnewpassword = trim($_POST['confnewpassword']);
    //create validation arrays
    $validationArray[] = array('value' => t('Enter New Password'),
    'type' => 'input_text','required' => TRUE,'vtype' => 0,'vmax' => 10);
    $dataArray[]   = array('newpassword' => $_POST['newpassword']);
    $columnArray[] = 'newpassword';

    $validationArray[] = array('value' => t('Re-enter New Password'),
    'type' => 'input_text','required' => TRUE,'vtype' => 0,'vmax' => 10);
    $dataArray[]   = array('confnewpassword' => $_POST['confnewpassword']);
    $columnArray[] = 'confnewpassword';

    //validate fields
    $cnt = count($validationArray);
    $errorFlag = false;
    $successFlag = false;
    for($i=0;$i<$cnt;$i++){
        if(!$utility_obj->validate_form_field($validationArray[$i],$dataArray[$i],
        $columnArray[$i])){
            $errorFlag = true;
            $utility_obj->set_flash_message($errorMessage,'error');
            break;
        }
    }

    //Match if the value of both elements are same
    if(trim($_POST['newpassword']) != trim($_POST['confnewpassword']) 
    and !$errorFlag){
        $errorFlag = true;
        $utility_obj->set_flash_message(t('Passwords do not matched'),'error');
    }
    if(!$errorFlag){
        $encrypted_val = isset($_REQUEST['e']) ? $_REQUEST['e'] : '';
        $new_password = isset($_REQUEST['newpassword']) ? 
        $_REQUEST['newpassword'] : '';
        $conf_new_password = isset($_REQUEST['confnewpassword']) ?
        $_REQUEST['confnewpassword'] : '';

        if(!empty($encrypted_val)) {
            $decrypted_val = base64_decode($encrypted_val);
            $explode_vals = explode('_', $decrypted_val);
            if(count($explode_vals) == 4) {
                $return = $login->verify_email_username(trim($explode_vals[1]));
                if($return == FALSE) {
                    $utility_obj->set_flash_message(t("An error occured while 
                    resetting password. Please try again later."), 'error');
                } else {
                    if($return['email_id'] == $explode_vals[0] && 
                    	$return['id'] == $explode_vals[2]) {
                        $password_update = $login->update_password($explode_vals[1],
                        $_POST['newpassword']);
                        if($password_update == TRUE) {
                            $utility_obj->set_flash_message(t("Password have been 
                            updated successfully."), 'success');
                        } else {
                            $utility_obj->set_flash_message(t("An error occured 
                            while resetting password. Please try again later."),
                            'error');
                        }
                        header('Location: '. URL . 'login');
                        exit;
                    } else {
                        $utility_obj->set_flash_message(t("An error occured while 
                        resetting password. Please try again later."), 'error');
                    }
                }
            } else {
                $utility_obj->set_flash_message(t("An error occured while resetting
                 password. Please try again later."), 'error');
                header('Location: '. URL . 'login');
            }
        } else {
            $utility_obj->set_flash_message(t("An error occured while 
            resetting password. Please try again later."), 'error');
            header('Location: '. URL . 'login');
        }
    }
} else {
    if ($login->is_user_logged_in()) {
        header('Location: ' . URL . 'dashboard');
    } else if(!isset($_REQUEST['e']) || empty($_REQUEST['e'])) {
        $utility_obj->set_flash_message(t(ACCESS_DENIED_MESSAGE), 'error');
        header('Location: '. URL . 'login');
    }else{
    	//check validity of PWD RESET LINK
    	$input = explode('_',base64_decode($_REQUEST['e']));
    	include_once('./model/user-roles/users.php');
		$userObj = new users($db_obj);
		$userData = $userObj->checkPwdResetTokenValidity($input[2]);
		if(!$userData){
		  $utility_obj->set_flash_message(t("Sorry, this user do not exists"),
		  'error');
		  header('Location: '. URL . 'login');
          exit;
		}elseif ($userData['reset_password_token'] != $_REQUEST['e']) {
		  $utility_obj->set_flash_message(t("Sorry, password reset token do 
		  not exists any more"),'error');
		  header('Location: '. URL . FORGOT_PASSWORD_LINK);
          exit;
		}elseif (time() > $userData['reset_password_end_time']) {
		  $utility_obj->set_flash_message(t("Sorry, password reset link
		  expired"),'error');
		  header('Location: '. URL . FORGOT_PASSWORD_LINK);
          exit;
		}
    }
}
require_once('./view/user-roles/users/reset-password.php');
?>