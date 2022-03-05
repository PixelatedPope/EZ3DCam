/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

if(keyboard_check_pressed(ord("R")))
 objEz3dCam.ezCam.setSize(objEz3dCam.ezCam.getWidth() != VIEW_W ? VIEW_W : window_get_width(),
          objEz3dCam.ezCam.getHeight() != VIEW_H ? VIEW_H : window_get_height());
//Zoom in and out
objEz3dCam.ezCam.changeFov((mouse_wheel_down()-mouse_wheel_up())*3);

//Rotation
var _yaw = (keyboard_check(ord("D"))-keyboard_check(ord("A")))*turn_speed;
var _pitch = keyboard_check(ord("W"))-keyboard_check(ord("S"));
//Move/Strafe
var _hori = keyboard_check(vk_left)-keyboard_check(vk_right);
var _vert = keyboard_check(vk_up)-keyboard_check(vk_down);

//Jumping
var _pos = objEz3dCam.ezCam.getPosition();
if(_pos[vZ] == z_floor && keyboard_check_pressed(vk_space))
{
 z_speed = -5; 
}
else
{
 z_speed += .1;
 if(_pos[vZ] >= z_floor)
 {
  objEz3dCam.ezCam.set_position([_pos[vX],_pos[vY],z_floor]);
  z_speed = 0;
 }
}

var _spd = 5;

//Camera Relative Movement
var _forward = objEz3dCam.ezCam.getDirection();
var _right = objEz3dCam.ezCam.getDirectionRight();
var _up = [0,0,z_speed];

//World Relative Movement
_forward[vZ]=0;
_right[vZ]=0;
_forward = vec3_scale(_forward,_spd * _vert);
_right = vec3_scale(_right,_spd * _hori);

var _move = vec3_add(_forward,_right,_up);

objEz3dCam.ezCam.changePosition(_move);
objEz3dCam.ezCam.changeOrientation([_yaw,_pitch,0]);
