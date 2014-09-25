<?php

$product_mgmt_obj = create_model_object($db_obj, PRODUCT_MANAGEMENT_PATH, 'ProductManagement'); //load model class

$manufacturers_list = $product_mgmt_obj->get_manufacturers();
$jsonResult = array();
if( empty($manufacturers_list) ) {
    $jsonResult['message']  = t('No manufacturer records found.');
}
else {
    $jsonResult['manufacturers']  = $manufacturers_list;
}

die(json_encode($jsonResult));

?>