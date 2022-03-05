/// @description Move
var _hori = keyboard_check(vk_left)-keyboard_check(vk_right);
var _vert = keyboard_check(vk_up)-keyboard_check(vk_down);
var _spd = 5;

//Camera Relative Movement
var _forward = objEz3dCam.ezCam.getDirection();
var _right = objEz3dCam.ezCam.getDirectionRight();
//var _up = [0,0,0];

//Ignore Z
_forward[V_Z]=0;
_right[V_Z]=0;
_forward = vec3_scale(_forward,_spd * _vert);
_right = vec3_scale(_right,_spd * _hori);

var _move = vec3_add(_forward,_right);//,_up);
x+= _move[V_X];
y+= _move[V_Y];
//z+=_move[V_Z];

z = -(floor(image_index) mod 2 == 0)*2;
position=[x,y,0];

if(point_distance(0,0,_hori,_vert) > 0)
	face_dir = point_direction(0,0,_move[V_X],_move[V_Y]);
else
	image_index = 1;