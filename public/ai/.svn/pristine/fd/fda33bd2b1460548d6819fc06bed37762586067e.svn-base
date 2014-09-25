<?php

////////////CHECK HACKERSAFE FOR CSS//////////////////
function CheckXSS($xssarr)
{
	foreach($xssarr as $val)
	{
		if(is_array($val))
		{
			CheckXSS($val);
		}
		else
		{

			if(substr_count(strtolower($val),"%3cscript") > 0 ||
			substr_count(strtolower($val),"<script") > 0 ||
			substr_count(strtolower($val),"&ltscript") > 0 ||
			substr_count(strtolower($val),"%3ciframe") > 0 ||
			substr_count(strtolower($val),"<iframe") > 0 ||
			substr_count(strtolower($val),"&ltiframe") > 0)
			{

				print "<font color='#ff0000' size='4'>Sorry ! Please contact Administrator.</font>";
				die;
			}
			if(substr_count(strtolower($val),"%3cstyle") > 0 ||
			substr_count(strtolower($val),"<style") > 0 ||
			substr_count(strtolower($val),"&ltstyle") > 0)
			{
				if(!strpos($_SERVER['PHP_SELF'],'panel') &&
				!strpos($_SERVER['PHP_SELF'],'adminpanel') &&
				!strpos($_SERVER['PHP_SELF'],'adminwork') &&
				!strpos($_SERVER['PHP_SELF'],'admin'))
				{
					print "<font color='#ff0000' size='4'>Sorry ! Please contact Administrator.</font>";
					die;
				}
			}
		}

	}
}
CheckXSS($_REQUEST);
////////////CHECK HACKERSAFE FOR CSS//////////////////



?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="shortcut icon" href="./favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>LISA</title>

<meta name="title" content="#####" />
<meta name="author" content="####" />
<meta name="description" content="#####" />

<meta name="keywords" content="#####" />
<meta name="robots" content="index, follow" />


</head>

<body>
<script>
    window.location.href='./login';
  </script>

</body>

</html>
