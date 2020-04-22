/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

//Zoom in and out
ez3dcam_change_fov((mouse_wheel_down()-mouse_wheel_up())*3);

var _yaw = keyboard_check(ord("E"))-keyboard_check(ord("Q"));
var _pitch  = keyboard_check(ord("S"))-keyboard_check(ord("W"));
var _roll  = keyboard_check(ord("D"))-keyboard_check(ord("A"));

throttle += (keyboard_check(vk_up)-keyboard_check(vk_down))*.05;
throttle = clamp(throttle,0,5);

//Camera Relative Movement
var _forward = vec3_scale(ez3dcam_get_direction(),throttle);

ez3dcam_change_position(_forward);
ez3dcam_change_orientation([_yaw,_pitch,_roll]);

if(keyboard_check_pressed(ord("R")))
  ez3dcam_set_size(ez3dcam_get_width() != view_w ? view_w : window_get_width(),
                   ez3dcam_get_height() != view_h ? view_h : window_get_height());
	