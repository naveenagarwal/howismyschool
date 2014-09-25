<?php
/**
 * This class is used to display top navigation based on user's role
 * @author 		: rasingh - Q3tech
 * @created on 	: Aug 25, 2014
 * @modified on : Aug 27, 2014
 */
require_once('../app/model/user-roles/permission.php');
$model_permission_obj = new permission($db_obj);
class Menu{

	private $login_connection = NULL;

	/**
	 *
	 * This is a constructor function where variables are intialized automatically
	 * when object is created of this class
	 * @param string $login
	 * @return null
	 */
 	public function __construct($login){
		$this->login_connection = $login;
    }

	/**
	 * This function is used to create dynamic menu
     * 1 = top menu,2 = grouped,3 = actual menu,4=actual sub-menus
	 *
	 * @param	array $module_id
	 * @param	string $exclude_menu
	 * @return	string $html
	 */
    public function build_menu_items($module_id = array(),$exclude_menu = ''){
        $module_id = $module_id;
        $model_permission_obj = $GLOBALS['model_permission_obj'];
        if($_SESSION['USER_ID']!=''){//get logged-in user details
            $user_details = $this->login_connection->get_user_details($_SESSION['USER_ID']);
        }
        $model_permission_obj->set_permission_data();
        $exclude_menu  = $_SESSION['USER_EXCLUDE_MENU'];
        $module_codes = $_SESSION['USER_ALLOWED_MENU'];

        $menu_types = TOP_MENU.','.GROUPED_MENU.','.ACTUAL_MENU.','.SUB_ACTUAL_MENU;
        $menu_array = $model_permission_obj->get_menus($module_codes,$menu_types);

        $top_menu_array = array();
        $grouped_menu_array = array();
        $actual_menu_array = array();
        $top = 0;
        $grouped=0;
        $actual=0;
        //set menu names in session
        $menu_names_array = array();
        $menu_path_array = array();
        foreach($menu_array as $value){
            $menu_names_array[$value['menu_url']] = $value['menu_name'];
            if($exclude_menu!=''){
                if(stristr($value['menu_code'], $exclude_menu)){
                    continue;
                }
            }
            $menu_path_array[] = $value['menu_url'];
            if($value['menu_url'] =='HOME'){
                $value['menu_url'] = URL;
            }
            else if($value['menu_url']!='' and $value['menu_url']!='#'){
                $value['menu_url'] = URL.''.$value['menu_url'];
            }
            else{
                $value['menu_url'] = 'javascript:void(0);';
            }
            switch ($value['menu_type']) {
                case TOP_MENU:
                    $top_menu_array[$top]['id'] = $value['id'];
                    $top_menu_array[$top]['menu_name'] = $value['menu_name'];
                    $top_menu_array[$top]['menu_url'] = $value['menu_url'];
                    $top_menu_array[$top]['menu_description'] = $value['menu_description'];
                    $top_menu_array[$top]['Image'] = $value['menu_image_path'];
                    $top++;
                    break;
                case GROUPED_MENU:
                    $grouped_menu_array[$grouped]['parent_menu_id'] = $value['parent_menu_id'];
                    $grouped_menu_array[$grouped]['id'] = $value['id'];
                    $grouped_menu_array[$grouped]['menu_name'] = $value['menu_name'];
                    $grouped_menu_array[$grouped]['menu_url'] = $value['menu_url'];
                    $grouped++;
                    break;
                case ACTUAL_MENU:
                    $actual_menu_array[$actual]['parent_menu_id'] = $value['parent_menu_id'];
                    $actual_menu_array[$actual]['id'] = $value['id'];
                    $actual_menu_array[$actual]['menu_name'] = $value['menu_name'];
                    $actual_menu_array[$actual]['menu_url'] = $value['menu_url'];
                    $actual++;
                    break;
            }
        }
        $_SESSION['ALLOWED_MENU_PATH_ARRAY'] = $menu_path_array;
        $html = '';
        $dashboard_html .= $this->get_dashboard_html($user_details);
        $return_array = $this->build_menu_items_html($top_menu_array,$grouped_menu_array,$actual_menu_array);
        $html .= $return_array['HTML'];
        $dashboard_html .= $return_array['DHTML'];
        $dashboard_html .= '</div>';
        $dashboard_html .= '<div class="clr"></div>';

        $_SESSION['MENU_NAMES_ARRAY'] = $_SESSION['MENU_NAMES_ARRAY']
        = $menu_names_array;
        $_SESSION['USER_DASHBOARD_HTML'] = $_SESSION['USER_DASHBOARD_HTML']
        = $dashboard_html;
        $_SESSION['MENU_HTML'] = $html;
        $html //add link to dashboard
        = '<li class=""><a href="'.URL.'dashboard">'.t('Home').'</a></li>'
        .$html;
        return $html;
    }

	/**
	 * This function is used to check sub menu
	 *
	 * @param	int $id
	 * @param	array $grouped_menu_array
	 * @return	bool true / false
	 */
    public  function has_child_menu($id,$grouped_menu_array){
        foreach ($grouped_menu_array as $group_menu) {
            if($group_menu['parent_menu_id'] == $id){
             return true;
            }
        }
        return false;
    }

	/**
	 * This function is used to create menu items as html
	 *
	 * @param	array $top_menu_array
	 * @param	array $grouped_menu_array
	 * @param	array $actual_menu_array
	 * @return	array
	 */
    public function build_menu_items_html($top_menu_array,$grouped_menu_array,
        $actual_menu_array){
        $html = '';
        $dashboard_html = '';
        //get all parent menu of grouped menus
        $parent_ids = array_unique(explode(',',
        create_comma_separated_list($grouped_menu_array,
        'parent_menu_id',2,0)));
        foreach ($top_menu_array as $top_menu) {
            $parent_li_class = in_array($top_menu['id'], $parent_ids)
            ? 'class="dropdown"' : '';
            $parent_anchor_class_toggle = in_array($top_menu['id'], $parent_ids)
            ? 'class="dropdown-toggle"  data-toggle="dropdown"' : '';
            $html .= '<li '.$parent_li_class.'>';
            $caret = '';
            if($this->has_child_menu($top_menu['id'],$grouped_menu_array)){
              $caret = '<b class="caret"></b>';
            }
            $html .= '<a href="'.$top_menu['menu_url'].'"
            '.$parent_anchor_class_toggle.'>'.t($top_menu['menu_name'])
            .$caret.'</a>';
            if($top_menu['menu_url'] != URL){//excluding home
                $dashboard_html .= '<div class="lt_cont">
                                <h3>'.t($top_menu['menu_name']).'</h3>
                                <p><img src="'.IMAGE_URL.'/'.$top_menu['Image']
                                .'" alt="Lisa" />
                                 '.$top_menu['menu_description'].'
                                </p>';
            }
            $group_html  = '';
            $group_html2 = '';

            foreach ($grouped_menu_array as $group_menu) {

                if($group_menu['parent_menu_id'] == $top_menu['id']){
                    $group_html .= '<li>';
                    $group_html .= '<a  href="'.$group_menu['menu_url'].'">'
                    .t($group_menu['menu_name']).'</a>';
                    $actual_html = '';
                    foreach ($actual_menu_array as $actual_menu) {
                        if($actual_menu['parent_menu_id'] == $group_menu['id']){
                            $actual_html .= '<li>';
                            $actual_html .= '<a class="cMenu"
                            href="'.$actual_menu['menu_url'].'">
                            '.t($actual_menu['menu_name']).'</a>';
                            $actual_html .= '</li>';
                        }
                    }
                    if($actual_html!=''){
                        $actual_html = '<ul>'.$actual_html.'</ul>';
                    }
                    $group_html .= $actual_html;
                    $group_html .= '</li>';
                }
            }

            if($group_html!=''){
                $group_html = '<ul class="dropdown-menu">'.$group_html.'</ul>';
                $group_html2 = $group_html;
            }else{
                $group_html2 = '<ul><li class="mMenu"><a
                href="'.$top_menu['menu_url'].'">'
                .t($top_menu['menu_name']).'</a></li></ul>';
            }

            $html .= $group_html;
            $html .= '</li>';

            if($top_menu['menu_url'] != URL){
                $dashboard_html .= $group_html2;
                $dashboard_html .= '</div>';
            }
        }
        return array('HTML'=>$html,'DHTML'=>$dashboard_html);
    }

	/**
	 * This function is used to create user dashboard
	 *
	 * @param	array $user_details
	 * @return	string $dashboard_html
	 */
    public function get_dashboard_html($user_details){
        $dashboard_html .= '<div class="dash_container">';

        $dashboard_html .= '
                        <div class="lt_cont">
                        <h3>'.t('Profile').'</h3>
                        <table width="100%" border="0" cellspacing="0"
                        cellpadding="3">
                          <tr>
                            <td>'.t('Role').' : </td>
                            <td>'.$user_details['role_name'].'</td>
                            <td>&nbsp;</td>
                            <td>'.t('Name').' : </td>
                            <td>'.$user_details['full_name'].'</td>
                          </tr>
                          <tr>
                            <td>'.t('Address').' : </td>
                            <td colspan="4">
                            '.substr($user_details['address'],0,70).'</td>
                          </tr>
                          <tr>
                            <td>'.t('Email').' : </td>
                            <td>'.$user_details['email_id'].'</td>
                            <td>&nbsp;</td>
                            <td>'.t('Contact No.').' : </td>
                            <td>'.$user_details['contact_no'].'</td>
                          </tr>
                          <tr>
                            <td colspan="5" style="text-align:right;
                            padding-right:40px;">
                              <a href="'.URL.'user-roles/users/profile-edit&Id='
                              .$user_details['id'].'&rurl='.
                              $_SERVER['QUERY_STRING'].'">
                              Edit Profile</a></td>
                            <td></td>
                          </tr>
                        </table>

                        </div>';
        return $dashboard_html;
    }

	/**
	 * This function is used to display permission items
	 *
	 * @param	array $module_id
	 * @param	array $current_val_array
	 * @return	string $html
	 */
    public function build_permission_display_items($module_id = array(),
        $current_val_array= array()){
        $model_permission_obj = $GLOBALS['model_permission_obj'];
        $module_ids = '';
        if(count($module_id)){
            $module_ids = implode(',', $module_id);
        }

        $menu_types = DASHBOARD_MENU.','.TOP_MENU.','.GROUPED_MENU.','
        .ACTUAL_MENU.','.SUB_ACTUAL_MENU;
        $menu_array = $model_permission_obj->get_menus($module_ids,$menu_types);

        $top_menu_array = array();
        $grouped_menu_array = array();
        $actual_menu_array = array();
        $top = 0;
        $grouped=0;
        $actual=0;
        $menu_names_array = array();
        foreach($menu_array as $value){
            if($value['menu_code'] == 'HOME'){
                continue;
            }
            $menu_names_array[$value['menu_url']] = $value['menu_name'];
            switch ($value['menu_type']) {
                case TOP_MENU:
                case DASHBOARD_MENU:
                    $top_menu_array[$top]['id'] = $value['id'];
                    $top_menu_array[$top]['menu_name'] = $value['menu_name'];
                    $top_menu_array[$top]['menu_code'] = $value['menu_code'];
                    $top++;
                    break;
                case GROUPED_MENU:
                    $grouped_menu_array[$grouped]['parent_menu_id']
                    = $value['parent_menu_id'];
                    $grouped_menu_array[$grouped]['id'] = $value['id'];
                    $grouped_menu_array[$grouped]['menu_name']
                    = $value['menu_name'];
                    $grouped_menu_array[$grouped]['menu_code']
                    = $value['menu_code'];
                    $grouped++;
                    break;
                case ACTUAL_MENU:
                case SUB_ACTUAL_MENU:
                    $actual_menu_array[$actual]['parent_menu_id']
                    = $value['parent_menu_id'];
                    $actual_menu_array[$actual]['id'] = $value['id'];
                    $actual_menu_array[$actual]['menu_name']
                    = $value['menu_name'];
                    $actual_menu_array[$actual]['menu_code']
                    = $value['menu_code'];
                    $actual_menu_array[$actual]['menu_usage']
                    = $value['menu_usage'];
                    $actual++;
                    break;
            }
        }
        $html = '';
        $html .= $this->build_permission_display_items_html($top_menu_array,
        $grouped_menu_array,$actual_menu_array,$current_val_array);
        if($html ==''){
            $html = '<div class="menuaccessdenied">'.
            t("No permission items found").'</div>';
        }
        return $html;
    }

	/**
	 * This function is used to display permission items as a html
	 *
	 * @param	array $top_menu_array
	 * @param	array $grouped_menu_array
	 * @param	array $actual_menu_array
	 * @param	array $current_val_array
	 * @return	string $html
	 */
    public function build_permission_display_items_html($top_menu_array,
        $grouped_menu_array,$actual_menu_array,$current_val_array = array()){
        $html = '';
        foreach ($top_menu_array as $top_menu) {

            $html .= '<h3 class="pTEntry">'.t($top_menu['menu_name']).'</h3>';
            $html .= '<div class="slimDiv">';
            $group_html = '';
            $topmenu_code = $top_menu['menu_code'];
            foreach ($grouped_menu_array as $group_menu) {
                if($group_menu['parent_menu_id'] == $top_menu['id']){
                    $groupmenu_code = $group_menu['menu_code'];
                    $group_html .= '<li class="bg_clr_li">';
                    $group_html .= '<span class="pMEntry">'.
                    t($group_menu['menu_name']).'</span>';
                    $actual_html = '';
                    foreach ($actual_menu_array as $actual_menu) {
                        if($actual_menu['parent_menu_id'] == $group_menu['id']){
                            $actualmenu_code = $actual_menu['menu_code'];
                            $actual_html .= '<li>';
                            $actual_html .= t($actual_menu['menu_name']);
                            $checked = '';
                            $val = $topmenu_code.'~'.$groupmenu_code
                            .'~'.$actualmenu_code;
                            if(in_array($val, $current_val_array)){
                                $checked = 'checked="checked"';
                            }
                            $actual_html .= '&nbsp;<input type="checkbox"
                            name="permissionChk[]" '.$checked.'
                            value="'.$val.'" />';
                            $actual_html .= '</li>';
                        }
                    }
                    if($actual_html!=''){
                        $actual_html = '<ul>'.$actual_html.'</ul>';
                    }else{
                        $checked = '';
                        $val = $topmenu_code.'~'.$groupmenu_code;
                        if(in_array($val, $current_val_array)){
                            $checked = 'checked="checked"';
                        }
                        $actual_html = '&nbsp;<input type="checkbox"
                        name="permissionChk[]" '.$checked.'
                        value="'.$val.'" />';
                    }
                    $group_html .= $actual_html;
                    $group_html .= '</li>';
                }
            }
            //for buttons
             $actual_html = '';
             foreach ($actual_menu_array as $actual_menu) {
                if($actual_menu['parent_menu_id'] == $top_menu['id']){
                    $actualmenu_code = $actual_menu['menu_code'];
                    $actual_html .= '<li>';
                    if($actual_menu['menu_usage'] == MENU_USAGE_BUTTON){
                    $actual_html .= '<span class="btn btn-success perm-btn">'
                    .t($actual_menu['menu_name']).'</span>';
                    }else{
                      $actual_html .= t($actual_menu['menu_name']);
                    }
                    $checked = '';
                    $val = $topmenu_code.'~'.$actualmenu_code;
                    if(in_array($val, $current_val_array)){
                        $checked = 'checked="checked"';
                    }
                    $actual_html .= '&nbsp;<input type="checkbox"
                    name="permissionChk[]" '.$checked.' value="'.$val.'" />';
                    $actual_html .= '</li>';
                }
             }
            if($group_html!=''){
                $group_html = '<ul>'.$group_html.'</ul>';
            }else{
                if($actual_html!=''){//for buttons
                    $group_html = '<ul>'.$actual_html.'</ul>';
                }else{
                    $checked = '';
                    $val = $topmenu_code;
                    if(in_array($val, $current_val_array)){
                        $checked = 'checked="checked"';
                    }
                    $group_html = t($top_menu['menu_name']).'&nbsp;
                    <input type="checkbox" name="permissionChk[]" '.$checked.'
                    value="'.$val.'" />';
                }
            }
            $html .= $group_html;
            $html .= '</div>';
        }
        if($html != ''){
           $html = '<div id="menuAccordion">'.$html.'</div>';
        }
        return $html;
    }
}
?>