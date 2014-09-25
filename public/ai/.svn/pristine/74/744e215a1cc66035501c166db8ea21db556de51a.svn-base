<?php

$product_mgmt_obj = create_model_object($db_obj, PRODUCT_MANAGEMENT_PATH, 'ProductManagement'); //load model class

$list_ids['manufacturer_id'] = trim($_POST['manufacturer_id']);
$sizes_list = $product_mgmt_obj->get_sizes($list_ids);
$jsonResult = array();
if( empty($sizes_list) ) {
    $jsonResult['message']  = t('No size records found.');
}
else {
    $jsonResult['sizes']  = $sizes_list;
}

die(json_encode($jsonResult));

?>