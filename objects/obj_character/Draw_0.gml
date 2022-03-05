/// @description

//Draw Shadow
var _pos = position;
_pos[V_Z]=-.5;
matrix_set(matrix_world,matrix_build_srt(scale,rotation,_pos));
var _tex = sprite_get_texture(spr_char_shadow,0);
draw_set_alpha(.5)
vertex_submit(shadow_vertex,primitive_type,_tex);
draw_set_alpha(1);
// Normal Draw
event_inherited();
