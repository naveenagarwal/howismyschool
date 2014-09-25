<?php 
//add css & js for blueimg upload
add_blueimp_css_js(); 
?>
<div class="my-form-divs siteconfig-mgmt-box">
    <div class="box box-primary">
        <div class="box-header">
            <h3 class="box-title">
             <?php echo $utility_obj->get_page_name($pageURL,2);?>
            </h3>
        </div>
        <?php echo form_open_multipart($pageURL, array('id' => 'configFrm', 
            'method' => 'post' ));?>
            <?php echo $utility_obj->get_flash_message();?>
            <div class="box-body">
                <div class="form-group">
                  <label for="site_name">
                   <?php 
                    echo t('Site Name');
                    echo mr();
                    ?>
                   </label>
                    <?php echo form_input($data = array(
                    'name'        => 'site_name',
                          'value'   => isset($_POST['site_name']) ? 
                           trim($_POST['site_name']) :
                           trim($resultSet['site_name']),  
                         'id'          => 'site_name',
                          'tabindex'    => 1,
                          'maxlength'   => 255,                      
                    'placeholder' => t('Site Name'),
                    'class'       => 'form-control',
                  )
                   );?>
                 </div>
                 <div class="form-group">
                  <label for="site_email">
                   <?php 
                    echo t('Site Email');
                    echo mr();
                   ?>
                   </label>
                    <?php echo form_input($data = array(
                    'name'        => 'site_email',
                          'value'   => isset($_POST['site_email']) ? 
                           trim($_POST['site_email']) :
                           trim($resultSet['site_email']),  
                         'id'          => 'site_email',
                          'tabindex'    => 2,
                          'maxlength'   => 100,                      
                    'placeholder' => t('Site Email'),
                    'class'       => 'form-control',
                  )
                   );?>
                 </div>
                 <div class="form-group">
                    <div id="siteLogoContainer">
                      <?php                     
                        if(!empty($siteLogo) && 
                          file_exists(IMAGE_PHYSICAL_PATH.'/'.$siteLogo)){
                            ?>
                            <img src="<?php echo IMAGE_URL?>/<?php echo $siteLogo;?>"
                             title="<?php echo t('Site Logo');?>" />
                             
                          <?php
                        }
                       ?>
                    </div>
                    <label for="site_logo_path">
                     <?php 
                      echo t('Site Logo');
                     ?>
                     </label>
                     <br/>
                     <span class="btn btn-primary fileinput-button">
                        <span><?php 
                         echo t('Select & Upload File');?>
                         </span>
                        <?php echo form_upload($data = array(
                            'name'=> 'site_logo_path',
                            'value'   => '',  
                            'id'          => 'site_logo_path',
                            'tabindex'    => 3,
                            'placeholder' => t('Sitelogo')
                       )
                     );?>
                   </span>
                   <?php 
                  if(!empty($siteLogo) && 
                          file_exists(IMAGE_PHYSICAL_PATH.'/'.$siteLogo)){
                            ?>
                            <a id="removeImg" onclick="javascript:removeLogoConfirm();" 
                            href="javascript:void(0);" class="btn btn-primary">
                            <?php echo t('Remove Site Logo');?>
                            </a>
                            <?php }?>
                   <br/><br/>
                  <!-- The global progress bar -->
                  <div id="blueimpProgress" class="progress">
                    <div class="progress-bar progress-bar-success"></div>
                  </div>
                  
                  <?php echo '<strong>'.t('Note').' :</strong> ';
                   echo t('Allowed image types are').'&nbsp; jpg , gif '.t('&').' png';
                   echo '&nbsp;'.t('and maximum allowed file size is').
                   '&nbsp;'.IMAGE_MAX_UPLOAD_MB.'&nbsp;'.t('MB');
                  ?>
                 </div>
            <div class="box-footer">
                <button class="btn btn-primary" name="submit" value="submit" 
                 type="submit" tabindex="3"><?php echo t('Save');?>
                </button>
            </div>
        <?php echo form_close();?>
    </div>
</div>
</div>
<script type="text/javascript">
$(function() {
    blueimpFileUpload('site_logo_path',
    '<?php echo URL;?>configuration/upload-image&ajax=1',
    'blueimpProgress',updateImagePath,1);
});

function updateImagePath(ret){
  var html =  '<p>'+
	  '<a id="removeImg" onclick="javascript:removeLogoConfirm();" href="javascript:void(0);" class="btn btn-success">'+
      '<?php echo t("Remove Site Logo");?></a></p>';
  var img 
  = '<img src="'+ret.logo_path+'" title="<?php echo t("Site Logo");?>" />';
  $('#siteLogoContainer').html(html+img);
  window.location.reload();
}
function removeLogoConfirm(){
	confirmBox("<?php echo t('Do you want to delete site logo ?');?>",'removeLogo()');
}
function removeLogo(){
	closeConfirmBox();
	$.ajax({
        type: "POST",
        dataType: "json",
        async : false,
        url: jsURL+'<?php echo UNLINK_LOGO_URL;?>&ajax=1',        
        success: function (response) {
        	if(response.CustomError){
              alertBox(response.ErrorDesc,'',1);
			  return;
			}else{
				$('#siteLogoContainer').html('');
				$('#removeImg').hide();
				alertBox(response.message,'window.location.reload()');
			}
        }
    });
}
</script>