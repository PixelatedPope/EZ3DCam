/// @description Move
var _hori = keyboard_check(vk_left)-keyboard_check(vk_right);
var _vert = keyboard_check(vk_up)-keyboard_check(vk_down);
var _spd = 5;

//Camera Relative Movement
var _forward = EZ3D.getDirection();
var _right = EZ3D.getDirectionRight();
//var _up = [0,0,0];

//Ignore Z
_forward[vZ]=0;
_right[vZ]=0;
_forward = vec3_scale(_forward,_spd * _vert);
_right = vec3_scale(_right,_spd * _hori);

var _move = vec3_add(_forward,_right);//,_up);
x+= _move[vX];
y+= _move[vY];
//z+=_move[vZ];

z = -(floor(image_index) mod 2 == 0)*2;
position=[x,y,0];

if(point_distance(0,0,_hori,_vert) > 0)
	face_dir = point_direction(0,0,_move[vX],_move[vY]);
else
	image_index = 1;