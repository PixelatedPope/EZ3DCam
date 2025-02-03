/// @description
var _hori = keyboard_check(vk_right)-keyboard_check(vk_left);
x+= _hori * spd;
if(_hori != 0)
 image_xscale = image_yscale * _hori;

sprite_index = _hori != 0 ? spr_ap_pc_run : spr_ap_pc_idle;

x = wrap(x,-25,room_width+25);
camera_set_view_pos(VIEW,clamp(x-VIEW_W/2,0,room_width-VIEW_W),0);

