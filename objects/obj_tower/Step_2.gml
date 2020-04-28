/// @description
rotation[vZ]=lerp(0,-90,view_x/(room_width-view_w));

//Tilt away from camera to force some extreme perspective.
var _angle = 25;
rotation[vX]=lengthdir_y(_angle,rotation[vZ]);
rotation[vY]=lengthdir_x(_angle,rotation[vZ]);
layer_x("Sky", view_x+lerp(0,sprite_get_width(spr_bg_sky),view_x/(room_width-view_w)));



position[vX]+=keyboard_check(ord("W"))-keyboard_check(ord("S"))
position[vY]-=keyboard_check(ord("A"))-keyboard_check(ord("D"))

var _pos = ez3dcam_get_position();
//Lighting
draw_light_define_point(1,_pos[vX],_pos[vY],_pos[vZ],50,c_white)
draw_light_enable(1,true);