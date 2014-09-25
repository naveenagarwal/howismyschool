<?php

/**
 *
 * Design Class provides functions that simply perform the actions
 * like save design, edit design.
 * @author      : dbaveja - Q3tech
 * @created on  : Sep 01, 2014
 * @modified on : Sep 01, 2014
 */
class Design {

    private $db_connection = NULL;
    private $table_user_designs = '';
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
        $this->table_user_designs = $this->db_connection->get_table_mapping('user_designs');
        $this->table_design_images = $this->db_connection->get_table_mapping('design_images');
    }

    /**
     * This function is used to get design details based on design id
     * @param int $wall_id
     * @return string
     */
    public function get_design_by_id($design_id = '') {
        $query = 'SELECT html_info FROM '.$this->table_user_designs;
        $query .= ' WHERE user_id = ' . $_SESSION['USER_ID'] . ' AND id = ' . $design_id . ' LIMIT 1';
        return $this->db_connection->select($query);
    }

    /**
     * This function lists the designs based on user id.
     * @param void
     * @return array
     */
    public function get_designs_by_user_id() {
        $query = 'SELECT id, name FROM '.$this->table_user_designs;
        $query .= ' WHERE user_id = ' . $_SESSION['USER_ID'] . ' ORDER BY created_at DESC';
        return $this->db_connection->select($query);
    }

    /**
     * This function is used to save the design in the database
     * @param int $user_design_id
     * @param string $json_info
     * @param string $html_info
     * @return int
     */
    public function save_design($data_arr) {
        if( !empty($data_arr) ) {
            $user_design_id = $data_arr['user_design_id'];
            $html_info = $data_arr['html_info'];
            $json_info = $data_arr['json_info'];
            $name = $data_arr['name'];
            if(empty($name)){
                $name = time();
            }
        }
        if( $user_design_id != '' ) {
            $query = 'UPDATE '.$this->table_user_designs;
            $query .= ' SET json_info = "'. $json_info .'", html_info = "'. $html_info .'",';
            $query .= ' modified_by = '.$_SESSION['USER_ID'].' , modified_at = "'.time().'"';
            $query .= ' WHERE id = '.$user_design_id;
            if($this->db_connection->edit($query)) {
                return $user_design_id;
            }
            else {
                return false;
            }
        }
        else {
            $query = 'INSERT INTO '.$this->table_user_designs;
            $query .= ' (user_id, name, json_info, html_info, design_image_path, created_by, created_at)';
            $query .= ' VALUES('.$_SESSION['USER_ID'].', "'.$name.'", "'. $json_info .'", "'. $html_info .'",
                               "design_image_path",'.$_SESSION['USER_ID'].',"'.time().'")';
            return $this->db_connection->insert($query);
        }
    }

    /**
     * This function is used to save image html in the database
     * @param string $html
     * @return int
     */
    public function save_image($html) {
        $query = 'INSERT INTO ' . $this->table_design_images;
        $query .= ' SET html = "'. $html .'"';
        return $this->db_connection->insert($query);
    }

}

?>