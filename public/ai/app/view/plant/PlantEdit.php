<?php
if($noRecords){
    ?>
<div class="errordiv">
<?php echo t("No records found");?>
</div>
<?php
return;
}
?>
<div class="my-form-divs size-mgmt-box-edit">
  <div class="box box-primary">
    <div class="box-header">
      <h3 class="box-title">
      <?php echo $utility_obj->get_page_name($page_url,2);?>
      </h3>
    </div>
    <?php echo form_open_multipart($page_url, array('id' => 'plantFrm',
            'method' => 'post' ));?>
    <?php echo $utility_obj->get_flash_message();?>

    <?php //Size Edit Section ?>
    <div class="col-md-6">
      <div class="box-body">
        <div class="form-group">
          <label for="name"> <?php
          echo t('Plant Name');
          echo mr();
          ?> </label>
          <?php echo form_input($data = array(
					'name'        => 'name',
					'value'   => isset($_POST['name']) ?
					trim($_POST['name']) : trim($result_set['name']),
					'id'          => 'name',
					'tabindex'    => 1,
					'maxlength'   => 100,
					'placeholder' => t('Plant Name'),
					'class'       => 'form-control',
					'required'    => 'required',
          )
          );?>
        </div>
        <div class="form-group">
			<label for="manufacturer_id">
			 <?php
			echo t('Manufacturer');
			echo mr();
		   ?>
			</label>
			<?php echo form_dropdown(
				  'manufacturer_id',
				  $manufacturers_array,
				  $selected_manufacturer,
				  'id = "manufacturer_id" tabindex ="2" class = "form-control" required'
			   );?>
		 </div>
		 <div class="form-group">
          <label for="image_path"> <?php
          echo t('Image');
          ?> </label>
			<div id="siteLogoContainer">
			<?php
				if(!empty($image_path) &&
				  file_exists(PLANT_IMAGE_PHYSICAL_PATH.'/'.$image_path)){
					?>
					<img src="<?php echo PLANT_IMAGE_ROOT_PATH?>/<?php echo $image_path;?>"
					 title="<?php echo t('Plant image');?>" />

				  <?php
				}
			   ?>
			   <input type="hidden" name="old_image" id="old_image" value="<?php echo $image_path; ?>" />
			</div>
			<span class="btn btn-primary fileinput-button">
				<span><?php
				 echo t('Select & Upload File');?>
				 </span>
					<?php echo form_upload($data = array(
						'name'=> 'image_path',
						'value'   => '',
						'id'          => 'image_path',
						'tabindex'    => 2,
						'placeholder' => t('Plant image')
				   )
				);?>
			</span>
        </div>
		<div class="form-group">
			<label for="plant_longitude">
			 <?php
			echo t('Plant Longitude');
		   ?>
			 </label>
			<?php echo form_input($data = array(
				  'name'		=> 'plant_longitude',
				  'value'		=> isset($_POST['plant_longitude']) ?
				   trim($_POST['plant_longitude']) :
				   trim($result_set['plant_longitude']),
				  'id'          => 'plant_longitude',
				  'tabindex'    => 3,
				  'maxlength'   => 20,
				  'placeholder' => t('Plant Longitude'),
				  'class'       => 'form-control',
				)
			   );?>
		 </div>
		 <div class="form-group">
			<label for="plant_latitude">
			 <?php
			echo t('Plant Latitude');
		   ?>
			 </label>
			<?php echo form_input($data = array(
				  'name'        => 'plant_latitude',
				  'value'		=> isset($_POST['plant_latitude']) ?
				   trim($_POST['plant_latitude']) :
				   trim($result_set['plant_latitude']),
				  'id'          => 'plant_latitude',
				  'tabindex'    => 3,
				  'maxlength'   => 100,
				  'placeholder' => t('Plant Latitude'),
				  'class'       => 'form-control',
				)
			   );?>
		 </div>
        <?php
        $isActive = isset($_POST['is_active']) ? trim($_POST['is_active'])
        : $result_set['is_active'];
        $c1 = $c2 = FALSE;
        $isActive == 1 ? $c1 = true : $c2 = true;
        $data = array(
                      'name'	=> 'is_active',
                      'id'		=> 'is_active',
                      'value'	=> '1',
                      'checked' => $c1,
                      'class'	=> 'form_control',
                      'tabindex'=> 3
        );
        ?>
        <div class="form-group radioInline">
          <label> <?php
          echo t('Active');
          echo mr();
          ?> </label>
          <div class="radio">
            <label> <?php echo form_radio($data);?> &nbsp;
              <?php echo t('Yes');?>
            </label>
          </div>
          <div class="radio">
            <label> <?php
            $data['value'] = 0;
            $data['checked'] = $c2;
            $data['tabindex'] = 4;
            echo form_radio($data);?> &nbsp;
            <?php echo t('No');?> </label>
          </div>
          <div class="cb"></div>
        </div>
      </div>
      <button class="btn btn-primary save-btn" name="submit" value="submit"
        type="submit" tabindex="5">
        <?php echo t('Save');?>
      </button>
      <button class="btn btn-primary" name="clsSubmit" value="clsSubmit"
      type="button" onclick="closeFancyBoxParent()" tabindex="6">
        <?php echo t('Close');?>
      </button>
    </div>
    <?php echo form_close();?>
  </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
  var maxHeight = 220;
  $(".slimDiv").each(function(){
    if($(this).height() > maxHeight){
      $(this).slimscroll({
        height: maxHeight+"px",
        alwaysVisible: true,
        size: '10px',
    	railVisible: true,
    	railColor: '#222',
    	railOpacity: 0.3,
    	wheelStep: 10,
    	allowPageScroll: false,
    	disableFadeOut: true
      });
      $(this).css('height',parseInt(maxHeight-20));
    }
  });
  if($('#menuAccordion')){
     $( "#menuAccordion" ).accordion({
       heightStyle: "content",//no auto height
       collapsible : true
     });
  }
});
</script>
