/// @description Draw Controls
_scale = 1;
draw_set_color(c_white);
var _str = "";
var _mode = ez3dcam_get_mode();
switch(_mode)
{
	case EZ3DCam.mode_first_person: _str+="First Person Camera"; break;
	case EZ3DCam.mode_track_target: _str+="Track Target Camera"; break;
	case EZ3DCam.mode_third_person: _str+="Third Person Camera"; break;
}

_str += "\n\nChange Mode: Spacebar";
_str += "\n\nRotation: A S D W Q E : " + (ez3dcam_get_rotation_mode() == EZ3DCam.rotation_local ? "Local" : "World");
_str += "\nPosition: Arrow Keys PgUp/PgDown";
_str += "\n--3rd Person Distance: Home/End";
_str += "\nZoom: Mouse Wheel";
_str += "\n\nReset: Backspace";
_str += "\n\nChange Rotation Mode: Enter";
_str += "\n\nResize Window: 1  Toggle Retro Mode: 2";


draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text_transformed_gpu(6,6,_str,_scale,_scale,0);
draw_set_color(c_white);
draw_text_transformed_gpu(5,5,_str,_scale,_scale,0);
