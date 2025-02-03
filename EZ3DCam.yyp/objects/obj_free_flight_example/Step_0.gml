/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

//Zoom in and out
objEz3dCam.ezCam.changeFov((mouse_wheel_down()-mouse_wheel_up())*3);

var _yaw = keyboard_check(ord("E"))-keyboard_check(ord("Q"));
var _pitch = keyboard_check(ord("S"))-keyboard_check(ord("W"));
var _roll = keyboard_check(ord("D"))-keyboard_check(ord("A"));

throttle += (keyboard_check(vk_up)-keyboard_check(vk_down))*.05;
throttle = clamp(throttle,0,5);

//Camera Relative Movement
var _forward = vec3_scale(objEz3dCam.ezCam.getDirection(),throttle);

objEz3dCam.ezCam.changePosition(_forward);
objEz3dCam.ezCam.changeOrientation([_yaw,_pitch,_roll]);	