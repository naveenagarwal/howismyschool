<?php

if( $login->is_user_logged_in() ) {
    $is_logout = 'show';
}
else {
    $is_logout = 'hide';
}

$wall_obj = create_model_object($db_obj, WALL_PATH, 'CreateWall');

$html = $wall_obj->get_design_image($_GET['id'])[0]['html'];
require_once('./view/create-wall/DesignImage.php');

?>