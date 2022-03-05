/// @description
rotation[V_Z]=lerp(0,-90,VIEW_X/(room_width-VIEW_W));

//Tilt away from camera to force some extreme perspective.
var _angle = 25;
rotation[V_X]=lengthdir_y(_angle,rotation[V_Z]);
rotation[V_Y]=lengthdir_x(_angle,rotation[V_Z]);
layer_x("Sky", VIEW_X+lerp(0,sprite_get_width(spr_bg_sky),VIEW_X/(room_width-VIEW_W)));



position[V_X]+=keyboard_check(ord("W"))-keyboard_check(ord("S"))
position[V_Y]-=keyboard_check(ord("A"))-keyboard_check(ord("D"))

var _pos = objEz3dCam.ezCam.getPosition();
//Lighting
draw_light_define_point(1,_pos[V_X],_pos[V_Y],_pos[V_Z],50,c_white)
draw_light_enable(1,true);