<div class="my-form-divs role-mgmt-box">
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
                    echo mr();
                   ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'        => 'user_name',
                          'value'   => isset($_POST['user_name']) ? 
                           trim($_POST['user_name']) :
                           trim($resultSet['user_name']),  
			              'id'          => 'user_name',
                          'tabindex'    => 1,
                          'maxlength'   => 20,   			              
			              'placeholder' => t('Username'),
			              'class'       => 'form-control',
			            )
           			   );?>
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
                           '',
                          'id'          => 'user_password',
                          'tabindex'    => 2,
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
                           '',
                           'id'          => 'confirm_password',
                           'tabindex'    => 3,
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
                          'tabindex'    => 4,
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
                          'tabindex'    => 5,
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
                    echo mr();
                    ?>
                	 </label>
                    <?php echo form_dropdown(
			              'role_id',
                          $rolesArray,
                          $selectedRole,
			              'id = "role_id" tabindex ="6" class = "form-control"'
           			   );?>
                 </div>
                 <?php
                 $isActive = isset($_POST['is_active']) ? trim($_POST['is_active']) : 1;
                 $c1 = $c2 = FALSE;
                 $isActive == 1 ? $c1 = true : $c2 = true;
                 $data = array(
                    'name' => 'is_active',
                    'id' => 'is_active',
                    'value' => '1',
                    'checked' => $c1,
                    'class' => 'form_control',
                    'tabindex' => 7
                 ); 
                 ?>
                 <div class="form-group radioInline">
                	<label>
                	 <?php 
                    echo t('Status');
                    echo mr();
                   ?>
                	</label>
                	<div class="radio">
                    	<label>
                            <?php echo form_radio($data);?>
                            &nbsp;<?php echo t('Active');?>
               			</label>
           			</div>
           			<div class="radio">
                    	<label>
                            <?php
                            $data['value'] = 0;
                            $data['checked'] = $c2;
                            $data['tabindex'] = 8;  
                            echo form_radio($data);?>
                            &nbsp;<?php echo t('Inactive');?>
               			</label>
           			</div>
           			<div class="cb"></div>
                 </div>
            </div>
            <div class="box-footer">
                <button class="btn btn-primary submitBtnIcon" name="submit" value="submit" 
                 type="submit" tabindex="9"><?php echo t('Submit');?>
                </button>
                 <button class="btn btn-primary" name="clsSubmit" 
                value="clsSubmit" type="button" onclick="closeFancyBoxParent()"
                tabindex="10"><?php echo t('Close');?>
                </button>
            </div>
        <?php echo form_close();?>
    </div>
</div>