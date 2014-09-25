<?php
/**
 * his class meant to generate sliced image that contained in a table
 * t can make your pictures smaller in each size.
 * @author 		: rasingh - Q3tech
 * @created on 	: Sep 19, 2014
 * @modified on : Sep 23, 2014
 */
class ImageSlicer {

	var $picture			= 	"";
	var $pic_width			= 	0;
	var	$pic_height			=	0;
	var $slice_hor			= 	0;
	var	$slice_ver			=	0;
	var $tbl_border			= 	0;
	var $image_prefix		= 	"";


	function ImageSlicer($picture,$hor,$ver,$image_prefix) {

		$this->picture			= 	$picture;

		$picinfo = @getimagesize ($picture);
   		if ($picinfo !== false) {
     		$pic_width = $picinfo [0];
		}

		$this->pic_width			= 	$pic_width;
		$this->slice_hor			= 	$hor;
		$this->slice_ver			=	$ver;
		$this->image_prefix			=	$image_prefix;

	}

	function set_border($border=0) {
		$this->tbl_border = $border;

	}

	function create_imageslice() {
		include("Slicer.php");
		$k=1;
		for($i=0 ; $i<$this->slice_ver ; $i++){  			
			for($j=0 ; $j<$this->slice_hor ; $j++){				
				$picture = $this->picture;
				$pie = $k;
				$hor = $this->slice_hor;
				$ver = $this->slice_ver;
				$image_prefix = $this->image_prefix;

				$slice = new Slicer();
				$slice->set_picture($picture);
				$slice->set_slicing($hor,$ver);
				$slice->show_slice($image_prefix,$pie);
				$k++;
			}
		}
		return true;
	}

	function show_image() {
		echo $this->create_imageslice();
	}

}

?>