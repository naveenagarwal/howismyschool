<?php

/**
 * Size Class provides functions that simply perform the actions
 * like get total sizes, get size list, load size details, check duplicate
 * size name, delete size, etc.
 * @author     	: rasingh - Q3tech
 * @created on  : Aug 29, 2014
 * @modified on : Sep 01, 2014
 */
class Size {

	private $db_connection = NULL;
    private $table_size = '';

	/**
	 * This is a constructor function where variables are intialized automatically
	 * when object is created of this class
	 * @param object $db_obj
	 * @return null
	 */
	public function __construct($db_obj) {
		$this->db_connection = $db_obj;
        $this->table_size = $this->db_connection->get_table_mapping('sizes');
	}

	/**
     * This function is used to get count of total sizes
	 * @param string $search
     * @return int
     */
    public function get_total_sizes($search = '') {
		$query  = "SELECT COUNT(*) as cnt FROM ".$this->table_size;
		if($search!=''){
			$query .= ' WHERE (name LIKE "%'.$search.'%"
			OR
                IF(is_active=1,"'.t('Yes').'","'.t('No').'")
                LIKE "%'.$search.'%" )';
		}
		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}

	/**
     * This function is used to get size list
	 * @param string $order_by_clause
	 * @param int $limit
	 * @param string $search
     * @return object
     */
    public function get_size_list($order_by_clause = ' id ASC',
    	$limit = '', $search = '') {

		$query = "SELECT id, name,
		IF(image_path = '', '--', CONCAT('<img src=".'"'.SIZE_IMAGE_ROOT_PATH."/',image_path,
        '" .'" '. "width=".'"200"'." />') ) as image_path,
		IF(is_active = 1,'".t("Yes")."','".t("No")."') as IsActive
		FROM ".$this->table_size;
		if($search!=''){
			$query .= ' WHERE (name LIKE "%'.$search.'%"
			 OR
                IF(is_active=1,"'.t('Yes').'","'.t('No').'")
                LIKE "%'.$search.'%" )';

		}
		$query .= " ORDER BY $order_by_clause $limit";

		return $this->db_connection->select($query);
	}

	/**
     * This function is used to get size detail based on size id
	 * @param int $id
     * @return object
     */
    public function load_size_details($id = '') {
		$query = 'SELECT * FROM '.$this->table_size;
		if($id!=''){
			$query .= ' WHERE id='.$this->db_connection->mysql_data_encode($id);
		}
		return $this->db_connection->sql_single_query($query);
	}

	/**
     * This function is used to check duplicate size name
	 * @param string $column_name
	 * @param string $data
	 * @param int $id
     * @return int
     */
    public function check_duplicate_column($column_name, $data, $id = '') {
		$query = 'SELECT COUNT(*) AS cnt FROM '.$this->table_size.'
			WHERE '.$column_name.'="'
			.$this->db_connection->mysql_data_encode($data).'"';
		if($id!=''){
			$query .= ' AND id != '
				.$this->db_connection->mysql_data_encode($id);
		}
		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}

	/**
     * This function is used to save data into the database
	 * @param string $data_array
     * @return int
     */
    public function save_size_data($data_array) {
		if(isset($data_array['pk'])){
		    $query = 'UPDATE '.$this->table_size.' SET
            name="'.$this->db_connection
		    	->mysql_data_encode($data_array['name']).'",
            image_path="'.$this->db_connection
		    	->mysql_data_encode($data_array['image_path']).'",
            is_active="'.$this->db_connection
		    	->mysql_data_encode($data_array['is_active']).'",
            modified_by = '.$_SESSION['USER_ID'].',
            modified_at ="'.time().'"
			WHERE id='.$this->db_connection->mysql_data_encode($data_array['pk']);
			return $this->db_connection->edit($query);
		}else{
		  $query = 'INSERT INTO '.$this->table_size.' (name,image_path,
		  is_active,created_by,created_at)
          VALUES("'.$this->db_connection
		  	->mysql_data_encode($data_array['name']).'","'
          .$this->db_connection->mysql_data_encode($data_array['image_path']).'","'
          .$this->db_connection->mysql_data_encode($data_array['is_active']).'",'
          .$_SESSION['USER_ID'].',"'.time().'")';
		  return $this->db_connection->insert($query);
		}
	}

	/**
     * This function is used to delete size
	 * @param int $id
     * @return null
     */
	public function delete_size($id){
		$query  = 'DELETE FROM '.$this->table_size;
		$query .= ' WHERE id = "'.$id.'"';
		$this->db_connection->delete($query);
	}

	/**
     * This function is used to check all active product
	 * based on size id
	 * @param int $size_id
     * @return null
     */
	public function check_active_product($size_id){
		$table_name = $this->db_connection->get_table_mapping('product_references');
		$query  = 'SELECT COUNT(product_id) AS cnt FROM '.$table_name;
		$query .= ' WHERE size_id = "'.$size_id.'"';
		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}
}
?>