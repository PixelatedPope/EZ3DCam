/// @description
if(keyboard_check_pressed(ord("R")))
 EZ3D.setSize(EZ3D.getWidth() != VIEW_W ? VIEW_W : window_get_width(),
          EZ3D.getHeight() != VIEW_H ? VIEW_H : window_get_height());

//Rotation
var _turn_speed = 2;
var _yaw = (keyboard_check(ord("A"))-keyboard_check(ord("D")))*_turn_speed;
var _pitch = keyboard_check(ord("W"))-keyboard_check(ord("S"));

var _ori = EZ3D.getOrientation();
EZ3D.setOrientation([_ori[0]+_yaw,
												 clamp(_ori[1]+_pitch,5,25),
												 0]);
