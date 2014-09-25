<?php
$json_result = array();

if( $_SESSION['USER_ID'] == 0 ) {
    $json_result['message']  = t('Illegal operation');
    die(json_encode($json_result));
}

$design_obj = create_model_object($db_obj, DESIGN_PATH, 'Design'); // load model class

if( !$login->is_user_logged_in() ) {
    $json_result['notLoggedIn'] = true;
    $json_result['message']     = t('Please login first');
}
else {
    $data_arr = array(
                  'user_design_id'  => $_POST['user_design_id'],
                  'html_info'       => $db_obj->mysql_data_encode($_POST['html_info']),
                  'json_info'       => $db_obj->mysql_data_encode($_POST['json_info']),
                  'name'            => $db_obj->mysql_data_encode($_POST['name'])
                  );

    $return_id = $design_obj->save_design($data_arr);
    $json_result['loggedIn']  	   = true;
    if( $return_id ) {
        $json_result['design_id']  = $return_id;
        $json_result['message'] 	 = t('Wall has been saved successfully');
    }
    else {
      $json_result['message']   = t('Wall could not be saved due to some technical issue');
    }
}
die(json_encode($json_result));
?>