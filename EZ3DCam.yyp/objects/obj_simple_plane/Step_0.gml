/// @description
var _spd = 2;
rotation[V_X]-=(keyboard_check(vk_down)-keyboard_check(vk_up)) * _spd;
rotation[V_Z]+=(keyboard_check(vk_right)-keyboard_check(vk_left)) * _spd;

position[V_X]+=(keyboard_check(ord("W"))-keyboard_check(ord("S"))) * _spd;
position[V_Y]-=(keyboard_check(ord("A"))-keyboard_check(ord("D"))) * _spd;