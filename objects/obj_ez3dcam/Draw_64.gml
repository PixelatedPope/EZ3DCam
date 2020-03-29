///// @description Draw Debug Text
/*exit;

var _scale = window_get_width()/display_get_gui_width();
_scale *=2;
draw_set_color(c_white);
var _str = "";

switch(camera_mode)
{
	case EZ3DCam.mode_first_person: _str+="First Person Camera"; break;
	case EZ3DCam.mode_track_target: _str+="Track Target Camera"; break;
	case EZ3DCam.mode_third_person: _str+="Third Person Camera"; break;
}
_str += "\n";
for(var _i=0; _i<array_length_1d(camera_direction); _i++)
{
	_str+="camera_direction["+string(_i)+"] = "+string(camera_direction[_i])+"\n";	
}

 _str+="X: "+string(camera_position[vX])+"\n"+
 			"Y: "+string(camera_position[vY])+"\n"+
 			"Z: "+string(camera_position[vZ])+"\n";

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text_transformed_gpu(6,21,_str
					,_scale,_scale,0);
draw_set_color(c_white);
draw_text_transformed_gpu(5,20,_str
					,_scale,_scale,0);
