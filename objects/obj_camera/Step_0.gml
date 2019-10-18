/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

#region Change Camera Mode

if(keyboard_check_pressed(vk_space))
{
	ez3dcam_set_mode(wrap(ez3dcam_get_mode()+1,EZ3DCam.mode_first_person,EZ3DCam.mode_track_target+1));		
	switch(ez3dcam_get_mode())
	{
			case EZ3DCam.mode_first_person: 
			var _tar = ez3dcam_get_target_position();
			ez3dcam_set_position(_tar);
			break;
	}
}
#endregion

//Zoom in and out
ez3dcam_set_fov(ez3dcam_get_fov()+(mouse_wheel_down()-mouse_wheel_up())*3);

//3rd Person Truck in and out
distance += (keyboard_check(vk_end)-keyboard_check(vk_home))*10;

#region Rotate Camera
var _yaw = keyboard_check(ord("D"))-keyboard_check(ord("A"));
var _pitch  = keyboard_check(ord("W"))-keyboard_check(ord("S"));
var _roll  = keyboard_check(ord("E"))-keyboard_check(ord("Q"));
#endregion

#region Move Camera/Camera Target
var _hori = keyboard_check(vk_left)-keyboard_check(vk_right);
var _vert = keyboard_check(vk_up)-keyboard_check(vk_down);
var _z = keyboard_check(vk_pagedown)-keyboard_check(vk_pageup);

var _tar = ez3dcam_get_target_position();
var _spd = 10;

//Camera Relative Movement
var _forward = vec3_scale(ez3dcam_get_direction(),_spd * _vert);
var _right = vec3_scale(ez3dcam_get_direction_right(),_spd * _hori);
var _up = vec3_scale(ez3dcam_get_direction_up(),_spd* _z);

//World Relative Movement
_forward[vZ]=0;
_right[vZ]=0;
_up = [0,0,_z*_spd];

var _move = vec3_add(_forward,_right,_up);
#endregion

switch(ez3dcam_get_mode())
{
	#region First Person
	case EZ3DCam.mode_first_person:
		ez3dcam_change_position(_move);
		ez3dcam_set_rotation_mode(rotation_mode);
		ez3dcam_change_orientation(_yaw,_pitch,_roll);
	break;
	#endregion
	
	#region Third Person
	case EZ3DCam.mode_third_person:
		//Control Target
		ez3dcam_set_distance_from_target(distance);
		ez3dcam_change_target_position(_move);
		ez3dcam_set_rotation_mode(rotation_mode);
		ez3dcam_change_orientation(_yaw,_pitch,_roll);
	break;
	#endregion

	#region Track Target
	case EZ3DCam.mode_track_target:
		//Control Target
		var _spd = 5;
		ez3dcam_change_target_position(_move);
		ez3dcam_change_orientation(0,0,_roll);
	break;
#endregion
}