<?php
function scan_folders($dir,&$zipArchiveFiles) {
        if ($handle = opendir($dir)) {
            while (false !== ($file = readdir($handle))) {
                if ($file != "." && $file != ".." && $file != ".svn" && is_file($dir.'/'.$file)) {
					$info = pathinfo($dir.'/'.$file);
					if(isset($info['extension']) && $info['extension'] == 'php'){
                     $zipArchiveFiles[] = $dir.'/'.$file;
					}
                }
                else if ($file != "." && $file != ".." && $file != ".svn" && is_dir($dir.'/'.$file)) {
                    scan_folders($dir.'/'.$file,$zipArchiveFiles);
                }
            }
            closedir($handle);
        }
}

function get_t_strings($str,&$output){
    $str = preg_replace('/\s+/', ' ', trim($str));
    //echo $str;die;
	//getting values within single quotes
    preg_match_all('/t\(\'([A-Za-z0-9.\' \']+?)\)/', $str, $m);
	if(is_array($m) and count($m)){
		$m2 = $m[1];
		foreach($m2 as $value){
			if(strpos($value,"t('") === FALSE and strpos($value,'t("') === FALSE ){
				$value = str_replace("('","",$value);
				$value = str_replace("')","",$value);
				$value = str_replace('("',"",$value);
				$value = str_replace('")',"",$value);
				//$value = str_replace('"',"",$value);
				//$value = str_replace("'","",$value);
				$value = rtrim($value,"'");
				$value = rtrim($value,'"');
				if(!in_array($value,$output)){
				 $output[] = $value;
				}
			}
		}
	 }
    //getting values within double quotes
	preg_match_all('/t\(\"([A-Za-z0-9.\' \"]+?)\)/', $str, $m);
	if(is_array($m) and count($m)){
		$m2 = $m[1];
		foreach($m2 as $value){
			if(strpos($value,'t("') === FALSE and strpos($value,'t("') === FALSE ){
				$value = str_replace("('","",$value);
				$value = str_replace("')","",$value);
				$value = str_replace('("',"",$value);
				$value = str_replace('")',"",$value);
				//$value = str_replace('"',"",$value);
				//$value = str_replace("'","",$value);
				$value = rtrim($value,"'");
				$value = rtrim($value,'"');
				if(!in_array($value,$output)){
				 $output[] = $value;
				}
			}
		}
	 }
}


$conn = mysql_connect('192.168.13.25','root','Q3tech123');
$selDb = mysql_select_db('lisa_5_DEV');
$query = 'SELECT TRIM(source_label) AS SourceLabel FROM site_translation';
$result = mysql_query($query);
$preTransArray = array();
while($info = mysql_fetch_object($result)){
	$preTransArray[] = strtolower($info->SourceLabel);
}

$query = 'SELECT DISTINCT menu_name FROM menus';
$result = mysql_query($query);
$menuNames = array();
while($info = mysql_fetch_object($result)){
	$menuNames[] = strtolower($info->menu_name);
}

$output = $zipArchiveFiles = array();
//scan the folder
scan_folders('D:\\xampp\\htdocs\\lisa2\\codebase\\',$zipArchiveFiles);

if(is_array($zipArchiveFiles) and count($zipArchiveFiles)){
	foreach($zipArchiveFiles as $fileName){
      get_t_strings(file_get_contents($fileName),$output);
	}
}
//merging text used in the code base with menu names used in database
$output = array_merge($output,$menuNames);

$html = '';
$i=0;
$arr = array();
$reportFileName = 'translation.csv';

/*
include_once('../class/excelwriter.inc.php');
$reportFileName = 'report.xls';
$excel = new ExcelWriter($reportFileName);
*/

$fp = fopen($reportFileName, 'w');

$arr = array('English','German');
//$excel->writeLine($arr);
fputcsv($fp, $arr);
$i=0;
$output = array_unique($output);

if(is_array($output) and count($output)){
	foreach($output as $english){
		$english = trim($english);
		//leaving empty & already translated values
		if($english == '' || in_array(strtolower($english),$preTransArray)){
		  continue;
		}
		$html .= '<tr>';
		$html .=  '<td>'.$i.'</td>';
		$html .=  '<td>'.$english.'</td>';
		$html .=  '<td>---</td>';
		$html .= '</tr>';
		$i++;
		$arr = array($english,'');
 	    //$excel->writeLine($arr);
        fputcsv($fp, $arr);
	}
}else{
   $html .= '<tr>';
   $html .=  '<td colspan="3">No Records found</td>';
   $html .= '</tr>';
}



//echo '<pre>';print_r($output);echo '</pre>';die;
$html = '<table border="1" cellpadding="0" cellspacing="0">
         <tr><th>Sr.No.</th><th>English</th><th>German</th></tr>'.$html;
//echo $html;die;
//@fputcsv($fp, $arr);
header('Pragma: public');   // required
header('Expires: 0');    // no cache
header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
header('Last-Modified: '.gmdate ('D, d M Y H:i:s', filemtime ($reportFileName)).' GMT');
header('Cache-Control: private',false);
header('Content-Type: application/force-download');
header('Content-Disposition: attachment; filename="'.basename($reportFileName).'"');
header('Content-Transfer-Encoding: binary');
header('Content-Length: '.filesize($reportFileName));  // provide file size
header('Connection: close');
readfile($reportFileName);    // push it out
exit();
?>