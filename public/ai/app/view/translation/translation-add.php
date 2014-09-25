<div class="my-form-divs translation-mgmt-box">
    <div class="box box-primary">
        <div class="box-header">
            <h3 class="box-title">
             <?php echo $utility_obj->getPageName($pageURL,2);?>
            </h3>
        </div>
        <?php echo form_open($pageURL, array('id' => 'translationFrm',
            'method' => 'post' ));?>
            <?php echo $utility_obj->get_flash_message();?>
            <div class="box-body">
                <div class="form-group">
                	<label for="source_label">
                	 <?php
                       echo t('Source Label');
                       echo mr();
                     ?>
                	 </label>
                    <?php echo form_input($data = array(
			              'name'        => 'source_label',
                          'value'   => isset($_POST['source_label']) ?
                           trim($_POST['source_label']) :
                           trim($resultSet['source_label']),
			              'id'          => 'source_label',
                          'tabindex'    => 1,
                          'maxlength'   => MAX_SOURCE_LABEL,
			              'placeholder' => t('Source Label'),
			              'class'       => 'form-control',
			            )
           			   );?>
                 </div>
                 <div class="form-group">
                  <label for="translated_label">
                   <?php
                    echo t('Translated Label');
                    echo mr();
                   ?>
                   </label>
                    <?php echo form_input($data = array(
                    'name'=> 'translated_label',
                    'value'   => isset($_POST['translated_label']) ?
                           trim($_POST['translated_label']) :
                           trim($resultSet['translated_label']),
                      'id'=> 'translated_label',
                       'tabindex'    => 2,
                       'maxlength'   => MAX_TRANSLATED_LABEL,
                       'placeholder' => t('Translated Label'),
                        'class'       => 'form-control',
                     )
                   );?>
                 </div>
            </div>
            <div class="box-footer">
                <button class="btn btn-primary" name="submit" value="submit"
                 type="submit" tabindex="5"><?php echo t('Submit');?>
                </button>
            </div>
        <?php echo form_close();?>
    </div>
</div>