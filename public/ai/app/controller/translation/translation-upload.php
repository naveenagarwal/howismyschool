<?php
$targetPath = TRANSLATION_UPLOAD_DIR;
$arr['success'] = true;
$statusArr = array(1,0);
if (!empty($_FILES)) {
    $tempFile  = $_FILES['translation_upload']['tmp_name'];
    $tempName  = $_FILES['translation_upload']['name'];
    $fileParts = pathinfo($_FILES['translation_upload']['name']);
    $destinationFile
    = $targetPath.'/'.TRANSLATION_FILE_PREFIX.
    time().'.'.$fileParts['extension'];
    $fileTypes = array('csv');

    if($_FILES['translation_upload']['size']>IMAGE_MAX_UPLOAD_B){
        $arr['success'] = false;
        $arr['msg'] = t('Mamimum file size exceeds');
    }
    else if (in_array(strtolower($fileParts['extension']),$fileTypes)){
        //read CSV & apply validation
        //load CSV reqader
        include_once VENDOR_PHYSICAL_PATH.'csv/File_CSV_DataSource.php';
        $csvObj = new File_CSV_DataSource;
        $csvObj->load($tempFile);
        $headers = $csvObj->getHeaders();
        $headerCnt = count($headers);
        if($headerCnt != 2){
          $arr['success'] = false;
          $arr['msg'] = t('Input file must have two columns');
        }
        if($arr['success']){
           //as numeric index was required
           $fileRecords = $csvObj->getRawArray();
           //since 0th index return header rows,so
           //we are removing from processing
           if(isset($fileRecords[0])){
            unset($fileRecords[0]);
            //re-index the array
            $fileRecords = array_values($fileRecords);
           }
           $cnt = count($fileRecords);
           $emptySource = $emptyTranslation =   array();
           $dupSource = $sources = $maxSource =
           $maxTranslation = array();
           if($cnt){
               for($i = 0; $i < $cnt; $i++){
                 $fileRecords[$i][0] = trim($fileRecords[$i][0]);
                 $fileRecords[$i][1] = trim($fileRecords[$i][1]);

                 $lineNo = $utility_obj->addOrdinalNumberSuffix($i+2);
                 if(empty($fileRecords[$i][0])){
                    $arr['success'] = false;
                    $emptySource[] = $lineNo;
                 }else{
                    if(in_array($fileRecords[$i][0], $sources)){
                        $arr['success'] = false;
                        $dupSource[] = $lineNo;
                    }
                    $sources[] = $fileRecords[$i][0];
                    if(strlen($fileRecords[$i][0])>MAX_SOURCE_LABEL){
                        $arr['success'] = false;
                        $maxSource[] = $lineNo;
                    }
                 }
                 if(empty($fileRecords[$i][1])){
                    $arr['success'] = false;
                    $emptyTranslation[] = $lineNo;
                 }else{
                     if(strlen($fileRecords[$i][1])>MAX_TRANSLATED_LABEL){
                        $arr['success'] = false;
                        $maxTranslation[] = $lineNo;
                     }
                 }
                 $dataArray[$i]['lang_code']
                 = DEFAULT_TRANSLATION_LANGUAGE;
                 $dataArray[$i]['source_label']     = $fileRecords[$i][0];
                 $dataArray[$i]['translated_label'] = $fileRecords[$i][1];
                 $dataArray[$i]['is_active']        = 1;
               }

               if($arr['success']){//validation passed
                include_once('./model/translation/translation.php');
                $translationObj = new translation($db_obj);
                $preData = $translationObj->load_translation_details_by_source(
                create_comma_separated_list($sources,'',1,1));
                //attach Primary Key with existing records
                if(is_array($preData) && count($preData)){
                    foreach ($preData as $preVal) {
                        foreach ($dataArray as $key => $value) {
                            if($dataArray[$key]['source_label']
                                == $preVal->source_label){
                                $dataArray[$key]['pk'] = $preVal->id;
                            }
                        }
                    }
                }
                //save the data
                foreach ($dataArray as $value) {
                    $translationObj->save_translation_data($value);
                }
                $arr['msg'] = t('Translation information uploaded
                successfully');

                //add system log data
                $logData = array('IP'=>$_SERVER['REMOTE_ADDR'],
                'USER_AGENT'=>$_SERVER['HTTP_USER_AGENT'],
                'OPERATION'=>DATA_IMPORT,'MODULE'=>'Translation Import',
                'ID_RANGE'=>'','TOTAL_IMPORTED'=>count($dataArray),
                'CREATED_BY'=>$_SESSION['USER_ID'],'CREATED_AT'=>time());
                $utility_obj->add_system_log($logData);

                //create directory if not exists
                if(!is_dir($targetPath)){
                    mkdir($targetPath, 0777 );
                }
                //move uploaded file to storage location
                copy($tempFile,$destinationFile);
               }else{
                 $errMsg = '';
                 if(count($emptySource)){
                    $errMsg  = '<li>';
                    $errMsg .= t('Empty source lable found in').'&nbsp;'.
                    implode(',', $emptySource).'&nbsp;'.t('line(s)');
                    $errMsg .= '</li>';
                 }
                 if(count($maxSource)){
                    $errMsg  = '<li>';
                    $errMsg .= t('Maximum length exceeds for source label in').
                    '&nbsp;'.implode(',', $maxSource).'&nbsp;'.
                    t('line(s)');
                    $errMsg .= '</li>';
                 }
                 if(count($dupSource)){
                    $errMsg .= '<li>';
                    $errMsg .= t('Duplicate source label found in').'&nbsp;'.
                    implode(',', $dupSource).'&nbsp;'.t('line(s)');
                    $errMsg .= '</li>';
                 }
                 if(count($emptyTranslation)){
                    $errMsg .= '<li>';
                    $errMsg .= t('Empty translatated label found in').'&nbsp;'.
                    implode(',', $emptyTranslation).'&nbsp;'.t('line(s)');
                    $errMsg .= '</li>';
                 }
                 if(count($maxTranslation)){
                    $errMsg  = '<li>';
                    $errMsg .= t('Maximum length exceeds for translated
                    label in').'&nbsp;'.implode(',', $maxTranslation).'&nbsp;'.
                    t('line(s)');
                    $errMsg .= '</li>';
                 }
                 $arr['msg'] = '<ol>'.$errMsg.'</ol>';
               }
           }
           else{
              $arr['success'] = false;
              $arr['msg'] = t('No translation information found');
           }
        }
    } else {
        $arr['success'] = false;
        $arr['msg'] = t('Invalid file type.');
    }
}else{
   $arr['success'] = false;
   $arr['msg'] = t('No input file specified or
   file size is too large');
}
die(json_encode(encode_json_array($arr)));
?>