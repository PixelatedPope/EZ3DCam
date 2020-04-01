/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

//Zoom in and out
ez3dcam_set_fov(ez3dcam_get_fov()+(mouse_wheel_down()-mouse_wheel_up())*3);
//Rotation
var _yaw = (keyboard_check(ord("D"))-keyboard_check(ord("A")))*turn_speed;
var _pitch  = keyboard_check(ord("W"))-keyboard_check(ord("S"));
//Move/Strafe
var _hori = keyboard_check(vk_left)-keyboard_check(vk_right);
var _vert = keyboard_check(vk_up)-keyboard_check(vk_down);

//Jumping
var _pos = ez3dcam_get_position();
if(_pos[vZ] == z_floor && keyboard_check_pressed(vk_space))
{
  z_speed = -5; 
}
else
{
  z_speed += .1;
  if(_pos[vZ] >= z_floor)
  {
    ez3dcam_set_position([_pos[vX],_pos[vY],z_floor]);
    z_speed = 0;
  }
}

var _spd = 5;

//Camera Relative Movement
var _forward = vec3_scale(ez3dcam_get_direction(),_spd * _vert);
var _right = vec3_scale(ez3dcam_get_direction_right(),_spd * _hori);
var _up = vec3_scale(ez3dcam_get_direction_up(),z_speed);

//World Relative Movement
_forward[vZ]=0;
_right[vZ]=0;
_up = [0,0,z_speed];

var _move = vec3_add(_forward,_right,_up);

ez3dcam_change_position(_move);
ez3dcam_change_orientation(_yaw,_pitch,0);