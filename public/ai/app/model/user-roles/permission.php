<?php
class permission{

	private $db_connection = NULL;
    private $table_user = '';
    private $table_user_details = '';
    private $table_user_roles = '';
    private $tbl_user_permission = '';
    public $user_special_role = '';

    public function __construct($db_obj) {
		$this->db_connection = $db_obj;
        $this->table_user = 
			$this->db_connection->get_table_mapping('users');
        $this->table_user_details = 
			$this->db_connection->get_table_mapping('user_details');
        $this->table_user_roles   = 
			$this->db_connection->get_table_mapping('roles');
        $this->tbl_user_permission   = 
			$this->db_connection->get_table_mapping('users_permissions');
        $this->tbl_role_permission   =
			$this->db_connection->get_table_mapping('role_permissions');
        $this->menus = $this->db_connection->get_table_mapping('menus');
    }

    public function get_menus($menu_codes = '',$menu_types = ''){
        $query = "SELECT * FROM ".$this->menus.' WHERE 1=1 ';
        if($menu_codes!=''){
            $query .= ' AND menu_code IN ("HOME",'.$menu_codes.')';
        }
        if($menu_types!=''){
            $query .= ' AND menu_type IN ('.$menu_types.')';
        }
        $query .= ' AND is_active = 1';
        $query .= ' ORDER BY menu_order';
        return $this->db_connection->select($query);
    }

    public function get_survey_list_menus($projectId = ''){
        $globalTable = $this->menus;
        $query = "SELECT * FROM ".$globalTable.' WHERE 1=1 ';
        if($projectId!=''){
            $query .= ' AND ProjectId IN ('.$projectId.')';
        }
        $query .= ' AND ParentModuleId = (SELECT 
        ModuleId FROM '.$globalTable.' WHERE ModuleCode="SURVEY_LIST")';
        $query .= ' AND IsActive = 1';
        $query .= ' ORDER BY menu_order';

        return $this->db_connection->select($query);
    }
    public function get_user_special_role($userId){
        if($userId==''){
            return false;
        }
        $query = 'SELECT
                       user.user_name,
                       role.role_name,
                       user.role_id
                FROM
                     '.$this->table_user.' user,
                     '.$this->table_user_roles.' role
                WHERE
                     user.role_id = role.id
                     AND user.id = '.$userId;
        return $this->db_connection->sql_single_query($query);
    }

    public function get_project_data($projectId = '',$uTypeId = ''){
        $query = 'SELECT ProjectId,ProjectCode,ProjectName
                FROM '.$this->db_connection->get_table_mapping('Lisa_mst_project');
        //for QA & Agents
        if($uTypeId == '3' or $uTypeId == '4'){
            $query .= ' WHERE IsActive = 1 ';
        }
        else{
            $query .= ' WHERE IsActive IN (1,2) ';
        }
        if($projectId!=''){
            $query .= ' AND ProjectId = '.$projectId;
        }
        return $this->db_connection->select($query);
    }

    /*
    * THIS FUNCTION IS USED TO DELETE ROLE'S PERMISSION
    */
    public function deleteRolePermission($roleId){
        if(empty($roleId)){
            return false;
        }
        $query  = 'DELETE FROM '.$this->tbl_role_permission;
        $query .= ' WHERE role_id = "'.$roleId.'"';
        $this->db_connection->delete($query);
        return true;
    }
    /*
    * THIS FUNCTION IS USED TO DELETE ROLE'S PERMISSION
    */
    public function deleteUserPermission($userId,$roleId = 0){
        if(empty($userId) && empty($roleId)){
            return false;
        }
        $query  = 'DELETE FROM '.$this->tbl_user_permission;
        if(!empty($userId)){
          $query .= ' WHERE user_id = "'.$userId.'"';
        }
        if(!empty($userId) && !empty($roleId)){
          $query .= ' AND ';
          $query .= ' menu_codes NOT IN 
          (SELECT menu_codes FROM '.$this->tbl_role_permission.' 
            WHERE role_id = "'.$roleId.'")';
        }
        else if(!empty($roleId)){
            $query .= ' WHERE ';
            $query .= ' menu_codes NOT IN 
            (SELECT menu_codes FROM '.$this->tbl_role_permission.' 
            WHERE role_id = "'.$roleId.'")';
        }
        $this->db_connection->delete($query);
        return true;
    }
    /*
    * THIS FUNCTION IS USED TO INSERT PERMISSION RECORDS
    */
    public function insertPermission($id1,$permissionArr,$type,$id2=''){
        //check that user can have only those menus assigned to its role
        $currentValArray = array();
        if($type == 2){
            $currentValArray = $this->getRolePermissionData($id1);
            if(!$currentValArray){
                $currentValArray = array();
            }else{
                $moduleCodes = create_comma_separated_list($currentValArray,
                'menu_codes',2,0);
                $currentValArray = explode(',', $moduleCodes);
            }
        }
        if(is_array($permissionArr) and count($permissionArr)){
            foreach($permissionArr as $permission){
                if($type == 2 && !in_array($permission, $currentValArray)){
                    continue;
                }
                if($insertString!=''){
                    $insertString .= ',';
                }
                $permArr = explode('~',$permission);
                $cnt = count($permArr);
                $genModuleCodes = '';
                for($i = 0; $i < $cnt; $i++){
                    if($genModuleCodes!=''){
                        $genModuleCodes .= '~';
                    }
                    $genModuleCodes .= $permArr[$i];
                }
                $insertString .= '(';
                $insertString .= $id1;
                if($type == 2){//user id
                  $insertString .= ','.$id2;
                }
                $insertString .= ',"'.$genModuleCodes.'",';
                $insertString .= $_SESSION['USER_ID'].',"'.time();
                $insertString .='")';
            }

            //insert new permission into role permission
            if($insertString!='' && $type == 1){
                $query = 'INSERT INTO '.$this->tbl_role_permission.'
                (role_id,menu_codes,created_by,created_at) 
                VALUES '.$insertString;
                $this->db_connection->insert($query);
            }
            //insert new permission into user permission
            if($insertString!='' && $type == 2){
                $query = 'INSERT INTO '.$this->tbl_user_permission.'
                (role_id,user_id,menu_codes,created_by,created_at) 
                VALUES '.$insertString;
                $this->db_connection->insert($query);
            }
        }
        return true;
    }
    /*
    *THIS FUNCTION IS USED TO SAVE ROLE PERMISSION
    */
    public function save_role_permission($roleId,$permissionArr){
        //delete previous entries
        if(!$this->deleteRolePermission($roleId)){
            return false;
        }
        $this->insertPermission($roleId,$permissionArr,1);
        $this->deleteUserPermission(0,$roleId);
        return true;
    }

    /*
    *THIS FUNCTION IS USED TO SAVE USER PERMISSION
    */
    public function save_user_permission($userId,$roleId,$permissionArr){
        //delete previous entries
        if(!$this->deleteUserPermission($userId)){
            return false;
        }
        $this->insertPermission($roleId,$permissionArr,2,$userId);
        return true;
    }

    /*
    * THIS FUNCTION IS USED TO GET PERMISSION DATA OF A ROLE
    */
    public function getRolePermissionData($roleId){
        if(empty($roleId)){
            return false;
        }
        $query  = 'SELECT menu_codes FROM '.$this->tbl_role_permission;
        $query .= ' WHERE role_id = "'.$roleId.'"';
        return $this->db_connection->select($query,2);
    }

    /*
    * THIS FUNCTION IS USED TO GET PERMISSION DATA OF AN USER
    */
    public function getUserPermissionData($userId){
        if(empty($userId)){
            return false;
        }
        $query  = 'SELECT menu_codes FROM '.$this->tbl_user_permission;
        $query .= ' WHERE user_id = "'.$userId.'"';
        return $this->db_connection->select($query,2);
    }

    /*THIS FUNCTION IS USED TO SET PROJECT DATA*/
    public function set_permission_data(){
        $userId = $_SESSION['USER_ID'];
        if(empty($userId)){
            return false;
        }
        $_SESSION['USER_ALLOWED_MENU'] = '';
        $excludeMenu = '';
        $moduleData = '-1';
        //display all projects for super admin
        if($_SESSION['USER_ID'] != SUPER_ADMIN_ID 
        && $_SESSION['USER_ROLE_ID'] != SUPER_ADMIN_ROLE){
            $moduleData   = $this->getUserPermissionData($_SESSION['USER_ID']);
        }
        $_SESSION['USER_EXCLUDE_MENU'] = $excludeMenu;
        if($moduleData!='-1'){
            $moduleString = '';
            if(count($moduleData) and is_array($moduleData)){
                foreach($moduleData as $modules){
                    $moduleArr = explode('~', $modules->menu_codes);
                    foreach ($moduleArr as $value) {
                        if($moduleString!=''){
                            $moduleString .= ',';
                        }
                        $moduleString .= "'".$value."'";
                    }
                }
                if($moduleString!=''){
                    $_SESSION['USER_ALLOWED_MENU'] 
                    = $_SESSION['USER_ALLOWED_MENU'] = 
                    $moduleString;
                }
            }else{
                //if no permission is being alloted to this user
                $_SESSION['USER_ALLOWED_MENU'] = 
                $_SESSION['USER_ALLOWED_MENU'] = -1;
            }
        }

    }

    /*THIS FUNCTION UPDATES USER'S DEFAULT PROJECT SELECTION WHEN 
     PERMISSION GETS CHANGED*/
    public function update_user_default_project($userId,$projectArray){
        $query = 'SELECT ProjectId FROM '.$this->table_user_details.' 
        WHERE UserId ='.$userId;
        $projectId = $this->db_connection->sql_single_query($query);
        if(!count($projectArray)){
            $query = 'UPDATE '.$this->table_user_details.' SET 
            ProjectId = NULL WHERE UserId ='.$userId;
            $this->db_connection->edit($query);
        }else if(!in_array($projectId, $projectArray)){
            $query = 'UPDATE '.$this->table_user_details.' 
            SET ProjectId = '.$projectArray[0].' WHERE UserId ='.$userId;
            $this->db_connection->edit($query);
        }
    }
    
    /*THIS FUNCTION IS USED TO GET DATA SET MAPPING OF AN USER*/
    public function get_data_set_mapping($userId){
      $table = $this->db_connection->get_table_mapping('Lisa_user_dataset');
      $query  = 'SELECT * FROM '.$table.' WHERE UserId='.$userId;
      $query .= ' AND IsActive = 1';
      return $this->db_connection->sql_single_query($query,true,2);
    }
    
 	/*
    *THIS FUNCTION IS USED TO SAVE ROLE PERMISSION
    */
    public function update_user_permission($userId,$roleId){
        //delete previous entries  
        if(!$this->deleteUserPermissionData($userId,$roleId)){
        	return false;
        }     
        $this->insertUserPermission($roleId,$userId);       
        return true;
    }
    
    public function deleteUserPermissionData($userId,$roleId){
        if(empty($userId) && empty($roleId)){
            return false;
        }
           
        if(!empty($userId) && !empty($roleId)){
        	$query  = 'DELETE FROM '.$this->tbl_user_permission; 
        	$query  = ' WHERE user_id='.$userId.' AND role_id='.$roleId;
            $this->db_connection->delete($query);
        }
        return true;
       
    }
    
    public function insertUserPermission($roleId,$userId){
    	$query = "insert into users_permissions (user_id, role_id, 
    	menu_codes, created_by, created_at) 
		select 		
		'".$userId."', '".$roleId."', menu_codes, '".$_SESSION['USER_ID']."', 
		'".time()."'         
        from role_permissions where role_id = '".$roleId."'";    
    	$this->db_connection->insert($query);
    	return true;
    	
    }
    
}
?>