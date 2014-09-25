<?php
$fileName = trim($_GET['fileName']);
$mode = trim($_GET['mode']);
if($fileName == ''){
die('error');
}

if($mode == ''){
$mode = 1;
}
if($mode == '1'){//for downloading project related files
$sourceFolder = CUSTOMDIR.'/media/project/';
}
else if($mode == '2'){
$sourceFolder = CUSTOMDIR.'/media/';
}
$fileUrl = $sourceFolder . $fileName;
$fileNameArray = explode('/', $fileName);
header('Content-Type: application/octet-stream');
header("Content-Transfer-Encoding: Binary");
header("Content-disposition: attachment; filename=\"".$fileNameArray[count($fileNameArray)-1]."\"");
readfile($fileUrl);
?>