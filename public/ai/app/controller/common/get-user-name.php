<?php
require './model/user-roles/users.php';
$encodedres = array();
$user_obj = new users($db_obj);
$ucode = trim($_POST['c']);
$search_for_role = '';
$msg='';
if(empty($ucode)) {
    $encodedres = array (
        'resp'  =>  'error',
        'msg'   =>  t('Code should not be empty')
    );
} else {
    $user_details = $user_obj->getUserDetialsByCode($ucode, array(), $search_for_role);
    if($user_details == false) {
        $encodedres = array (
            'resp'  =>  'error',
            'msg'   =>  $msg
        );
    } else {
        $encodedres = array (
            'resp'  =>  'done',
            'fn'  =>  $user_details['FullName'],
        );
    }
    }
echo json_encode($encodedres);
?>