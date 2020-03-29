///@description Insert description here
// You can write your code in this editor
if(!instance_exists(follow_target)) exit;

var _x = follow_target.x-view_w/2,
    _y = follow_target.y-view_h/2,
    _round = view_w/surface_get_width(application_surface);
_x = clamp(round_n(_x,_round),0,room_width-view_w);
_y = clamp(round_n(_y,_round),0,room_height-view_h);

camera_set_view_pos(cam,_x,_y);