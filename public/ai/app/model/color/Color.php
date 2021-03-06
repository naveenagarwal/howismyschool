<?php

/**
 *
 * Color Class provides functions that simply perform the actions
 * like get total colors, get color list, load color details, check duplicate
 * color name, delete color, etc.
 * @author     	: rasingh - Q3tech
 * @created on  : Aug 29, 2014
 * @modified on : Aug 29, 2014
 */
class Color {

	private $db_connection = NULL;
    private $table_color = '';

	/**
	 * This is a constructor function where variables are intialized automatically
	 * when object is created of this class
	 * @param object $db_obj
	 * @return null
	 */
	public function __construct($db_obj) {
		$this->db_connection = $db_obj;
        $this->table_color = $this->db_connection->get_table_mapping('colors');
	}

	/**
     * This function is used to get count of total colors
	 * @param string $search
     * @return int
     */
    public function get_total_colors($search = '') {
		$query  = "SELECT COUNT(*) as cnt FROM ".$this->table_color;
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
     * This function is used to get color list
	 * @param string $order_by_clause
	 * @param int $limit
	 * @param string $search
     * @return object
     */
    public function get_color_list($order_by_clause = ' id ASC',
    	$limit = '', $search = '') {
		$query = "SELECT id, name,
		IF(image_path = '', '--', CONCAT('<img src=".'"'.COLOR_IMAGE_ROOT_PATH."/',image_path,
        '" .'" '. "width=".'"200"'." />') ) as image_path,
		IF(is_active = 1,'".t("Yes")."','".t("No")."') as IsActive
		FROM ".$this->table_color;
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
     * This function is used to get color detail based on color id
	 * @param int $id
     * @return object
     */
    public function load_color_details($id = '') {
		$query = 'SELECT * FROM '.$this->table_color;
		if($id!=''){
			$query .= ' WHERE id='.$this->db_connection->mysql_data_encode($id);
		}
		return $this->db_connection->sql_single_query($query);
	}

	/**
     * This function is used to check duplicate color name
	 * @param string $column_name
	 * @param string $data
	 * @param int $id
     * @return int
     */
    public function check_duplicate_column($column_name, $data, $id = '') {
		$query = 'SELECT COUNT(*) AS cnt FROM '.$this->table_color.'
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
    public function save_color_data($data_array) {
		if(isset($data_array['pk'])){
		    $query = 'UPDATE '.$this->table_color.' SET
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
		  $query = 'INSERT INTO '.$this->table_color.' (name,image_path,
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
     * This function is used to delete color
	 * @param int $id
     * @return null
     */
	public function delete_color($id){
		$query  = 'DELETE FROM '.$this->table_color;
		$query .= ' WHERE id = "'.$id.'"';
		$this->db_connection->delete($query);
	}

	/**
     * This function is used to check all active product
	 * based on size id
	 * @param int $color_id
     * @return null
     */
	public function check_active_product($color_id){
		$table_name = $this->db_connection->get_table_mapping('product_references');
		$query  = 'SELECT COUNT(product_id) AS cnt FROM '.$table_name;
		$query .= ' WHERE color_id = "'.$color_id.'"';
		$result = $this->db_connection->sql_single_query($query);
		return $result['cnt'];
	}

}
?>