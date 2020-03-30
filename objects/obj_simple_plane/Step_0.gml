/// @description
rotation[vX]-=keyboard_check(vk_down)-keyboard_check(vk_up)
rotation[vZ]+=keyboard_check(vk_right)-keyboard_check(vk_left);

position[vX]+=keyboard_check(ord("W"))-keyboard_check(ord("S"))
position[vY]-=keyboard_check(ord("A"))-keyboard_check(ord("D"))