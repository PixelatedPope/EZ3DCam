/// @description Camera Controls
window_set_caption("FPS: "+string(fps));

if(keyboard_check_pressed(ord("R")))
 EZ3D.setSize(EZ3D.getWidth() != VIEW_W ? VIEW_W : window_get_width(),
          EZ3D.getHeight() != VIEW_H ? VIEW_H : window_get_height());
//Zoom in and out
EZ3D.changeFov((mouse_wheel_down()-mouse_wheel_up())*3);

//Rotation
var _yaw = (keyboard_check(ord("D"))-keyboard_check(ord("A")))*turn_speed;
var _pitch = keyboard_check(ord("W"))-keyboard_check(ord("S"));
//Move/Strafe
var _hori = keyboard_check(vk_left)-keyboard_check(vk_right);
var _vert = keyboard_check(vk_up)-keyboard_check(vk_down);

//Jumping
var _pos = EZ3D.getPosition();
if(_pos[vZ] == z_floor && keyboard_check_pressed(vk_space))
{
 z_speed = -5; 
}
else
{
 z_speed += .1;
 if(_pos[vZ] >= z_floor)
 {
  EZ3D.set_position([_pos[vX],_pos[vY],z_floor]);
  z_speed = 0;
 }
}

var _spd = 5;

//Camera Relative Movement
var _forward = EZ3D.getDirection();
var _right = EZ3D.getDirectionRight();
var _up = [0,0,z_speed];

//World Relative Movement
_forward[vZ]=0;
_right[vZ]=0;
_forward = vec3_scale(_forward,_spd * _vert);
_right = vec3_scale(_right,_spd * _hori);

var _move = vec3_add(_forward,_right,_up);

EZ3D.changePosition(_move);
EZ3D.changeOrientation([_yaw,_pitch,0]);
