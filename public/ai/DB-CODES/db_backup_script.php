<?php
error_reporting(1);
ini_set('display_errors',1);
$sorageDir = '/var/www/html/Lisa_db_backup/';
$user = 'root';
$password = 'Q3tech123';
$server = '127.0.0.1';



function prepare_zip_archive($dir) {
	global $zipArchiveFiles;
	if ($handle = opendir($dir)) {
		while (false !== ($file = readdir($handle))) {
			if ($file != "." && $file != ".." && is_file($dir.'/'.$file)) {
				$zipArchiveFiles[] = $dir.'/'.$file;
			}
			else if ($file != "." && $file != ".." && is_dir($dir.'/'.$file)) {
				prepare_zip_archive($dir.'/'.$file);
			}
		}
		closedir($handle);
	}
   
}

function backupDatabase($dbArray,$port,$sorageDir){
global $user,$password,$server;

foreach($dbArray as $db){
 $todayFolder = $sorageDir.date('d.m.Y');
 if(!file_exists($todayFolder)){
	 mkdir($todayFolder);
 }
 $fileName = $todayFolder.'/'.$db.'.sql';
 
 $systemCall = 'mysqldump --host='.$server.' --user='.$user.' --password='.$password.' --port='.$port.' --protocol=TCP --routines '.$db.' > '.$fileName;

// echo $systemCall.'<br/>';
 exec($systemCall);

 if(extension_loaded('zip')){
     $zipFileName = $sorageDir.'/'.date('d.m.Y').'.zip';
	 global $zipArchiveFiles;
	 $zipArchiveFiles = array();
	 prepare_zip_archive($todayFolder);
	 $zip = new ZipArchive();
	 if ($zip->open($zipFileName, ZIPARCHIVE::CREATE)!==TRUE) {
        exit;
	 }
	 foreach ($zipArchiveFiles as $filename) {
	  $zip->addFile($filename,str_replace($todayFolder.'/', '', $filename));
	 }
	 $zip->close();

	 //delete the folder
	 $systemCall = 'rm -rf '.$todayFolder;
     exec($systemCall);
 }
}
}

//$dbArray = array('Lisa_cdb','Lisa_somaarth');

$instanceArray = array();

$instanceArray[0]['port'] = '3306';
$instanceArray[0]['folder'] = 'DEV';
$instanceArray[0]['name'] = 'Developer';

$instanceArray[1]['port'] = '3307';
$instanceArray[1]['folder'] = 'QA';
$instanceArray[1]['name'] = 'QA';

$instanceArray[2]['port'] = '3308';
$instanceArray[2]['folder'] = 'CLIENT';
$instanceArray[2]['name'] = 'Client';

foreach($instanceArray as $instance){

	/*************** FETCH ALL Lisa DATABASES IN EACH INSTANCE. ***********/
	$conn = mysql_connect($server.':'.$instance['port'],$user,$password);
	$query = 'SHOW DATABASES';
	$result = mysql_query($query,$conn);

	$dbArray = array();
	while($row = mysql_fetch_row($result)){
		if(stripos($row[0],'Lisa_')!== FALSE){
			$dbArray[] = $row[0];
		}
	}
	backupDatabase($dbArray,$instance['port'],$sorageDir.$instance['folder'].'/');

	echo 'Instance Name : <strong>'.$instance['name'].'</strong>&nbsp;&nbsp;Total "Lisa_" pattern database(s) dumped : <strong>'.count($dbArray).'</strong><br/>';

}
echo '<h3 align="center">DONE!</h3>';

?>