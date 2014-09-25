<?php
//add css & js for blueimg upload
add_blueimp_css_js();
?>
<div class="userlist">
	<div class="listheader">
		<?php display_search_box($search2); ?>
		<?php if($addAllowed){?>
		<div class="addnewrecord">
		<?php
		echo link_create(t('Add Translation'),
		array('href'=>$addPath.'&rurl='.$_SERVER['QUERY_STRING'],
 		'class'=>'btn btn-success','target' => '_blank'));
		?>
		</div>
		<?php }?>
		<?php if($uploadAllowed){?>
    <div class="addfileinput">
    <span class="btn btn-success fileinput-button">
      <span><?php echo t("Import Translation");?></span>
        <?php echo form_upload($data = array(
                  'name'=> 'translation_upload',
                  'value'   => '',
                  'id'          => 'translation_upload'
               )
             );?>
      </span>
      <br/><br/>
      <!-- The global progress bar -->
      <div id="blueimpProgress" class="progress">
        <div class="progress-bar progress-bar-success"></div>
      </div>
    </div>
    <?php }?>
	<div class="clr"></div>
	</div>
	<?php //Shoq Grid Here; ?>
	<?php echo $utility_obj->get_flash_message();?>
	<?php echo $tableHTML; ?>
</div>
<script type="text/javascript">
$(document).ready(function() {
 $('#searchbtn').click(function(){
 	searchRoles();
 });
 $("#searchbox").keyup(function(event){
       if(event.keyCode == 13){
           //searchRoles();
       }
 });
});
function searchRoles(){
	includeSearchParam = true;
	<?php echo $tableId;?>.fnReloadAjax("<?php echo $recordURL?>");
	includeSearchParam = false;
}
function deleteConfirm(id,element){
	deletableRowElement = element;
	deleteRecord(id,'<?php echo $tableId;?>',
	'<?php echo $deleteURL?>','<?php echo DELETE_WARNING_MSG; ?>');
}

$(function() {
    blueimpFileUpload('translation_upload',
    '<?php echo URL.$uploadTranslationPath;?>&ajax=1',
    'blueimpProgress',handleTranslationUpload);
});
function handleTranslationUpload(data){
  <?php echo $tableId;?>.fnReloadAjax("<?php echo $recordURL?>");
}
</script>