$(document).ready(function() {
	$("input[type='checkbox'], input[type='radio']").not('.dynFilter').iCheck({
	        checkboxClass: 'icheckbox_minimal',
	        radioClass: 'iradio_minimal',
	        inheritID : true
	});
});