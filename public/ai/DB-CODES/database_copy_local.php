<?php
/*THIS FILE IS USED TO COPY AND DEPLOY DATABASES
FROMS DEV INSTANCE TO QA AND CLIENT INSTANCE
NOTE: BE CAREFULL ABOUT THIS FILE AS IT WILL WIPE
OUT ALL DATABASES IN TARGET INSTANCE*/

set_time_limit(0);
function scan_folder($dir,&$files) {
        if ($handle = opendir($dir)) {
            while (false !== ($file = readdir($handle))) {
                if ($file != "." && $file != ".." && $file != ".svn" 
                	&& is_file($dir.'/'.$file)) {
					$info = pathinfo($dir.'/'.$file);
					if(isset($info['extension']) 
						&& $info['extension'] == 'sql'){
                     $files[] = $dir.'/'.$file;
					}
                }
            }
            closedir($handle);
        }
}

function copy_database($file,$conn,$port){
   $server = $GLOBALS['server'];
   $user = $GLOBALS['user'];
   $pass = $GLOBALS['pass'];
   $info = pathinfo($file);
   $dbName = $info['filename'].'_test';
   //drop existing database
   $query  = 'DROP DATABASE IF EXISTS '.$dbName;
   mysqli_query($conn,$query);
   //create database
   $query  = 'CREATE DATABASE '.$dbName;
   mysqli_query($conn,$query);
   //import databases
   $systemCall = 'mysql --host='.$server.'  --user='.$user.' --password='.$pass.' --port='.$port.' '.$dbName.' < "'.$file.'"';
   //echo $systemCall.'<br/>';
   exec($systemCall);
}

$folderPath = 'F://Lisa Docs/database/QA/19.03.2014';
$server = '127.0.0.1';
$user = 'root';
$pass = '';
$dbase = 'mysql';
$QA_port = 3306;
$CLIENT_port = 3306;

$qaConn = mysqli_connect($server, $user, $pass,$dbase,$QA_port);
//$clientConn = mysqli_connect($server, $user, $pass,$dbase,$CLIENT_port);

$files = array();
scan_folder($folderPath,$files);

if(is_array($files) and count($files)){
	foreach ($files as $file) {
		copy_database($file,$clientConn,$CLIENT_port);
		//copy_database($file,$qaConn);
	}
}

echo '<h2>Total '.count($files).' database(s) 
are copied to QA and Client instance</h2>';
?>