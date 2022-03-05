///// @description Draw Debug Text
/*exit;

var _scale = window_get_width()/display_get_gui_width();
_scale *=2;
draw_set_color(c_white);
var _str = "";

switch(mode)
{
	case EZ3DCam.mode_first_person: _str+="First Person Camera"; break;
	case EZ3DCam.mode_track_target: _str+="Track Target Camera"; break;
	case EZ3DCam.mode_third_person: _str+="Third Person Camera"; break;
}
_str += "\n";
for(var _i=0; _i<array_length_1d(direction); _i++)
{
	_str+="direction["+string(_i)+"] = "+string(direction[_i])+"\n";	
}

 _str+="X: "+string(position[V_X])+"\n"+
 			"Y: "+string(position[V_Y])+"\n"+
 			"Z: "+string(position[V_Z])+"\n";

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text_transformed_gpu(6,21,_str
					,_scale,_scale,0);
draw_set_color(c_white);
draw_text_transformed_gpu(5,20,_str
					,_scale,_scale,0);
