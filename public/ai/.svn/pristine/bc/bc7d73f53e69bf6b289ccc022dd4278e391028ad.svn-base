<?php
/**
 * Product Class provides functions that simply perform the actions
 * like get total products, get product list, load product details, check duplicate
 * product name, delete product, etc.
 * @author     	: rasingh - Q3tech
 * @created on  : Aug 29, 2014
 * @modified on : Aug 29, 2014
 */
class Product {

	  private $db_connection            = NULL;
    private $table_product            = '';
    private $table_product_image      = '';
    private $table_product_detail     = '';
    private $table_product_reference  = '';
    private $table_manufacturer       = '';
    private $table_size               = '';
    private $table_plant              = '';
    private $table_texture            = '';
    private $table_color              = '';

  	/**
  	 * This is a constructor function where variables are intialized automatically
  	 * when object is created of this class
  	 * @param object $db_obj
  	 * @return null
  	 */
  	public function __construct($db_obj) {
    		$this->db_connection = $db_obj;
        $this->table_product = $this->db_connection->get_table_mapping('products');
        $this->table_product_image = $this->db_connection->get_table_mapping('product_images');
        $this->table_product_detail = $this->db_connection->get_table_mapping('product_details');
        $this->table_product_reference = $this->db_connection->get_table_mapping('product_references');
        $this->table_manufacturer = $this->db_connection->get_table_mapping('manufacturers');
        $this->table_size = $this->db_connection->get_table_mapping('sizes');
        $this->table_plant = $this->db_connection->get_table_mapping('plants');
        $this->table_texture = $this->db_connection->get_table_mapping('textures');
        $this->table_color = $this->db_connection->get_table_mapping('colors');
  	}

	  /**
     * This function is used to get count of total products
	   * @param string $search
     * @return int
     */
    public function get_total_products($search = '') {
		    $query  = "SELECT COUNT(prd.id) as cnt FROM ".$this->table_product ." as prd
          INNER JOIN ".$this->table_product_reference." as ref ON prd.id = ref.product_id
          INNER JOIN ".$this->table_manufacturer." as m ON ref.manufacturer_id = m.id
          INNER JOIN ".$this->table_size." as s ON ref.size_id = s.id
          INNER JOIN ".$this->table_plant." as p ON ref.plant_id = p.id
          INNER JOIN ".$this->table_texture." as t ON ref.texture_id = t.id
          INNER JOIN ".$this->table_color." as c ON ref.color_id = c.id";

		    if( $search != '' ) {
      			$query .= ' WHERE (prd.name LIKE "%'.$search.'%" OR
              prd.product_number LIKE "%'.$search.'%" OR
    				  prd.description LIKE "%'.$search.'%" OR
    				  prd.catalog LIKE "%'.$search.'%" OR
              m.name LIKE "%'.$search.'%" OR
              s.name LIKE "%'.$search.'%" OR
              p.name LIKE "%'.$search.'%" OR
              t.name LIKE "%'.$search.'%" OR
              c.name LIKE "%'.$search.'%" OR
              IF(prd.is_active=1,"'.t('Yes').'","'.t('No').'") LIKE "%'.$search.'%" )';
		    }
    		$result = $this->db_connection->sql_single_query($query);
    		return $result['cnt'];
	  }

	  /**
     * This function is used to get product list
	   * @param string $order_by_clause
	   * @param int $limit
	   * @param string $search
     * @return object
     */
    public function get_product_list($order_by_clause = ' id ASC', $limit = '',
    $search = '') {
		        $query = "SELECT prd.id, prd.name, prd.product_number,
            CONCAT(CONCAT(prd.length, '', prd.dimension_unit), ' * ',
              CONCAT(prd.breadth, '', prd.dimension_unit), ' * ',
              CONCAT(prd.width, '', prd.dimension_unit)) as dimension,
		        IF(prd_img.logo_image = '', '--',CONCAT('<img src=".'"'.PRODUCT_IMAGE_ROOT_PATH
		            ."/',prd.id,'/',prd_img.logo_image,'" .'" '. "width=".'"150"'." />') ) as image_path,
		        IF(prd.is_active = 1,'".t("Yes")."','".t("No")."') as IsActive,
            m.company as manufacturer, s.name as size, p.name as plant,
            t.name as texture, c.name as color
        		FROM ".$this->table_product ." as prd
            INNER JOIN ".$this->table_product_reference." as ref ON prd.id = ref.product_id
            INNER JOIN ".$this->table_manufacturer." as m ON ref.manufacturer_id = m.id
            INNER JOIN ".$this->table_size." as s ON ref.size_id = s.id
            INNER JOIN ".$this->table_plant." as p ON ref.plant_id = p.id
            INNER JOIN ".$this->table_texture." as t ON ref.texture_id = t.id
            INNER JOIN ".$this->table_color." as c ON ref.color_id = c.id
            INNER JOIN ".$this->table_product_image." as prd_img ON prd_img.product_id = prd.id";

    		if( $search != '' ) {
      			$query .= ' WHERE (prd.name LIKE "%'.$search.'%" OR
      				prd.product_number LIKE "%'.$search.'%" OR
      				prd.description LIKE "%'.$search.'%" OR
      				prd.catalog LIKE "%'.$search.'%" OR
              m.name LIKE "%'.$search.'%" OR
              s.name LIKE "%'.$search.'%" OR
              p.name LIKE "%'.$search.'%" OR
              t.name LIKE "%'.$search.'%" OR
              c.name LIKE "%'.$search.'%" OR
              IF(prd.is_active=1,"'.t('Yes').'","'.t('No').'") LIKE "%'.$search.'%" )';
    		}
		    $query .= " ORDER BY $order_by_clause $limit";

		    return $this->db_connection->select($query);
	  }

	  /**
     * This function is used to get product detail based on product id
	   * @param int $id
     * @return object
     */
    public function load_product_details($id = '') {
		    $query = 'SELECT prd.name,prd.image_path,prd.is_active,prd.product_number,
          prd.description,prd.catalog,prd.length,prd.breadth,prd.width,
          prd.dimension_unit,ref.manufacturer_id,ref.size_id, ref.plant_id,
          ref.texture_id,ref.color_id,pro_detail.leed_distance,
          pro_detail.recommended_cleaning,pro_detail.astm_type,
          pro_detail.master_format_2010,pro_detail.astm_specification,
          pro_detail.test_date,pro_detail.efflorescence,pro_detail.percent_void,
          pro_detail.min_thickness_of_face_shells,pro_detail.equivalent_web_thickness,
          pro_detail.recycled_content_percent,pro_detail.qty_per_sf,
          pro_detail.product_water_absorption_types,pro_detail.weight_pounds,
          pro_detail.compressive_strength_psi,pro_detail.specifications,
          pro_image.logo_image,pro_image.variant_image
          FROM '.$this->table_product .' as prd LEFT JOIN '.
          $this->table_product_reference . ' as ref ON prd.id=ref.product_id LEFT JOIN '.
          $this->table_product_detail .' as pro_detail ON prd.id=pro_detail.product_id LEFT JOIN '.
          $this->table_product_image .' as pro_image ON prd.id=pro_image.product_id';

        if( $id != '' ) {
    			 $query .= ' WHERE prd.id='.$this->db_connection->mysql_data_encode($id);
    		}
    		return $this->db_connection->sql_single_query($query);
  	}

	  /**
     * This function is used to check duplicate product name
	   * @param string $column_name
	   * @param string $data
	   * @param int $id
     * @return int
     */
    public function check_duplicate_column($column_name, $data, $id = '') {
    		$query = 'SELECT COUNT(*) AS cnt FROM '.$this->table_product.'
    			WHERE '.$column_name.'="' .$this->db_connection->mysql_data_encode($data).'"';

        if( $id != '' ) {
    			$query .= ' AND id != ' .$this->db_connection->mysql_data_encode($id);
    		}

    		$result = $this->db_connection->sql_single_query($query);
    		return $result['cnt'];
  	}

    /**
     * This function is used to check combination of duplicate product name and product references
     * @param array $references_arr
     * @return int
     */
    public function check_duplicate_product($references_arr) {
        $query = 'SELECT COUNT(*) AS cnt FROM '.$this->table_product_reference.' as ref
          INNER JOIN '.$this->table_product.' as prd ON ref.product_id = prd.id
          WHERE prd.name="'.$this->db_connection->mysql_data_encode($references_arr['name']).'"
          AND ref.manufacturer_id='.$this->db_connection->mysql_data_encode($references_arr['manufacturer_id']).'
          AND ref.size_id='.$this->db_connection->mysql_data_encode($references_arr['size_id']).'
          AND ref.plant_id='.$this->db_connection->mysql_data_encode($references_arr['plant_id']).'
          AND ref.texture_id='.$this->db_connection->mysql_data_encode($references_arr['texture_id']).'
          AND ref.color_id='.$this->db_connection->mysql_data_encode($references_arr['color_id']);

        if( $references_arr['product_id'] != '' ) {
            $query .= ' AND prd.id!= '.$this->db_connection->mysql_data_encode($references_arr['product_id']);
        }

        $result = $this->db_connection->sql_single_query($query);
        return $result['cnt'];
    }

	  /**
     * This function is used to save data into the database
	   * @param string $data_array
     * @return int
     */
    public function save_product_data($data_array) {
    		if( isset($data_array['pk'] ) ) {
    		    $query = 'UPDATE '.$this->table_product.' SET
              name="'.$this->db_connection->mysql_data_encode($data_array['name']).'",
    			    image_path="'.$this->db_connection->mysql_data_encode($data_array['image_path']).'",
    			    product_number="'.$this->db_connection->mysql_data_encode($data_array['product_number']).'",
    			    description="'.$this->db_connection->mysql_data_encode($data_array['description']).'",
    			    catalog="'.$this->db_connection->mysql_data_encode($data_array['catalog']).'",
    			    length="'.$this->db_connection->mysql_data_encode($data_array['length']).'",
    			    breadth="'.$this->db_connection->mysql_data_encode($data_array['breadth']).'",
    			    width="'.$this->db_connection->mysql_data_encode($data_array['width']).'",
    			    dimension_unit="'.$this->db_connection->mysql_data_encode($data_array['dimension_unit']).'",
              is_active="'.$this->db_connection->mysql_data_encode($data_array['is_active']).'",
              modified_by = '.$_SESSION['USER_ID'].',
              modified_at ="'.time().'"
    			    WHERE id='.$this->db_connection->mysql_data_encode($data_array['pk']);
    			  return $this->db_connection->edit($query);
    		}
        else {
    			$query = 'INSERT INTO '.$this->table_product.' (name,image_path,is_active,product_number,
            description,catalog,length,breadth,width,dimension_unit,created_by,created_at)
    			  VALUES("'
            .$this->db_connection->mysql_data_encode($data_array['name']).'","'
            .$this->db_connection->mysql_data_encode($data_array['image_path']).'","'
            .$this->db_connection->mysql_data_encode($data_array['is_active']).'","'
            .$this->db_connection->mysql_data_encode($data_array['product_number']).'","'
            .$this->db_connection->mysql_data_encode($data_array['description']).'","'
            .$this->db_connection->mysql_data_encode($data_array['catalog']).'","'
            .$this->db_connection->mysql_data_encode($data_array['length']).'","'
            .$this->db_connection->mysql_data_encode($data_array['breadth']).'","'
            .$this->db_connection->mysql_data_encode($data_array['width']).'","'
            .$this->db_connection->mysql_data_encode($data_array['dimension_unit']).'",'
            .$_SESSION['USER_ID'].',"'.time().'")';
    			return $this->db_connection->insert($query);
    		}
	  }

    /**
     * This function is used to save the reference data into database
     * @param string $data_array
     * @return int
     */
    public function save_product_references_data($data_array) {
        if( isset($data_array['pk']) ) {
            $query = 'UPDATE '.$this->table_product_reference.' SET
              manufacturer_id='.$this->db_connection
                  ->mysql_data_encode($data_array['manufacturer_id']).',
              size_id='.$this->db_connection
                  ->mysql_data_encode($data_array['size_id']).',
              plant_id='.$this->db_connection
                  ->mysql_data_encode($data_array['plant_id']).',
              texture_id='.$this->db_connection
                  ->mysql_data_encode($data_array['texture_id']).',
              color_id='.$this->db_connection
                  ->mysql_data_encode($data_array['color_id']).',
              has_image="'.$this->db_connection
                  ->mysql_data_encode($data_array['has_image']).'",
              modified_by = '.$_SESSION['USER_ID'].',
              modified_at ="'.time().'"
              WHERE product_id='.$this->db_connection->mysql_data_encode($data_array['pk']);
            return $this->db_connection->edit($query);
        }
        else {
            $query = 'INSERT INTO '.$this->table_product_reference.' (manufacturer_id,size_id,
              plant_id,texture_id,color_id,product_id,has_image,created_by,created_at)
              VALUES('
              .$this->db_connection->mysql_data_encode($data_array['manufacturer_id']).','
              .$this->db_connection->mysql_data_encode($data_array['size_id']).','
              .$this->db_connection->mysql_data_encode($data_array['plant_id']).','
              .$this->db_connection->mysql_data_encode($data_array['texture_id']).','
              .$this->db_connection->mysql_data_encode($data_array['color_id']).','
              .$this->db_connection->mysql_data_encode($data_array['product_id']).',"'
              .$this->db_connection->mysql_data_encode($data_array['has_image']).'",'
              .$_SESSION['USER_ID'].',"'.time().'")';
            return $this->db_connection->insert($query);
        }
    }

    /**
     * This function is used to save product optional details into the database
     * @param string $data_array
     * @return int
     */
    public function save_product_details_data($data_array) {
        if( isset($data_array['pk']) ) {
            $query = 'UPDATE '.$this->table_product_detail.' SET
              leed_distance="'.$this->db_connection
                  ->mysql_data_encode($data_array['leed_distance']).'",
              recommended_cleaning="'.$this->db_connection
                  ->mysql_data_encode($data_array['recommended_cleaning']).'",
              astm_type="'.$this->db_connection
                  ->mysql_data_encode($data_array['astm_type']).'",
              master_format_2010="'.$this->db_connection
                  ->mysql_data_encode($data_array['master_format_2010']).'",
              astm_specification="'.$this->db_connection
                  ->mysql_data_encode($data_array['astm_specification']).'",
              test_date="'.$this->db_connection
                  ->mysql_data_encode($data_array['test_date']).'",
              efflorescence="'.$this->db_connection
                  ->mysql_data_encode($data_array['efflorescence']).'",
              percent_void="'.$this->db_connection
                  ->mysql_data_encode($data_array['percent_void']).'",
              min_thickness_of_face_shells="'.$this->db_connection
                  ->mysql_data_encode($data_array['min_thickness_of_face_shells']).'",
              equivalent_web_thickness="'.$this->db_connection
                  ->mysql_data_encode($data_array['equivalent_web_thickness']).'",
              recycled_content_percent="'.$this->db_connection
                  ->mysql_data_encode($data_array['recycled_content_percent']).'",
              qty_per_sf="'.$this->db_connection
                  ->mysql_data_encode($data_array['qty_per_sf']).'",
              product_water_absorption_types="'.$this->db_connection
                  ->mysql_data_encode($data_array['product_water_absorption_types']).'",
              weight_pounds="'.$this->db_connection
                  ->mysql_data_encode($data_array['weight_pounds']).'",
              compressive_strength_psi="'.$this->db_connection
                  ->mysql_data_encode($data_array['compressive_strength_psi']).'",
              specifications="'.$this->db_connection
                  ->mysql_data_encode($data_array['specifications']).'",
              modified_by = '.$_SESSION['USER_ID'].',
              modified_at ="'.time().'"
              WHERE product_id='.$this->db_connection->mysql_data_encode($data_array['pk']);
            return $this->db_connection->edit($query);
        }
        else {
            $query = 'INSERT INTO '.$this->table_product_detail.' (product_id,leed_distance,recommended_cleaning,
              astm_type,master_format_2010,astm_specification,test_date,efflorescence,percent_void,
              min_thickness_of_face_shells,equivalent_web_thickness,recycled_content_percent,qty_per_sf,
              product_water_absorption_types,weight_pounds,compressive_strength_psi,specifications,
              created_by,created_at)
              VALUES('
              .$this->db_connection->mysql_data_encode($data_array['product_id']).',"'
              .$this->db_connection->mysql_data_encode($data_array['leed_distance']).'","'
              .$this->db_connection->mysql_data_encode($data_array['recommended_cleaning']).'","'
              .$this->db_connection->mysql_data_encode($data_array['astm_type']).'","'
              .$this->db_connection->mysql_data_encode($data_array['master_format_2010']).'","'
              .$this->db_connection->mysql_data_encode($data_array['astm_specification']).'","'
              .$this->db_connection->mysql_data_encode($data_array['test_date']).'","'
              .$this->db_connection->mysql_data_encode($data_array['efflorescence']).'","'
              .$this->db_connection->mysql_data_encode($data_array['percent_void']).'","'
              .$this->db_connection->mysql_data_encode($data_array['min_thickness_of_face_shells']).'","'
              .$this->db_connection->mysql_data_encode($data_array['equivalent_web_thickness']).'","'
              .$this->db_connection->mysql_data_encode($data_array['recycled_content_percent']).'","'
              .$this->db_connection->mysql_data_encode($data_array['qty_per_sf']).'","'
              .$this->db_connection->mysql_data_encode($data_array['product_water_absorption_types']).'","'
              .$this->db_connection->mysql_data_encode($data_array['weight_pounds']).'","'
              .$this->db_connection->mysql_data_encode($data_array['compressive_strength_psi']).'","'
              .$this->db_connection->mysql_data_encode($data_array['specifications']).'",'
              .$_SESSION['USER_ID'].',"'.time().'")';
            return $this->db_connection->insert($query);
        }
    }

    /**
     * This function is used to save product images data into the database
     * @param string $data_array
     * @return int
     */
    public function save_product_images_data($data_array) {
        if( isset($data_array['pk']) ) {
            $query = 'UPDATE '.$this->table_product_image.' SET
              logo_image="'.$this->db_connection
                  ->mysql_data_encode($data_array['logo_image']).'",
              variant_image="'.$this->db_connection
                  ->mysql_data_encode($data_array['variant_image']).'",
              modified_by = '.$_SESSION['USER_ID'].',
              modified_at ="'.time().'"
              WHERE product_id='.$this->db_connection->mysql_data_encode($data_array['pk']);
            return $this->db_connection->edit($query);
        }
        else {
          $query = 'INSERT INTO '.$this->table_product_image.' (product_id,image_initial_text,logo_image,
            variant_image,created_by,created_at)
            VALUES('
            .$this->db_connection->mysql_data_encode($data_array['product_id']).',"'
            .$this->db_connection->mysql_data_encode($data_array['image_initial_text']).'","'
            .$this->db_connection->mysql_data_encode($data_array['logo_image']).'","'
            .$this->db_connection->mysql_data_encode($data_array['variant_image']).'",'
            .$_SESSION['USER_ID'].',"'.time().'")';
        return $this->db_connection->insert($query);
        }
    }

	  /**
     * This function is used to delete product
	   * @param int $id
     * @return null
     */
  	public function delete_product($id){
    		// Delete product detail
        $query  = 'DELETE FROM '.$this->table_product_detail;
        $query .= ' WHERE product_id = "'.$id.'"';
        $this->db_connection->delete($query);

        // Detail product reference
        $query  = 'DELETE FROM '.$this->table_product_image;
        $query .= ' WHERE product_id = "'.$id.'"';
        $this->db_connection->delete($query);

        // Detail product reference
        $query  = 'DELETE FROM '.$this->table_product_reference;
        $query .= ' WHERE product_id = "'.$id.'"';
        $this->db_connection->delete($query);

        // Delete Product
        $query  = 'DELETE FROM '.$this->table_product;
        $query .= ' WHERE id = "'.$id.'"';
        $this->db_connection->delete($query);
  	}

}
?>