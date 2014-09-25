<?php
ini_set('MEMORY_LIMIT','2048M');
error_reporting(0);
require_once '../class/excel_reader2.php';
$data = new Spreadsheet_Excel_Reader("translation.xls");


//echo $data->dump(true,true); 
$cnt = count($data->sheets[0]['cells']);
$obj = $data->sheets[0]['cells'];

$translation = '';
for($i=2;$i<$cnt;$i++){
	if($obj[$i][3]!=''){
		$translation .= 'msgid "'.$obj[$i][2].'"'.PHP_EOL;
		$translation .= 'msgstr "'.$obj[$i][3].'"'.PHP_EOL.PHP_EOL;
	}
}

if($translation!=''){
 $fileName = 'translation.txt';
 $fp = fopen($fileName,'w');
 fwrite($fp,$translation);
 fclose($fp);
 echo '<h3>Translation File Created</h3>';
}else{
	echo '<h3>Translation File Not Created</h3>';
}
?>