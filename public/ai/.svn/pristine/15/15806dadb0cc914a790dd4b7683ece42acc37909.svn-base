<?php
if($noRecords){
?>
<div class="errordiv"><?php echo t("No records found");?></div>
<?php
 return;
}
?>
<div class="my-form-divs profile-mgmt-box">
    <div class="box box-primary">
        <div class="box-header">
            <h3 class="box-title">
             <?php echo $utility_obj->get_page_name($pageURL,2);?>
            </h3>
        </div>
        <?php echo form_open_multipart($pageURL, array('id' => 'userFrm', 
            'method' => 'post' ));?>
            <?php echo $utility_obj->get_flash_message();?>
            <div class="box-body">
                <div class="form-group">
                	<label for="user_name">
                	 <?php 
                      echo t('Username');
                     ?>
                	 </label>&nbsp;&nbsp;:&nbsp;
                	 <?php
                	  echo $resultSet['user_name'];
                	 ?>
                    <?php echo form_hidden('user_name',
                    trim($resultSet['user_name']));?>
                 </div>
                 <div class="form-group">
                	<label for="user_password">
                	 <?php 
                     echo t('Password');
                     echo mr();
                   ?>
                	 </label>
                    <?php echo form_password($data = array(
			              'name'        => 'user_password',
			              'value'   => isset($_POST['user_password']) ? 
                           trim($_POST['user_password']) :
                           '*****',
                          'id'          => 'user_password',
                          'tabindex'    => 1,
                          'maxlength'   => 10,
			              'placeholder' => t('Password'),
                          'autocomplete' => 'off',
			              'class'       => 'form-control',
			            )
           			   );?>
                 </div>
                 <div class="form-group">
                	<label for="confirm_password">
                	 <?php 
                     echo t('Confirm Password');
                     echo mr();
                   ?>
                	 </label>
                    <?php echo form_password($data = array(
			               'name'        => 'confirm_password',
			               'value'   => isset($_POST['confirm_password']) ? 
                           trim($_POST['confirm_password']) :
                           '*****',
                           'id'          => 'confirm_password',
                           'tabindex'    => 2,
                           'maxlength'   => 10,
			               'placeholder' => t('Confirm Password'),
                           'autocomplete' => 'off',
			               'class'       => 'form-control',
			            )
           			   );?>
                 </div>
                 <div class="form-group">
                	<label for="full_name">
                	 <?php 
                    echo t('Full Name');
                    echo mr();
                   ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'        => 'full_name',
			              'value'   => isset($_POST['full_name']) ? 
                           trim($_POST['full_name']) :
                           trim($resultSet['full_name']),
                          'id'          => 'full_name',
                          'tabindex'    => 3,
                          'maxlength'   => 200, 
			              'placeholder' => t('Full Name'),
			              'class'       => 'form-control',
			            )
           			   );?>
                 </div>
                 <div class="form-group">
                	<label for="email_id">
                	 <?php 
                    echo t('Email ID');
                    echo mr();
                   ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'        => 'email_id',
			              'value'   => isset($_POST['email_id']) ? 
                           trim($_POST['email_id']) :
                           trim($resultSet['email_id']),
                          'id'          => 'email_id',
                          'tabindex'    => 4,
                          'maxlength'   => 255, 
			              'placeholder' => t('Email ID'),
			              'class'       => 'form-control',
			            )
           			   );?>
                 </div>
                 <div class="form-group">
                	<label for="role_id">
                	 <?php 
                      echo t('Role');
                     ?>
                	 </label>
                	 &nbsp;&nbsp;:&nbsp;
                	 <?php
                	  echo $resultSet['UTypeNameLabel'];
                	 ?>
       			     <?php echo form_hidden('role_id',$selectedRole);?>
                 </div>
            </div>
            <div class="box-footer">
                <button class="btn btn-primary" name="submit" value="submit" 
                 type="submit" tabindex="7"><?php echo t('Submit');?>
                </button>
            </div>
        <?php echo form_close();?>
    </div>
</div>