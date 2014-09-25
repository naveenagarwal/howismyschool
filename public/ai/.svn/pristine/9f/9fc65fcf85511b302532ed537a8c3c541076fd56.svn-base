<?php
//verify sub-module access
$editPath        = 'translation/translation-edit';
$deletePath      = 'translation/translation-delete';
$addPath         = 'translation/translation-add';
$uploadTranslationPath = 'translation/translation-upload';

$addAllowed     = $login->verify_module_access($addPath);
$editAllowed    = $login->verify_module_access($editPath);
$deleteAllowed  = $login->verify_module_access($deletePath);
$uploadAllowed  = $login->verify_module_access($uploadTranslationPath);

    $fieldsArray = array(
	'srNo' => array('label' => t('Sr. No'),'style'=>'width:8%;'),
    'source_label'=>array('label'=>t('Source Label'),'style'=>'width:30%;',
	'sorting'=>TRUE),
    'translated_label'=>array('label'=>t('Translated Label'),'style'=>'width:30%;',
	'sorting'=>TRUE)
    );
    if($editAllowed){
      $fieldsArray[EDIT_OP] = array('label'=>t('Edit'),'style'=>'width:10%;',
      'sorting'=>FALSE,'PK_FIELD'=>'id','EDIT_TYPE'=>URL_BASED,
      'EDIT_ACTION'=>$editPath);
    }
    if($deleteAllowed){
	 $fieldsArray[DELETE_OP] = array('label'=>t('Delete'),'style'=>'width:10%;',
	 'sorting'=>FALSE,'PK_FIELD'=>'id','DELETE_TYPE'=>JS_BASED,
	 'DELETE_ACTION'=>'deleteConfirm');
    }

 $defaultSortField = 'source_label';
 $defaultSortOrder = 'ASC';

if(isset($_REQUEST['data-list']) && $_REQUEST['data-list'] == '1'){
	/*search*/
	$search      = urldecode($_REQUEST['search']);
	$search      = trim($db_obj->mysql_data_encode($search));

	/*Paging*/
	$limit = $utility_obj->getDataTableLimit(RECORDS_PER_PAGE);
	/*Ordering*/
	$sOrder = $utility_obj->getDataTableOrderBy($fieldsArray,$defaultSortField,
	$defaultSortOrder);

	//load model class
    include_once('./model/translation/translation.php');
    $translationObj = new translation($db_obj);

	$totalRecords = $translationObj->get_total_translations($search);
	$resultSet    = $translationObj->get_translation_list($sOrder,$limit,$search);

	//prepare the record set
	$output = $utility_obj->prepareDataTableRows($resultSet,$totalRecords,$page,
	RECORDS_PER_PAGE,$fieldsArray);
    die(json_encode(encode_json_array($output)));
}

$recordURL = URL."translation/translation-list&ajax=1&data-list=1";
$deleteURL = URL."translation/translation-delete&ajax=1";
$tableId = 'translationDivTable';
$dataListInput = array(
                      'TABLE_ID'=>$tableId,
                      'RECORDS_PER_PAGE'=>RECORDS_PER_PAGE,
                      'LINKS_PER_PAGE'=>LINKS_PER_PAGE,
                      'RECORD_URL'=>$recordURL,
                      'FIELDS'=>$fieldsArray,
					  'DEFAULT_SORT_FIELD'=>$defaultSortField,
					  'DEFAULT_SORT_ORDER'=>$defaultSortOrder,
                      'LIST_HEADING'=>$utility_obj->getPageName($pageURL,2)
                    );


$tableHTML = $utility_obj->displayDataTableListing($dataListInput);
require_once('./view/translation/translation-list.php');
?>