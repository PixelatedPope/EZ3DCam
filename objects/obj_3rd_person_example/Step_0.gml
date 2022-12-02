//Rotation
var _turn_speed = 2;
var _yaw = (keyboard_check(ord("A"))-keyboard_check(ord("D")))*_turn_speed;
var _pitch = keyboard_check(ord("W"))-keyboard_check(ord("S"));

var _ori = objEz3dCam.ezCam.getOrientation();
objEz3dCam.ezCam.setOrientation([_ori[0]+_yaw,
												 clamp(_ori[1]+_pitch,5,25),
												 0]);
