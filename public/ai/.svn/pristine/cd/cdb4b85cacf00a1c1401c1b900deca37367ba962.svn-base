<?php
$json_result = array();

if( $_SESSION['USER_ID'] == 0 || empty($_SESSION['USER_ID']) ) {
    $json_result['message']  = t('Illegal operation');
    die(json_encode($json_result));
}

$design_obj = create_model_object($db_obj, DESIGN_PATH, 'Design'); // load model class

if( !$login->is_user_logged_in() ) {
    $json_result['notLoggedIn']   = true;
    $json_result['message']       = t('Please login first');
}
else {
    $user_designs = $design_obj->get_designs_by_user_id();
    $json_result['loggedIn']      = true;
    $json_result['user_designs']  = $user_designs;
}
die(json_encode($json_result));
?>