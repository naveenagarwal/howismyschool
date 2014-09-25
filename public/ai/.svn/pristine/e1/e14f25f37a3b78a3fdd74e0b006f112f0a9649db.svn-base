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

function copy_data($file,$conn,$port){
   $server = $GLOBALS['server'];
   $user = $GLOBALS['user'];
   $pass = $GLOBALS['pass'];
   $info = pathinfo($file);
   $dbName = $info['filename'];
   //Use database
   $query  = 'USE DATABASE '.$dbName;
   mysqli_query($conn,$query);
   //import databases
   //$systemCall = 'mysql --host='.$server.'  --user='.$user.' --password='.$pass.' --port='.$port.' '.$dbName.' < '.$file.' > /dev/null 2>&1';
   $systemCall = 'mysql --host='.$server.'  --user='.$user.' --password='.$pass.' --port='.$port.' '.$dbName.' < "'.$file.'"';
   exec($systemCall);
}

$folderPath = 'F://xampp/htdocs/dde/install/sql/sql_data';
$server = '192.168.13.89';
$user = 'root';
$pass = 'Q3tech123';
$dbase = 'mysql';
$QA_port = 3307;


$qaConn = mysqli_connect($server, $user, $pass,$dbase,$QA_port);

$files = array();
scan_folder($folderPath,$files);

if(is_array($files) and count($files)){
	foreach ($files as $file) {
		copy_data($file,$qaConn,$QA_port);
	}
}

echo '<h2>Total '.count($files).' database(s) are copied to QA instance</h2>';
?>