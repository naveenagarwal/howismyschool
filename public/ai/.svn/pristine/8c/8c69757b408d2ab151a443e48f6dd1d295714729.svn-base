<?php
//load model class
require_once('./model/user-roles/users.php');
$userObj = new users($db_obj);

$id = trim($_POST['id']);
if($id == ''){
die(t('User information not found'));
}
$imagePath = '';
$userObj->update_user_image($id,$imagePath);
die("OK");
?>