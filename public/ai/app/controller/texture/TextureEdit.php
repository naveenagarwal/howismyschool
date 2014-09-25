<?php
$error_flag = false;
$pk_field = trim($_REQUEST['id']);

$return_url = '';
if ($_REQUEST['rurl'] != '') {
    $return_url = URL . trim($_REQUEST['rurl']) . '&sortField='
    .trim($_REQUEST['sortField'])
    . '&sortOrderBy=' . trim($_REQUEST['sortOrderBy'])
    . '&page=' . trim($_REQUEST['page']);
}


//load model class
require_once('./model/texture/Texture.php');
$texture_obj = new Texture($db_obj);

$page_url = URL.$_SERVER['QUERY_STRING'];

//process POST vars
if(!empty($_POST['submit'])){
    //create validation arrays
    $validation_array[] = array('value' => t('Texture Name'),'type' => 'input_text',
	'required' => TRUE,'vtype' => 3,'vmax' => 100);
    $data_array[]   = array('name' => $_POST['name']);
    $column_array[] = 'name';

    $validation_array[] = array('value' => t('Status'),'type' => 'radio',
    'required' => TRUE,
	'vtype' => 0,'vmax' => 0,'enum'=>'1~0');
    $data_array[]   = array('is_active' => $_POST['is_active']);
    $column_array[] = 'is_active';

    $cnt = count($validation_array);
    $success_flag = false;
    for($i=0;$i<$cnt;$i++){
        if(!$utility_obj->validate_form_field($validation_array[$i],
        $data_array[$i],$column_array[$i]) && !$error_flag){
            $error_flag = true;
            $utility_obj->set_flash_message($_SESSION['errorMessage'],'error');
            break;
        }
    }

    if(!$error_flag){
        //save the data
        //check duplicate values
        if($texture_obj->check_duplicate_column('name',$_POST['name'],
        $pk_field)){
            $error_flag = true;
            $utility_obj->set_flash_message(t('This size name already exists'),
            'error');
        }

		$image_name='';
		if(!$error_flag){
			$targetPath = TEXTURE_IMAGE_PHYSICAL_PATH;
			if (!empty($_FILES['image_path']['name'])) {
				$tempFile = $_FILES['image_path']['tmp_name'];
				$tempName = $_FILES['image_path']['name'];
				$fileParts = pathinfo($_FILES['image_path']['name']);
				$image_name = 'texture'.time().'.'.$fileParts['extension'];
				$targetFile = rtrim($targetPath,'/') . '/' . $image_name;
				$fileTypes = array('jpg','jpeg','gif','png');
				if($_FILES['image_path']['name'] !=''
				 && $_FILES['image_path']['tmp_name'] == ''){
					$utility_obj->set_flash_message(t('Manimum file size exceeds'),
					'error');
				}
				else if($_FILES['image_path']['size']>IMAGE_MAX_UPLOAD_B){
					$utility_obj->set_flash_message(t('Maximum file size exceeds'),
					'error');
				}
				else if (in_array(strtolower($fileParts['extension']),$fileTypes)){
					$old_image = $_POST['old_image'];
					if(!empty($old_image) && file_exists(TEXTURE_IMAGE_PHYSICAL_PATH.'/'.$old_image)){
						@unlink(TEXTURE_IMAGE_PHYSICAL_PATH.'/'.$old_image);//delete previous logo
					}
					$utility_obj->make_thumbnail_image($tempFile,$targetFile,TEXTURE_IMAGE_WIDTH);
				} else {
					$utility_obj->set_flash_message(t('Invalid file type.'),
					'error');
				}

			} else {
				$image_name=$_POST['old_image'];
			}
		}

        if(!$error_flag){
            $data['pk']			= $pk_field;
            $data['name']		= $_POST['name'];
            $data['image_path']	= $image_name;
            $data['is_active']	= $_POST['is_active'];

            if($texture_obj->save_texture_data($data)){
                $success_flag = true;
                $utility_obj->set_flash_message(t('Data saved successfully'),
                'success');
                 $utility_obj->redirect_user($page_url.'&fancy=1');
                exit;
            }else{
                $error_flag = true;
                $utility_obj->set_flash_message(t('Data could not be saved'),
                'error');
            }
        }
    }
}

$no_records = false;
if($pk_field ==''){
    $no_records = true;
}else{
    //fetch records
    $result_set  = $texture_obj->load_texture_details($pk_field);
    $image_path = $result_set['image_path'];
    //fetch permission data
    $current_val_array = array();
    $permissionHTML =
    $menu_obj->build_permission_display_items(array(),$current_val_array);
}

require_once('./view/texture/TextureEdit.php');
?>