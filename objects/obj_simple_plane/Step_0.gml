/// @description
var _spd = 2;
rotation[vX]-=(keyboard_check(vk_down)-keyboard_check(vk_up)) * _spd;
rotation[vZ]+=(keyboard_check(vk_right)-keyboard_check(vk_left)) * _spd;

position[vX]+=(keyboard_check(ord("W"))-keyboard_check(ord("S"))) * _spd;
position[vY]-=(keyboard_check(ord("A"))-keyboard_check(ord("D"))) * _spd;