<div class="userlist">
	<div class="listheader">
		<?php display_search_box($search2); ?>
		<?php if($addAllowed){?>
		<div class="addnewrecord">
		<?php
		echo link_create(t('Add New User'),
		array('href'=>'user-roles/users/user-add&rurl='.$_SERVER['QUERY_STRING'],
 		'class'=>'btn btn-success addCell'));
		?>
		</div>
		<?php }?>
		<div class="clr"></div>
	</div>
	<?php //Shoq Grid Here; ?>
	<?php echo $tableHTML; ?>
</div>
<script type="text/javascript">
$(document).ready(function() {
 $('#searchbtn').click(function(){
 	searchRoles();
 });
 $("#searchbox").keyup(function(event){
       if(event.keyCode == 13){
          // searchRoles();
       }
 });
 addFancyBoxEdit("addCell",1,500,"100%");
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
</script>