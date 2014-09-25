<?php
/**
 *
 * The Product Management class provides functions that perform operations like
 * Listing Manufacturers, Sizes, Products, Product Information and many more
 * @author 		: dbaveja - Q3tech
 * @created on 	: Aug 22, 2014
 * @modified on : Aug 22, 2014
 */
class ProductManagement {
	private $db_connection = NULL;
	private $table_manufacturer = '';
	private $table_plant = '';
	private $table_size = '';
	private $table_color = '';
	private $table_texture = '';
	private $table_mortar = '';
	private $table_product = '';
	private $table_product_detail = '';
	private $table_product_water_absorption_type = '';

	/**
	 *
	 * This is a constructor function where variables are intialized automatically
	 * when object is created of this class
	 * @param object $db_obj
	 * @return null
	 */
	public function __construct($db_obj) {
		$this->db_connection = $db_obj;
		$this->table_manufacturer = $this->db_connection->get_table_mapping('manufacturers');
		$this->table_plant = $this->db_connection->get_table_mapping('plants');
		$this->table_size = $this->db_connection->get_table_mapping('sizes');
		$this->table_color = $this->db_connection->get_table_mapping('colors');
		$this->table_texture = $this->db_connection->get_table_mapping('textures');
		$this->table_mortar = $this->db_connection->get_table_mapping('mortars');
		$this->table_product = $this->db_connection->get_table_mapping('products');
		$this->table_product_detail = $this->db_connection->get_table_mapping('product_details');
		$this->table_product_water_absorption_type = $this->db_connection->
														get_table_mapping('product_water_absorption_types');
	}

	/**
	 *
	 * This function lists all the manufacturers
	 * @param void
	 * @return string
	 */
	public function get_manufacturers() {
		$query 	= "SELECT id, name, image_path FROM " . $this->table_manufacturer;
		$query .= " WHERE is_active = 1";
		return $this->db_connection->select($query);
	}

	/**
	 *
	 * This function lists all the sizes based on selected manufacturer
	 * @param array $list_ids 	list containing manufacturer id
	 * @return string
	 */
	public function get_sizes() {
		$query 	= "SELECT id, name, image_path FROM " . $this->table_size;
		$query .= " WHERE is_active = 1";
		return $this->db_connection->select($query);
	}

	/**
	 *
	 * This function lists all the plants based on selected manufacturer & size
	 * @param array $list_ids 	list containing manufacurer id & size id
	 * @return string
	 */
	public function get_plants($list_ids) {
		// Code here
	}

	/**
	 *
	 * This function lists all the colors based on selected manufacturer,
	 * size & plant
	 * @param array $list_ids 	list containing manufacurer id, size id & plant id
	 * @return string
	 */
	public function get_colors($list_ids) {
		// Code here
	}

	/**
	 *
	 * This function lists all the textures based on selected manufacturer,
	 * size, plant and color
	 * @param array $list_ids 	list containing manufacurer id, size id,
	 * plant id and color id
	 * @return string
	 */
	public function get_textures($list_ids) {
		// Code here
	}

	/**
	 *
	 * This function lists all the mortars
	 * @param void
	 * @return string
	 */
	public function get_mortars() {
		// Code here
	}

	/**
	 *
	 * This function lists all the textures based on selected manufacturer,
	 * size, plant, color and texture
	 * @param array $list_ids 	list containing manufacurer id, size id,
	 * plant id, color id and texture id
	 * @return string
	 */
	public function get_products($list_ids) {
		// Code here
	}

	/**
	 *
	 * This function provides all the product information based on selected product
	 * @param integer $product_id
	 * @return string
	 */
	public function get_product_info($product_id) {
		// Code here
	}


}

?>