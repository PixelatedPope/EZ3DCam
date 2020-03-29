/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

//Zoom in and out
ez3dcam_set_fov(ez3dcam_get_fov()+(mouse_wheel_down()-mouse_wheel_up())*3);

//3rd Person Truck in and out
distance += (keyboard_check(vk_end)-keyboard_check(vk_home))*10;

var _yaw = keyboard_check(ord("D"))-keyboard_check(ord("A")),
		_pitch  = keyboard_check(ord("W"))-keyboard_check(ord("S")),
		_roll  = keyboard_check(ord("E"))-keyboard_check(ord("Q")),
		_hori = keyboard_check(vk_left)-keyboard_check(vk_right),
		_vert = keyboard_check(vk_up)-keyboard_check(vk_down),
		_z = keyboard_check(vk_pagedown)-keyboard_check(vk_pageup),
		_spd = 10,

//Camera Relative Movement
		_forward = vec3_scale(ez3dcam_get_direction(),_spd * _vert),
		_right = vec3_scale(ez3dcam_get_direction_right(),_spd * _hori),
		_up = vec3_scale(ez3dcam_get_direction_up(),_spd* _z);

//World Relative Movement
_forward[vZ]=0;
_right[vZ]=0;
_up = [0,0,_z*_spd];

var _move = vec3_add(_forward,_right,_up);

//Control Target
ez3dcam_set_distance_from_target(distance);
ez3dcam_change_target_position(_move);
ez3dcam_change_orientation(_yaw,_pitch,_roll);