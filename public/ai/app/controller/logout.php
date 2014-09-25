<?php
$login->user_log_out();
$redirectURL = URL;
if($_GET['idle'] == '1'){
  session_start();
  $utility_obj->set_flash_message(t('You are logged out due to inactivity'),'error');
  $redirectURL .= 'login';
}
header('Location: '.$redirectURL);
exit;
?>