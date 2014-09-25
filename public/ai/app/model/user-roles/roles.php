<?php
class roles{

	private $db_connection = NULL;
	private $table_name = '';
	private $table_users = '';

	public function __construct($db_obj) {
		$this->db_connection = $db_obj;
		$this->table_name = $this->db_connection->get_table_mapping('roles');
		$this->table_users = $this->db_connection->get_table_mapping('users');
	}
	public function get_total_roles($search = ''){		
		$query  = "SELECT COUNT(*) as cnt FROM ".$this->table_name;
		$query .= ' WHERE (is_deleted != 1 OR is_deleted IS NULL )';
		if($search!=''){
			$query .= ' AND role_name LIKE "%'.$search.'%"
			OR
			role_code LIKE "%'.$search.'%"
			OR
                IF(is_active=1,"'.t('Yes').'","'.t('No').'") 
                LIKE "%'.$search.'%" ';
		}
		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}

	public function get_role_list($orderByClause = ' role_name ASC',$limit = '',
		$search = ''){				
		$query = "SELECT id,role_name,role_code,
		IF(is_active = 1,'".t("Yes")."','".t("No")."') as IsActive,
		(SELECT COUNT(".$this->table_users.".id) FROM ".$this->table_users." 
		WHERE ".$this->table_name.".id = ".$this->table_users.".role_id AND 
		(".$this->table_users.".is_active = 0 
		OR ".$this->table_users.".is_active = 1)) AS total_users 
		FROM ".$this->table_name;		
		$query .= ' WHERE (is_deleted != 1 OR is_deleted IS NULL )';
		if($search!=''){
			$query .= ' AND role_name LIKE "%'.$search.'%"			 		
			 OR
                IF(is_active=1,"'.t('Yes').'","'.t('No').'") 
                LIKE "%'.$search.'%" ';	
			
		}
		$query .= " ORDER BY $orderByClause $limit";

		return $this->db_connection->select($query);
	}

	public function load_role_details($id = ''){		
		$query = 'SELECT * FROM '.$this->table_name;
		if($id!=''){
			$query .= ' WHERE id = '.$this->db_connection->mysql_data_encode($id);
		}

		return $this->db_connection->sql_single_query($query);
	}

	public function check_duplicate_column($columnName,$data,$id = ''){		
		$query = 'SELECT COUNT(*) AS cnt FROM '.$this->table_name.' 
		WHERE '.$columnName.'="'.$this->db_connection->mysql_data_encode($data).'"';
		if($id!=''){
			$query .= ' AND id != '.$this->db_connection->mysql_data_encode($id);
		}
		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}

	public function check_active_users($rid){		
		$tableName = $this->db_connection->get_table_mapping('users');
		$query  = 'SELECT COUNT(Id) AS cnt FROM '.$tableName;
		$query .= ' WHERE role_id = "'.$rid.'"';
		$query .= ' AND is_active = 1';
		$query .= ' AND (is_deleted = 0 OR is_deleted IS NULL)';
		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}

	public function save_role_data($dataArray){
		if(isset($dataArray['pk'])){
			//update
		    $query = 'UPDATE '.$this->table_name.' SET
            role_name="'.$this->db_connection->mysql_data_encode($dataArray['role_name']).'",
            role_code="'.$this->db_connection->mysql_data_encode($dataArray['role_code']).'",
            is_active="'.$this->db_connection->mysql_data_encode($dataArray['is_active']).'",
            modified_by = '.$_SESSION['USER_ID'].',
            modified_at ="'.time().'"
			WHERE id = '.$this->db_connection->mysql_data_encode($dataArray['pk']);
			return $this->db_connection->edit($query);
		}else{
			//insert
		  $query = 'INSERT INTO '.$this->table_name.' (role_name,role_code,
		  is_active,created_by,created_at)
          VALUES("'.$this->db_connection->mysql_data_encode($dataArray['role_name']).'","'
          .$this->db_connection->mysql_data_encode($dataArray['role_code']).'","'
          .$this->db_connection->mysql_data_encode($dataArray['is_active']).'",'
          .$_SESSION['USER_ID'].',"'.time().'")';
		  return $this->db_connection->insert($query);
		}
	}
	/*
	 * Hard delete roles
	 * */
	public function deleteRole($roleId,$userId,$time){
		$query  = 'DELETE FROM '.$this->table_name;
		$query .= ' WHERE id = "'.$roleId.'"';
		$this->db_connection->delete($query);
		
		$query  = 'DELETE FROM '.$this->db_connection->get_table_mapping('role_permissions');
		$query .= ' WHERE role_id = "'.$roleId.'"';
		$this->db_connection->delete($query);
		
		$query  = 'DELETE FROM '.$this->db_connection->get_table_mapping('users_permissions');
		$query .= ' WHERE role_id = "'.$roleId.'"';
		$this->db_connection->delete($query);
		/*update users of this role*/
		$query  = 'UPDATE '.$this->table_users;
		$query .= ' SET role_id = "'.DELETED_ROLE.'"';
		$query .= ',modified_by = "'.$userId.'", modified_at="'.$time.'"';
		$query .= ' WHERE role_id = "'.$roleId.'"';
		$this->db_connection->edit($query);
	}
}
?>