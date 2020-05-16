/// @description
var _scale = 1;
draw_set_color(c_white);
var _str = "";
//_str += "Face Dir: "+string(character.face_dir);
//var _cam = ez3dcam_get_direction();
//_str += "\nCam Dir: "+string(point_direction(0,0,_cam[vX],_cam[vY]));
_str += "Move: Arrows";
_str += "\nCamera: A S D W";
_str += "\n\nReset: Backspace";
_str += "\nEnter: Next Demo";

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text_transformed_gpu(6,6,_str,_scale,_scale,0);
draw_set_color(c_white);
draw_text_transformed_gpu(5,5,_str,_scale,_scale,0);