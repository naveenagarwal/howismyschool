/**
 * This file will include all kind of JS Input form validations
 */

// Added by Q3-DB to validate first name
function validateUserName(id) {
	var uname = $.trim($('#' + id).val());
	if( uname.length == '0' ) {
		alert('Please enter your Username.');
		$('#' + id).focus();
		return false;
	}
	if( uname.length >= 1 ) {
		chk1 = "!#$%^&*|\~`{}[]:<>?/,";
		for( i=0; i!=uname.length; i++ ) {
			ch1 = uname.charAt(i);
			rtn1 = chk1.indexOf(ch1);
			if( rtn1 != -1 ) {
				alert('Please enter valid Username.');
				$('#' + id).focus();
				return false;
				break;
			}
		}
	}
	return true;
}

//Added by Q3-DB to validate password
function validatePassword(id) {
	var password = $.trim($('#' + id).val());
	if( password.length == '0' ) {
		alert('Please enter your Password.');
		$('#' + id).focus();
		return false;
	}
	return true;
}

//Added by Q3-DB to validate password and confirm password are same
function validateConfirmPassword(passwordId, confirmPasswordId) {
  var password = $.trim($('#' + passwordId).val());
  var confirmPassword = $.trim($('#' + confirmPasswordId).val());
  if( password != confirmPassword ) {
    alert('Please enter same Password.');
    $('#' + confirmPasswordId).focus();
    return false;
  }
  return true;
}

//Added by Q3-DB to validate full name
function validateFullname(id) {
	var fullname = $.trim($('#' + id).val());
	var pattern = new RegExp(/^[a-zA-Z' ]+$/);
	if( fullname.length == '0' ) {
		alert('Please enter your Full Name.');
		$('#' + id).focus();
		return false;
	}
	if( !pattern.test(fullname) ) {
		alert('Please enter valid Full Name.')
	}
	return true;
}

//Added by Q3-DB to validate email
function validateEmail(id) {
	var email = $.trim($('#' + id).val());
	var pattern = new RegExp(/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/);
	if( email.length == '0' ) {
		alert('Please enter your Email ID.');
		$('#' + id).focus();
		return false;
	}
	if( !pattern.test(email) ) {
		alert("Please enter valid Email ID as: yourname@yourdomain.com");
		$('#' + id).focus();
		return false;
	}
	return true;
}

// Added by Q3-DB to validate phone
function validateContactNo(id) {
  var phone = $.trim($('#' + id).val());
  if( phone.value != '' ) {
    var filter=/^([0-9]{10})$/;
    if (!filter.test(phone)) {
      alert("Please enter valid Contact Number.");
      $('#' + id).focus();
      return false;
    }
  }
  return true;
}