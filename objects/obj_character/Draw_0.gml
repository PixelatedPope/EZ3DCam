/// @description

//Draw Shadow
var _pos = position;
_pos[vZ]=-.5;
matrix_set(matrix_world,matrix_build_srt(scale,rotation,_pos));
var _tex = sprite_get_texture(spr_char_shadow,0);
vertex_submit(shadow_vertex,primitive_type,_tex);

// Normal Draw
event_inherited();
