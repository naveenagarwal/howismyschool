<?php
$returnURL = '';
if ($_REQUEST['rurl'] != '') {
    $returnURL = URL . trim($_REQUEST['rurl']). '&sortField='
    .trim($_REQUEST['sortField'])
    . '&sortOrderBy=' . trim($_REQUEST['sortOrderBy'])
    . '&page=' . trim($_REQUEST['page']);
}

//load model class
require_once('./model/user-roles/roles.php');
$roleObj = new roles($db_obj);

$pageURL = URL.$_SERVER['QUERY_STRING'];


//process POST vars
if(!empty($_POST['submit'])){
    foreach ($_POST as &$value) {
     $value = trim($value);
    }
    //create validation arrays
    $validationArray[] = array('value' => t('Role Name'),'type' => 'input_text',
	'required' => TRUE,'vtype' => 3,'vmax' => 100);
    $dataArray[]   = array('role_name' => $_POST['role_name']);
    $columnArray[] = 'role_name';

    $validationArray[] = array('value' => t('Role Code'),'type' => 'input_text',
	'required' => TRUE,'vtype' => 2,'vmax' => 50);
    $dataArray[]   = array('role_code' => $_POST['role_code']);
    $columnArray[] = 'role_code';


    $validationArray[] = array('value' => t('Status'),'type' => 'radio',
    'required' => TRUE,
	'vtype' => 0,'vmax' => 0,'enum'=>'1~0');
    $dataArray[]   = array('is_active' => $_POST['is_active']);
    $columnArray[] = 'is_active';

    $cnt = count($validationArray);
    $errorFlag = false;
    $successFlag = false;
    for($i=0;$i<$cnt;$i++){
        if(!$utility_obj->validate_form_field($validationArray[$i],$dataArray[$i],
        $columnArray[$i])){
            $errorFlag = true;
            $utility_obj->set_flash_message($_SESSION['errorMessage'],'error');
            break;
        }
    }

    if(!$errorFlag){
        //save the data
        //check duplicate values
        if($roleObj->check_duplicate_column('role_name',$_POST['role_name'])){
            $errorFlag = true;
            $utility_obj->set_flash_message(t('This role name already exists'),
            'error');
        }
        if($roleObj->check_duplicate_column('role_code',$_POST['role_code'])){
            $errorFlag = true;
            $utility_obj->set_flash_message(t('This code already exists'),'error');
        }

        if(!$errorFlag){
            $data['role_name']    = $_POST['role_name'];
            $data['role_code']    = $_POST['role_code'];
            $data['is_active']     = $_POST['is_active'];
            $returnId = $roleObj->save_role_data($data);
            if($returnId){
                $successFlag = true;
                $utility_obj->set_flash_message(t('Data saved successfully'),
                'success');
                $pageURLArray = explode('rurl', $_SERVER['QUERY_STRING']);
                $utility_obj->redirect_user(URL.'user-roles/roles/role-add&fancy=1');
                exit;
            }else{
                $errorFlag = true;
                $utility_obj->set_flash_message(t('Data could not be saved'),
                'error');
            }
        }
    }
}

$noRecords = false;
require_once('./view/user-roles/roles/role-add.php');
?>