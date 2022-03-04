/// @description
if(keyboard_check_pressed(ord("R")))
  EZ3D.set_size(EZ3D.get_width() != view_w ? view_w : window_get_width(),
                   EZ3D.get_height() != view_h ? view_h : window_get_height());

//Rotation
var _turn_speed = 2;
var _yaw = (keyboard_check(ord("A"))-keyboard_check(ord("D")))*_turn_speed;
var _pitch  = keyboard_check(ord("W"))-keyboard_check(ord("S"));

var _ori = EZ3D.get_orientation();
EZ3D.set_orientation([_ori[0]+_yaw,
												 clamp(_ori[1]+_pitch,5,25),
												 0]);
