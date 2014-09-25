<?php

/**
 * The purpose of this class is to generate image pieces by slicing the image
 * specified by coordinate x,y and width,heigth
 * @author 		: rasingh - Q3tech
 * @created on 	: Sep 18, 2014
 * @modified on : Sep 22, 2014
 */

class Slicer {
	var $picture			= 	"";
	var $pic_width			= 	0;
	var	$pic_height			=	0;
	var $slice_hor			= 	0;
	var	$slice_ver			=	0;

	function Slicer() {
	}

	function set_picture($pic) {

		$this->picture = $pic;

	}

	function get_width() {
		return $this->pic_width;

	}

	function set_slicing($horizontal,$vertical) {

		$this->slice_hor = $horizontal;
		$this->slice_ver = $vertical;

	}

	function show_slice($image_prefix,$n) {
		/* make it not case sensitive*/
		//$this->img_type = strtolower($type);


		$picture = $this->prepare_pieces($n,$image_prefix);

		/* show the images  */			
		/*switch($this->img_type){
			case 'jpeg' :
			case 'jpg' 	:
				header("Content-type: image/jpeg");
				imagejpeg($picture);
				break;
			case 'gif' :
				header("Content-type: image/gif");
				imagegif($picture);
				break;
			case 'png' :
				header("Content-type: image/png");
				imagepng($picture);
				break;
			case 'wbmp' :
				header("Content-type: image/vnd.wap.wbmp");
				imagewbmp($picture);
				break;
		}*/

	}


	function load_picture() {

		/* pick picture you want to frame  */
		if(file_exists($this->picture)) {

			$extension = $this->get_imagetype($this->picture);

			/* create image source from your image strip stock */
			switch($extension){
				case 'jpeg' :
				case 'jpg' 	:
					$img_picture 	= @imagecreatefromjpeg ($this->picture);
					break;
				case 'gif' :
					$img_picture 	= @imagecreatefromgif ($this->picture);					
					break;
				case 'png' :
					$img_picture 	= @imagecreatefrompng ($this->picture);	
					break;
			}

		} else {
			/* if fail to load image file, create it on the fly */
			$img_picture 	= $this->draw_picture();
		}

		return $img_picture;
		//imagedestroy( $img_picture );
	}

	function draw_picture() {

		if($this->img_image) {
		
			return $this->img_image;
		
		} else {		
			if(!$this->pic_height)
				$this->set_slicing(300,200);
	
			$img_picture    = imagecreatetruecolor($this->pic_width, $this->pic_height);
			$bg_color		= imagecolorallocate ($img_picture, 200, 200, 200);
			imagefill ( $img_picture, 0, 0, $bg_color );
		}
		return $img_picture;
	}

	function set_image($image) {
	
		$this->img_image = $image;
	
	}

	function get_imagetype($file) {

		$acceptable = array("jpg","jpeg","gif","png");
		/* ask the image type */
		$file_info  = pathinfo($file);
		$extension  = $file_info["extension"];
		
		if(in_array($extension,$acceptable))
			return $extension;
		else
			return null;
	}

	function prepare_pieces($n,$image_prefix) {		

		$img_picture		= 	$this->load_picture(); 

 		$this->pic_width 	= 	imagesx($img_picture); 
		$this->pic_height 	= 	imagesy($img_picture); 

		/* slice into hor x ver pieces */
		$slice_width	= $this->pic_width/$this->slice_hor;
		$slice_height	= $this->pic_height/$this->slice_ver;

		$x 				= 0;
		$y				= 0;
		$w				= $slice_width;
		$h				= $slice_height;
		$k=1;
		for($i=0 ; $i<$this->slice_ver ; $i++){
			for($j=0 ; $j<$this->slice_hor ; $j++){
				if($k==$n)
					$img_piece	= $this->slice_image($img_picture,$x,$y,$w,$h,$image_prefix,$k);
				$x	= $x + $w;
				$k++;
			}
			$x = 0;
			$y = $y + $h;

 		}
		return $img_piece;

	}

    function slice_image($img_src, $x, $y, $width, $height,$image_name,$number) {
   		$image_v = $image_name .'_v_'.$number.'.jpg';
   		$image_h = $image_name .'_r_'.$number.'.jpg';
   		$image_hd = $image_name .'_h_'.$number.'.jpg';
   		
		$img_slice = imagecreatetruecolor($width-8, $height-8);
		imagecopyresampled($img_slice, $img_src, 0, 0, $x+4, $y+4, $width-8, $height-8, $width-8, $height-8);
		imagejpeg($img_slice,$image_v);  // Save slice image as jpg format
				
		// Vreate header image
		$n_width = (($width-8)/2)-4;
		system("convert ".$image_v." -rotate 90 ".$image_h ." && "." convert ".$image_v." -crop ".$n_width."x".($height-8)."+0+0 ".$image_hd);	
		
        return $img_slice;
		//imagedestroy( $img_slice );
    }

}
?>