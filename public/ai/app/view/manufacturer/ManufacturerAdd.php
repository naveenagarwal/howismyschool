<div class="my-form-divs size-mgmt-box">
    <div class="box box-primary">
        <div class="box-header">
            <h3 class="box-title">
             <?php echo $utility_obj->get_page_name($page_url,2);?>
            </h3>
        </div>
        <?php echo form_open_multipart($page_url, array('id' => 'manufacturerFrm',
            'method' => 'post' ));?>
            <?php echo $utility_obj->get_flash_message();?>
            <div class="box-body">
                <div class="form-group">
                	<label for="company">
                	 <?php
                    echo t('Company Name');
                    echo mr();
                   ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'        => 'company',
                          'value'   => isset($_POST['company']) ?
                           trim($_POST['company']) :
                           trim($result_set['company']),
			              'id'          => 'company',
                          'tabindex'    => 1,
                          'maxlength'   => 100,
			              'placeholder' => t('Company Name'),
			              'class'       => 'form-control',
						  'required'    => 'required',
			            )
           			   );?>
                 </div>

                <div class="form-group">
                    <label for="type">
                        <?php
                            echo t('Manufacturer Type');
                            echo mr();
                        ?>
                    </label>
                    <?php echo form_dropdown(
                        'type',
                        $types_array,
                        $selected_type,
                        'id = "type" tabindex ="2" class = "form-control" required="required"'
                   );?>
                </div>

				 <div class="form-group">
                	<label for="name">
                	 <?php
                    echo t('Name');
                    echo mr();
                   ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'        => 'name',
                          'value'   => isset($_POST['name']) ?
                           trim($_POST['name']) :
                           trim($result_set['name']),
			              'id'          => 'name',
                          'tabindex'    => 2,
                          'maxlength'   => 50,
			              'placeholder' => t('Name'),
			              'class'       => 'form-control',
						  'required'    => 'required',
			            )
           			   );?>
                 </div>
				 <div class="form-group">
                	<label for="address">
                	 <?php
                    echo t('Address');
                   ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'		=> 'address',
                          'value'		=> isset($_POST['address']) ?
                           trim($_POST['address']) :
                           trim($result_set['address']),
			              'id'          => 'address',
                          'tabindex'    => 3,
                          'maxlength'   => 255,
			              'placeholder' => t('Address'),
			              'class'       => 'form-control',
			            )
           			   );?>
                 </div>
				 <div class="form-group">
                	<label for="contact_number">
                	 <?php
                    echo t('Contact Number');
					echo mr();
                   ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'        => 'contact_number',
                          'value'		=> isset($_POST['contact_number']) ?
                           trim($_POST['contact_number']) :
                           trim($result_set['contact_number']),
			              'id'          => 'contact_number',
                          'tabindex'    => 4,
                          'maxlength'   => 50,
			              'placeholder' => t('Contact Number'),
			              'class'       => 'form-control',
                    'required'    => 'required',
			            )
           			   );?>
                 </div>
				 <div class="form-group">
                	<label for="email_id">
                	 <?php
                    echo t('Email');
					echo mr();
                   ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'        => 'email_id',
                          'value'		=> isset($_POST['email_id']) ?
                           trim($_POST['email_id']) :
                           trim($result_set['email_id']),
			              'id'          => 'email_id',
                          'tabindex'    => 5,
                          'maxlength'   => 50,
			              'placeholder' => t('Email'),
			              'class'       => 'form-control',
			            )
           			   );?>
                 </div>
				 <div class="form-group">
                	<label for="image_path">
                	 <?php
                    echo t('Image');
                   ?>
                	</label>
                    <span class="btn btn-primary fileinput-button">
                        <span><?php
                         echo t('Select & Upload File');?>
                         </span>
							<?php echo form_upload($data = array(
								'name'=> 'image_path',
								'value'   => '',
								'id'          => 'image_path',
								'tabindex'    => 6,
								'placeholder' => t('Manufacturer image')
						   )
						);?>
					</span>
                 </div>
                 <?php
                 $is_active = isset($_POST['is_active']) ? trim($_POST['is_active']) : 1;
                 $c1 = $c2 = FALSE;
                 $is_active == 1 ? $c1 = true : $c2 = true;
                 $data = array(
                    'name' => 'is_active',
                    'id' => 'is_active',
                    'value' => '1',
                    'checked' => $c1,
                    'class' => 'form_control',
                    'tabindex' => 5
                 );
                 ?>
                 <div class="form-group radioInline">
                	<label>
                	 <?php
                    echo t('Active');
                    echo mr();
                   ?>
                	</label>
                	<div class="radio">
                    	<label>
                            <?php echo form_radio($data);?>
                            &nbsp;<?php echo t('Yes');?>
               			</label>
           			</div>
           			<div class="radio">
                    	<label>
                            <?php
                            $data['value'] = 0;
                            $data['checked'] = $c2;
                            $data['tabindex'] = 4;
                            echo form_radio($data);?>
                            &nbsp;<?php echo t('No');?>
               			</label>
           			</div>
           			<div class="cb"></div>
                 </div>
            </div>
            <div class="box-footer">
                <button class="btn btn-primary" name="submit" value="submit"
                 type="submit" tabindex="5"><?php echo t('Save');?>
                </button>
                 <button class="btn btn-primary" name="clsSubmit"
                value="clsSubmit" type="button" onclick="closeFancyBoxParent()"
                tabindex="6"><?php echo t('Close');?>
                </button>
            </div>
        <?php echo form_close();?>
    </div>
</div>