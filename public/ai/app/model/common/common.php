<?php
class common {

	private $db_connection = NULL;
    private $system_logs = '';
    private $users = '';
    public function __construct($db_obj) {
       $this->db_connection = $db_obj;
       $this->system_logs = $this->db_connection->get_table_mapping('system_logs');
       $this->users = $this->db_connection->get_table_mapping('users');
    }
    /*
     * THIS FUNCTION IS USED TO ADD DATA FOR SYSTEM LOGS
     * */
    public function add_system_log_data($input){
      $query = 'INSERT INTO '.$this->system_logs;
      $query .= ' (IP,user_agent,operation_performed,module_name,id_range,
				   total_imported,created_by,created_at)';
      $query .= ' VALUES ';
      $query .= '(';
      $query .= '"'.$input['IP'].'",';
      $query .= '"'.$input['USER_AGENT'].'",';
      $query .= '"'.$input['OPERATION'].'",';
      $query .= '"'.$input['MODULE'].'",';
      $query .= '"'.$input['ID_RANGE'].'",';
      $query .= '"'.$input['TOTAL_IMPORTED'].'",';
      $query .= '"'.$input['CREATED_BY'].'",';
      $query .= '"'.$input['CREATED_AT'].'"';
      $query .= ')';

      $this->db_connection->insert($query);
    }
    /*
     * THIS FUNCTION IS USED TO GET TOTLA NO. OF SYSTEM LOGS*/
    public function get_total_system_logs($operation = '') {
        $query = 'SELECT
                        COUNT(s.id) AS cnt
                  FROM
                       ' . $this->system_logs.' as s,'.$this->users.' as u
                  WHERE u.id = s.created_by';
        if ($operation != '') {
            $query .= ' AND
                            (
                              s.operation_performed LIKE "%' . $operation . '%"
                            )
                    ';
        }
        $result = $this->db_connection->sql_single_query($query);
        return $result['cnt'];
    }

    public function get_system_log_list($orderByClause = ' supplier_name ASC',
    	$limit = '', $operation = '') {
        $query = 'SELECT
                         s.*,u.user_name
                  FROM
                       ' . $this->system_logs.' as s,'.$this->users.' as u
                  WHERE u.id = s.created_by';
        if ($operation != '') {
            $query .= ' AND
                            (
                              s.operation_performed LIKE "%' . $operation . '%"
                            )
                    ';
        }
        $query .= " ORDER BY $orderByClause $limit";
        return $this->db_connection->select($query);
    }

    public function get_system_user_ids($ids = '') {
        $query = 'SELECT
                         u.id,u.user_name
                  FROM
                       ' . $this->users.' as u';
        if ($ids != '') {
            $query .= ' WHERE
                            (
                              u.id IN ('.$ids.')
                            )
                    ';
        }
        return $this->db_connection->select($query,2);
    }

	/*THIS FUNCTION IS USED TO GENERATE UNIQUE STRING*/
	public function generate_unique_string(){
	    $random = substr(number_format(time() * rand(),0,'',''),
            0,UNIQUE_STRING_LENGTH);
      return $random;
    }


    public function getMasterData(
            $tbl_name,
            $tbl_columns,
            $orderby = '',
            $conditions = '',
            $groupby='') {
        $table = $this->db_connection->get_table_mapping($tbl_name);
        $columns = '';
        if(is_array($tbl_columns)) {
            foreach ($tbl_columns as $column) {
                if(empty($columns)) {
                    $columns = $column;
                } else {
                    $columns .= ', '.$column;
                }
            }
        } else {
            $columns = $tbl_columns;
        }
        $where = '';
        if(!empty($conditions)) {
            if(is_array($conditions)) {
                foreach ($conditions as $column => $value) {
                    if(empty($where)) {
                        $where = ' WHERE '.$column.'="'.$value.'"';
                    } else {
                        $where .= ' AND '.$column.'="'.$value.'"';
                    }
                }
            } else {
                $where = ' '.$conditions;
            }
        }
        if(!empty($groupby)) {
            $groupby = ' GROUP BY '.$groupby;
        }
        if(!empty($orderby)) {
            $orderby = ' ORDER BY '.$orderby;
        }
        $query = 'SELECT '.$columns.'
                FROM '.$table.$where.$groupby.$orderby;

        $list = $this->db_connection->select($query);
        if(empty($list)) {
            return FALSE;
        } else {
            return $list;
        }
    }

}

?>