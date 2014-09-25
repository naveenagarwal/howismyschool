<?php
/**
* Class cssmin
*/

class cssmin{
    
    public static function minify($css){
       // Remove comments
      $content 
      = preg_replace('!/\*[^*]*\*+([^/][^*]*\*+)*/!', '', $css);
      //Remove tabs, spaces, newlines, etc...
      $content 
      = str_replace(array("\r", "\n", "\t", '  ', '   '), '', $content);
      
      return $content;
    }
}