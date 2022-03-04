///// @description Draw Debug Text
/*exit;

var _scale = window_get_width()/display_get_gui_width();
_scale *=2;
draw_set_color(c_white);
var _str = "";

switch(cameraMode)
{
	case EZ3DCam.mode_first_person: _str+="First Person Camera"; break;
	case EZ3DCam.mode_track_target: _str+="Track Target Camera"; break;
	case EZ3DCam.mode_third_person: _str+="Third Person Camera"; break;
}
_str += "\n";
for(var _i=0; _i<array_length_1d(cameraDirection); _i++)
{
	_str+="cameraDirection["+string(_i)+"] = "+string(cameraDirection[_i])+"\n";	
}

 _str+="X: "+string(cameraPosition[vX])+"\n"+
 			"Y: "+string(cameraPosition[vY])+"\n"+
 			"Z: "+string(cameraPosition[vZ])+"\n";

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text_transformed_gpu(6,21,_str
					,_scale,_scale,0);
draw_set_color(c_white);
draw_text_transformed_gpu(5,20,_str
					,_scale,_scale,0);
