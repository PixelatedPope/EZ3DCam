/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

//Zoom in and out
objEz3dCam.ezCam.changeFov((mouse_wheel_down()-mouse_wheel_up())*3);

//Rotation
var _yaw = (keyboard_check(ord("D"))-keyboard_check(ord("A")))*turn_speed;
var _pitch = keyboard_check(ord("W"))-keyboard_check(ord("S"));
//Move/Strafe
var _hori = keyboard_check(vk_right)-keyboard_check(vk_left);
var _vert = keyboard_check(vk_up)-keyboard_check(vk_down);

//Jumping
var _pos = objEz3dCam.ezCam.getPosition();
if(_pos[V_Z] == z_floor && keyboard_check_pressed(vk_space))
{
 z_speed = -5; 
}
else
{
 z_speed += .1;
 if(_pos[V_Z] >= z_floor)
 {
  objEz3dCam.ezCam.setPosition([_pos[V_X],_pos[V_Y],z_floor]);
  z_speed = 0;
 }
}

var _spd = 5;

//Camera Relative Movement
var _forward = objEz3dCam.ezCam.getDirection();
var _left = objEz3dCam.ezCam.getDirectionLeft();
var _up = [0,0,z_speed];

//World Relative Movement
_forward[V_Z]=0;
_left[V_Z]=0;
_forward = vec3_scale(_forward,_spd * _vert);
_left = vec3_scale(_left,_spd * -_hori);

var _move = vec3_add(_forward,_left,_up);

objEz3dCam.ezCam.changePosition(_move);
objEz3dCam.ezCam.changeOrientation([_yaw,_pitch,0]);
