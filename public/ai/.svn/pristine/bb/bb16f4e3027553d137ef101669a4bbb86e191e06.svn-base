<?php

$user_obj = create_model_object($db_obj, 'user-roles/', 'users'); //load model class

$json_result = array();
if( !empty($_POST) ) {
    $username         = trim($_POST['username']);
    $password         = trim($_POST['password']);
    $confirm_password = trim($_POST['confirm_password']);
    $email_id         = trim($_POST['email_id']);
    $first_name       = trim($_POST['first_name']);
    $last_name        = trim($_POST['last_name']);
    $company_name     = trim($_POST['company_name']);
    $address          = trim($_POST['address']);
    $country          = trim($_POST['country']);
    $city             = trim($_POST['city']);
    $zipcode          = trim($_POST['zipcode']);
    $contact_no       = trim($_POST['contact_no']);
    $user_type        = !empty( $_POST['user_type'] ) ? implode(',', $_POST['user_type']) : '';

    if( empty($username) ) {
        $json_result['message'] = t('Please enter username');
    }
    if( empty($password) ) {
        $json_result['message'] = t('Please enter password');
    }
    if( empty($confirm_password) ) {
        $json_result['message'] = t('Please enter confirm password');
    }
    if( empty($email_id) ) {
        $json_result['message'] = t('Please enter email id');
    }
    if( empty($first_name) ) {
        $json_result['message'] = t('Please enter first name');
    }
    if( empty($last_name) ) {
        $json_result['message'] = t('Please enter last name');
    }

    if( $password != $confirm_password ) {
        $json_result['message'] = t('Passwords do not match');
    }

    if( $user_obj->check_duplicate_username('user_name', $username) ) {
        $json_result['message'] = t('This username already exists');
    }

    if( $user_obj->check_duplicate_useremail('email_id', $email_id) ) {
        $json_result['message'] = t('This email id already exists');
    }

    if( empty($json_result['message']) ) {
        $data['user_name']      = $username;
        $data['user_password']  = $password;
        $data['email_id']       = $email_id;
        $data['full_name']      = $first_name . ' ' . $last_name;
        $data['company_name']   = $company_name;
        $data['address']        = $address;
        $data['country']        = $country;
        $data['city']           = $city;
        $data['zipcode']        = $zipcode;
        $data['contact_no']     = $contact_no;
        $data['user_type']      = $user_type;
        $data['role_id']        = ENDUSER_ROLE_ID;
        $data['is_active']      = 1;
        $_SESSION['USER_ID']    = 0; // It shows that no admin user created this account as this is an end user

        $result = $user_obj->save_user_data($data);
        if( $result ) {
            $_SESSION['USER_LOGGED_IN']      = 1;
            $_SESSION['USER_ID'] = $result;
            $json_result['message'] = t('Success');
        }
        else {
            $json_result['message'] = t('Registration not successful');
        }
    }
}
else {
    $json_result['message'] = t('Invalid method detected');
}

die(json_encode($json_result));
?>