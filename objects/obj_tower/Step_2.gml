/// @description
rotation[vZ]=lerp(0,-90,VIEW_X/(room_width-VIEW_W));

//Tilt away from camera to force some extreme perspective.
var _angle = 25;
rotation[vX]=lengthdir_y(_angle,rotation[vZ]);
rotation[vY]=lengthdir_x(_angle,rotation[vZ]);
layer_x("Sky", VIEW_X+lerp(0,sprite_get_width(spr_bg_sky),VIEW_X/(room_width-VIEW_W)));



position[vX]+=keyboard_check(ord("W"))-keyboard_check(ord("S"))
position[vY]-=keyboard_check(ord("A"))-keyboard_check(ord("D"))

var _pos = objEz3dCam.ezCam.getPosition();
//Lighting
draw_light_define_point(1,_pos[vX],_pos[vY],_pos[vZ],50,c_white)
draw_light_enable(1,true);