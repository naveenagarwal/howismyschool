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
<div class="my-form-divs role-mgmt-box-edit">
  <div class="box box-primary">
    <div class="box-header">
      <h3 class="box-title">
      <?php echo $utility_obj->get_page_name($pageURL,2);?>
      </h3>
    </div>
    <?php echo form_open_multipart($pageURL, array('id' => 'userFrm',
            'method' => 'post' ));?>
    <?php echo $utility_obj->get_flash_message();?>

    <?php //Role Edit Section ?>
    <div class="col-md-6">
      <div class="box-body">
        <div class="form-group">
          <label for="role_name"> <?php 
          echo t('Role Name');
          echo mr();
          ?> </label>
          <?php echo form_input($data = array(
                      'name'        => 'role_name',
                            'value'   => isset($_POST['role_name']) ? 
          trim($_POST['role_name']) :
          trim($resultSet['role_name']),
                      'id'          => 'role_name',
                            'tabindex'    => 1,
                            'maxlength'   => 50,                       
                      'placeholder' => t('Role Name'),
                      'class'       => 'form-control',
          )
          );?>
        </div>
        <div class="form-group">
          <label for="role_code"> <?php 
          echo t('Role Code');
          echo mr();
          ?> </label>
          <?php echo form_input($data = array(
                      'name'        => 'role_code',
                            'value'   => isset($_POST['role_code']) ? 
          trim($_POST['role_code']) :
          trim($resultSet['role_code']),
                      'id'          => 'role_code',
                            'tabindex'    => 2,
                            'maxlength'   => 20,                      
                      'placeholder' => t('Role Code'),
                      'class'       => 'form-control',
          )
          );?>
        </div>
        <?php
        $isActive = isset($_POST['is_active']) ? trim($_POST['is_active'])
        : $resultSet['is_active'];
        $c1 = $c2 = FALSE;
        $isActive == 1 ? $c1 = true : $c2 = true;
        $data = array(
                      'name' => 'is_active',
                      'id' => 'is_active',
                      'value' => '1',
                      'checked' => $c1,
                      'class' => 'form_control',
                      'tabindex' => 3
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
      
    </div>

    <?php //Permission Edit Section ?>
    <div class="col-md-6">
      <div class="box-body">
      <?php
      echo $permissionHTML;
      ?>
      </div>
    </div>
    <div class="bottomBtns col-md-6">
    <button class="btn btn-primary save-permission"
      name="submit-permission" value="submit-permission" type="submit"
      tabindex="6">
      <?php echo t('Assign Permission');?>
    </button>
     <button class="btn btn-primary save-permission" name="clsSubmit" 
                value="clsSubmit" type="button" onclick="closeFancyBoxParent()"
                tabindex="7"><?php echo t('Close');?>
                </button>
     </div>
     <div class="cb"></div>
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
