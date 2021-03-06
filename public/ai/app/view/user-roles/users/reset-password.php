<div class="login-content-box">
  <div class="welcome-text-box">
      <div class="welcome-heading"><?php echo t('Welcome to');?>
        <?php echo SITE_NAME;?></div>
        <div class="welcome-text">
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
          eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
          ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
          aliquip ex ea commodo consequat. Duis aute irure dolor in
          reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
          pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
          culpa qui officia deserunt mollit anim id est laborum.
        </div>
        <div class="text-seperator"></div>
        <div class="access-warning">
          <div class="warning-heading"><?php echo t('Unauthorized Access Warning');?></div>
            <ul>
              <li><?php echo t('Access to this computer is prohibited
				unless authorized.');?></li>
                <li><?php echo t('Accessing programs or data unrelated
				to your job is prohibited.');?></li>
            </ul>
        </div>
    </div>
    <div class="login-box">
      <div class="login-form reset-form">
          <div class="sign-in"><?php echo t('Reset Password'); ?></div>
          <?php
            echo $utility_obj->getHiddenFields('e', $_REQUEST['e']);
			echo $utility_obj->get_flash_message();
		   ?>
          <?php echo form_open(URL . ''.RESET_PASSWORD_LINK.'&e='.$_REQUEST['e'],
          array('id' => 'resetform', 'method' => 'post' ))?>
            <div class="forgot-form-row">
              <table width="100%" cellspacing="0" cellpadding="0" border="0">
            		<tbody>
            			<tr>
            				<td><label><?php echo t('New password');?></label></td>
            				<td>:</td>
            				<td><?php echo form_password($data = array(
	              'name'        => 'newpassword',
	              'id'          => 'newpassword',
	              'value'   => $newpassword
	            )
   			   );?></td>
            			</tr>
            			<tr>
            				<td><label><?php echo t('Confirm new password');?></label></td>
            				<td>:</td>
            				<td><?php echo form_password($data = array(
	              'name'        => 'confnewpassword',
	              'id'          => 'confnewpassword',
	              'value'   => $confnewpassword
	            )
   			   );?></td>
            			</tr>
            			<tr>
            				<td colspan="3"><button type="submit" class="login-btn">
             <?php echo t('Reset Password');?></button></td>
            			</tr>
            		</tbody>
            	</table>
            </div>
            <?php echo form_close();?>
        </div>
    </div>
    <div class="cb"></div>
</div>