/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

//Zoom in and out
EZ3D.changeFov((mouse_wheel_down()-mouse_wheel_up())*3);

var _yaw = keyboard_check(ord("E"))-keyboard_check(ord("Q"));
var _pitch = keyboard_check(ord("S"))-keyboard_check(ord("W"));
var _roll = keyboard_check(ord("D"))-keyboard_check(ord("A"));

throttle += (keyboard_check(vk_up)-keyboard_check(vk_down))*.05;
throttle = clamp(throttle,0,5);

//Camera Relative Movement
var _forward = vec3_scale(EZ3D.getDirection(),throttle);

EZ3D.changePosition(_forward);
EZ3D.changeOrientation([_yaw,_pitch,_roll]);

if(keyboard_check_pressed(ord("R")))
 EZ3D.setSize(EZ3D.getWidth() != VIEW_W ? VIEW_W : window_get_width(),
          EZ3D.getHeight() != VIEW_H ? VIEW_H : window_get_height());
	