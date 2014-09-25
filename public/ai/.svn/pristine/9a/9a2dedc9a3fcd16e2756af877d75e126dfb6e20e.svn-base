<?php

/**
 *
 * Create Wall Class provides functions that simply perform the actions
 * like save design, edit design.
 * @author     	: rasingh - Q3tech
 * @created on  : Aug 22, 2014
 * @modified on : Aug 22, 2014
 */
class CreateWall {

	private $db_connection = NULL;
    private $table_design_images = '';

	/**
	 *
	 * This is a constructor function where variables are intialized automatically
	 * when object is created of this class
	 * @param object $db_obj
	 * @return null
	 */
	public function __construct($db_obj) {
		$this->db_connection = $db_obj;
        $this->table_design_images = $this->db_connection->get_table_mapping('design_images');
	}

    /**
     *
     * This function is used to get html of the design image
     * @param int $id
     * @return string
     */
    public function get_design_image($id) {
        $query = 'SELECT html FROM ' . $this->table_design_images;
        $query .= ' WHERE id = "'. $id .'" LIMIT 1';
        return $this->db_connection->select($query);
    }

}

?>