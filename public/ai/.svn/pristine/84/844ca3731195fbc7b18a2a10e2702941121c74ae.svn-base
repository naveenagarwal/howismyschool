<?php
$return_url = '';
if ($_REQUEST['rurl'] != '') {
    $return_url = URL . trim($_REQUEST['rurl']). '&sortField='
    .trim($_REQUEST['sortField'])
    . '&sortOrderBy=' . trim($_REQUEST['sortOrderBy'])
    . '&page=' . trim($_REQUEST['page']);
}

//load model class
require_once('./model/size/Size.php');
$size_obj = new Size($db_obj);

$page_url = URL.$_SERVER['QUERY_STRING'];


//process POST vars
if(!empty($_POST['submit'])){
    //create validation arrays
    $validation_array[] = array('value' => t('Size Name'),'type' => 'input_text',
	'required' => TRUE,'vtype' => 3,'vmax' => 100);
    $data_array[]   = array('name' => $_POST['name']);
    $column_array[] = 'name';

    $validation_array[] = array('value' => t('Status'),'type' => 'radio',
    'required' => TRUE,
	'vtype' => 0,'vmax' => 0,'enum'=>'1~0');
    $data_array[]   = array('is_active' => $_POST['is_active']);
    $column_array[] = 'is_active';

    $cnt = count($validation_array);
    $error_flag = false;
    $success_flag = false;
    for($i=0;$i<$cnt;$i++){
        if(!$utility_obj->validate_form_field($validation_array[$i],$data_array[$i],
        $column_array[$i])){
            $error_flag = true;
            $utility_obj->set_flash_message($_SESSION['errorMessage'],'error');
            break;
        }
    }

    if(!$error_flag){
        //save the data
        //check duplicate values
        if($size_obj->check_duplicate_column('name',$_POST['name'])){
            $error_flag = true;
            $utility_obj->set_flash_message(t('This size name already exists'),
            'error');
        }
		$image_name='';
		if(!$error_flag){
			$target_path = SIZE_IMAGE_PHYSICAL_PATH;
			if (!empty($_FILES['image_path']['name'])) {
				$temp_file = $_FILES['image_path']['tmp_name'];
				$temp_name = $_FILES['image_path']['name'];
				$file_parts = pathinfo($_FILES['image_path']['name']);
				$image_name = 'size'.time().'.'.$file_parts['extension'];
				$target_file = rtrim($target_path,'/') . '/' . $image_name;
				$file_types = array('jpg','jpeg','gif','png');
				if($_FILES['image_path']['name'] !='' 
				 && $_FILES['image_path']['tmp_name'] == ''){
					$utility_obj->set_flash_message(t('Manimum file size exceeds'),
					'error');
				}
				else if($_FILES['image_path']['size']>IMAGE_MAX_UPLOAD_B){
					$utility_obj->set_flash_message(t('Maximum file size exceeds'),
					'error');
				}
				else if (in_array(strtolower($file_parts['extension']),$file_types)){
					$utility_obj->make_thumbnail_image($temp_file,$target_file,SIZE_IMAGE_WIDTH);
				} else {
					$utility_obj->set_flash_message(t('Invalid file type.'),
					'error');
				}
			
			}
		}
        if(!$error_flag){
            $data['name']		= $_POST['name'];
            $data['image_path']	= $image_name;
            $data['is_active']	= $_POST['is_active'];
            $returnId = $size_obj->save_size_data($data);
            if($returnId){
                $success_flag = true;
                $utility_obj->set_flash_message(t('Data saved successfully'),
                'success');
                $page_urlArray = explode('rurl', $_SERVER['QUERY_STRING']);
                $utility_obj->redirect_user(URL.'size/SizeAdd&fancy=1');
                exit;
            }else{
                $error_flag = true;
                $utility_obj->set_flash_message(t('Data could not be saved'),
                'error');
            }
        }
    }
}

$noRecords = false;
require_once('./view/size/SizeAdd.php');
?>