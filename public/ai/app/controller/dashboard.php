<?php
$viewAB1Graph = isset($_SESSION['MENU_NAMES_ARRAY'][DASHBOARD_AB1_GRAPH]);
$viewAB2Graph = isset($_SESSION['MENU_NAMES_ARRAY'][DASHBOARD_AB2_GRAPH]);
$viewLogHistory = isset($_SESSION['MENU_NAMES_ARRAY'][DASHBOARD_LOG_HISTORY]);
$viewQuickLinks = isset($_SESSION['MENU_NAMES_ARRAY'][DASHBOARD_QUICK_LINKS]);
$viewAllLogsHistory = isset($_SESSION['MENU_NAMES_ARRAY']['view-logs/view-logs']);

$noDashboardItems = FALSE;
if(!$viewAB1Graph && !$viewAB2Graph 
&& !$viewLogHistory && !$viewQuickLinks){
    $noDashboardItems = TRUE;
}
if($viewLogHistory){
	//load model class
	include_once('./model/common/common.php');
	$mod_obj = new common($db_obj);
	$sOrder = " created_at desc";
	$limit = ' Limit 5';	
	$viewLogs    = $mod_obj->get_system_log_list($sOrder,$limit,USER_LOGIN);
		
	if(is_array($viewLogs) && count($viewLogs)){
    	foreach ($viewLogs as $key => $value) {
    	  $viewLogs[$key]['id_range'] = show_ellipse($value['id_range'],30);  
    	  $viewLogs[$key]['user_agent'] = show_ellipse($value['user_agent'],15);  
     	  $viewLogs[$key]['created_at'] 
    	  = $utility_obj->format_date_value($value['created_at'],true);
    	  $viewLogs[$key]['operation_performed'] 
    	  = $GLOBALS['glbLogTypes'][$value['operation_performed']];
    	}
	}
}
require_once('view/dashboard.php');
?>