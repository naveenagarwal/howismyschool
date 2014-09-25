<?php

/**
 *
 * This is a library which uses Phantom JS to create image files.
 * Images are created via PHP command line.
 * @author      : dbaveja - Q3tech
 * @created on  : Sep 05, 2014
 * @modified on : Sep 05, 2014
 */
class DesignImage {
    private $format = 'jpg';
    private $image_raw_name = NULL;

    /**
     * This is a constructor function where variables are intialized automatically
     * when object is created of this class
     * @param string $format
     * @return null
     */
    public function __construct($format) {
        $this->format = $format;
        $this->image_raw_name = time();
    }

    /**
     * This function is used to get the link of the image created from Phantom JS
     * @param int $id
     * @return array
     */
    public function create_design_image($id) {
        $design = array();
        $link = $this->create_image_from_html($id);
        if( $link ) {
            $design["design_created"] = true;
            $design["design_image_link"] = $link;
        }
        else {
            $design["design_created"] = false;
            $design["message"] = "failed to create image";
        }
        return $design;
    }

    /**
     * This is a private method that creates an image using Phantom JS via command line
     * @param int $id
     * @return string
     */
    private function create_image_from_html($id) {
        $phantomjs = "/var/www/html/phantomjs/bin/phantomjs";
        $rasterizejs = CUSTOMDIR."/assets/js/accurate-image/rasterize.js";
        $url = URLADDR."create-wall/DesignImage?id=".$id;
        $image_path = CUSTOMDIR."/media/designs/";
        $image_name = $this->image_raw_name.".png";
        $image_full_path = $image_path.$image_name;

        $phantom_screen_capture_command = $phantomjs." ".$rasterizejs." ".$url." ".$image_full_path;
        system($phantom_screen_capture_command);
        system('convert '.$image_full_path.' -trim +repage '.$image_full_path);

        if($this->format != "png"){
            system('convert '.$image_full_path.' '.explode(".", $image_full_path)[0].".".$this->format);
        }

        return URLADDR."media/designs/".explode(".", $image_name)[0].".".$this->format;
    }
}

?>