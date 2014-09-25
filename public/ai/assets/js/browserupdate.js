/*
 * Browser-Update.org JavaScript
 * http://browser-update.org/
 */

var $buoop = {vs:{i:7,f:3,o:10.01,s:3,n:9}} 
$buoop.ol = window.onload; 
window.onload=function(){ 
 if ($buoop.ol) $buoop.ol(); 
 var e = document.createElement("script"); 
 e.setAttribute("type", "text/javascript"); 
 e.setAttribute("src", "http://browser-update.org/update.js"); 
 document.body.appendChild(e); 
}