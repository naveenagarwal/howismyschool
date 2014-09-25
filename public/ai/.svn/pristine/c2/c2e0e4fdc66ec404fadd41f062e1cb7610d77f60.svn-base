<?php
class translation{

	private $table_name = '';
	private $db_connection = NULL;

	public function __construct($db_obj) {
		$this->db_connection = $db_obj;
		$this->table_name = $this->db_connection->get_table_mapping('site_translation');
	}
	public function get_total_translations($search = ''){
		$query = "SELECT COUNT(*) as cnt FROM ".$this->table_name;
		if($search!=''){
			$query .= ' WHERE (lang_code ="'.$search.'"
			OR source_label LIKE "%'.$search.'%"
			OR IF(is_active=1,"'.t('Yes').'","'.t('No').'")
            LIKE "%'.$search.'%" )';
		}
		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}

	public function get_translation_list($orderByClause = ' source_label ASC',
	    $limit = '',$search = ''){
		$query = "SELECT id,lang_code,source_label,translated_label,
		IF(is_active = 1,'".t("Yes")."','".t("No")."') as is_active
		FROM ".$this->table_name;

		if($search!=''){
			$query .= ' WHERE (lang_code ="'.$search.'"
				OR source_label LIKE "%'.$search.'%"
				OR IF(is_active=1,"'.t('Yes').'","'.t('No').'")
                LIKE "%'.$search.'%")';
		}

		$query .= " ORDER BY $orderByClause $limit";

		return $this->db_connection->select($query);
	}

	public function load_translation_details($id = ''){
		$query = 'SELECT * FROM '.$this->table_name;
		if($id!=''){
			$query .= ' WHERE id = '.$this->db_connection->mysql_data_encode($id);
		}

		return $this->db_connection->sql_single_query($query);
	}
    public function load_translation_details_by_source($source,
        $lang = DEFAULT_TRANSLATION_LANGUAGE){
		$query = 'SELECT * FROM '.$this->table_name;
		$query .= ' WHERE source_label IN ('.$source.')';
		if($lang!=''){
		    $query .= ' AND lang_code = "'.$this->db_connection->mysql_data_encode($lang).'"';
		}
		return $this->db_connection->select($query,2);
	}

	public function check_duplicate_column($column1,$data1,$column2,$data2,
	    $id = ''){
		$query = 'SELECT COUNT(*) AS cnt FROM '.$this->table_name.'
		          WHERE ('.$column1.'="'.$this->db_connection->mysql_data_encode($data1).'"
		          AND '.$column2.'="'.$this->db_connection->mysql_data_encode($data2).'")';
		if($id!=''){
			$query .= ' AND id != '.$this->db_connection->mysql_data_encode($id);
		}

		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}

	public function save_translation_data($dataArray){
		if(isset($dataArray['pk'])){
			//update
			$query = 'UPDATE '.$this->table_name.' SET
         lang_code = "'.$this->db_connection->mysql_data_encode($dataArray['lang_code']).'",
         source_label
         = "'.$this->db_connection->mysql_data_encode($dataArray['source_label']).'",
         translated_label
         = "'.$this->db_connection->mysql_data_encode($dataArray['translated_label']).'",
         modified_by   = "'.$_SESSION['USER_ID'].'",
         modified_at   = "'.time().'",
         is_active
         = "'.$this->db_connection->mysql_data_encode($dataArray['is_active']).'"
      	 WHERE id = '.$this->db_connection->mysql_data_encode($dataArray['pk']);
		 return $this->db_connection->edit($query);
		}else{
			//insert
			$query = 'INSERT INTO '.$this->table_name.'
			(lang_code,source_label,translated_label,created_by,created_at,
			is_active)
	          VALUES(
	          	"'.$this->db_connection->mysql_data_encode($dataArray['lang_code']).'",
	          	"'.$this->db_connection->mysql_data_encode($dataArray['source_label']).'",
	          	"'.$this->db_connection->mysql_data_encode($dataArray['translated_label']).'",
	          	"'.$_SESSION['USER_ID'].'",
	          	"'.time().'",
	          	"'.$this->db_connection->mysql_data_encode($dataArray['is_active']).'"
	          	)';
			return $this->db_connection->insert($query);
		}
	}


	public function save_bulk_translation_data($insertString){
		$query = 'INSERT INTO '.$this->table_name.' (lang_code,source_label,
		translated_label,is_active,created_by,created_at)
			      VALUES '.$insertString;
		return $this->db_connection->insert($query);
	}

	public function delete_translation_data($langCode,$source_label){
		$query = 'DELETE FROM '.$this->table_name.' WHERE
		lang_code = "'.$langCode.'" AND
		source_label = "'.$source_label.'"';
		return $this->db_connection->delete($query);
	}

    public function delete_translation_by_id($id){
		$query = 'DELETE FROM '.$this->table_name.' WHERE id = '.$id;
		return $this->db_connection->delete($query);
	}
}
?>