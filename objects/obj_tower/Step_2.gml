/// @description
rotation[vZ]=lerp(0,-360,view_x/(room_width-view_w));
layer_x("Sky", view_x+lerp(0,sprite_get_width(spr_bg_sky),view_x/(room_width-view_w)));



position[vX]+=keyboard_check(ord("W"))-keyboard_check(ord("S"))
position[vY]-=keyboard_check(ord("A"))-keyboard_check(ord("D"))