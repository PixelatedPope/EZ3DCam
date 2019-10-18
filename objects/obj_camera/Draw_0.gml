/// @description
/*
var _pos = gmode7_quad_get_position(target);
var _tar = gmode7_3d_to_view_space(_pos);
if(_tar[vZ] < 0) exit;
draw_set_alpha(.5);
draw_set_color(c_red)
draw_circle(_tar[vX],_tar[vY],13,false);
draw_set_color(c_white)
draw_circle(_tar[vX],_tar[vY],11,false);
draw_set_color(c_red)
draw_circle(_tar[vX],_tar[vY],9,false);
draw_set_color(c_white)
draw_circle(_tar[vX],_tar[vY],7,false);
draw_set_color(c_red)
draw_circle(_tar[vX],_tar[vY],5,false);
draw_set_halign(fa_center)
draw_set_valign(fa_bottom);
draw_set_color(c_black);
draw_set_alpha(1);
var _dist = round(_tar[vZ]/100);
draw_text(_tar[vX]+1,_tar[vY]-11+1,_dist);
draw_set_color(c_white);
draw_text(_tar[vX],_tar[vY]-11,_dist);