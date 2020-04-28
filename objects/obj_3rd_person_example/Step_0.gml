/// @description
if(keyboard_check_pressed(ord("R")))
  ez3dcam_set_size(ez3dcam_get_width() != view_w ? view_w : window_get_width(),
                   ez3dcam_get_height() != view_h ? view_h : window_get_height());

//Rotation
var _turn_speed = 2;
var _yaw = (keyboard_check(ord("A"))-keyboard_check(ord("D")))*_turn_speed;
var _pitch  = keyboard_check(ord("W"))-keyboard_check(ord("S"));

var _ori = ez3dcam_get_orientation();
ez3dcam_set_orientation([_ori[0]+_yaw,
												 clamp(_ori[1]+_pitch,5,25),
												 0]);
