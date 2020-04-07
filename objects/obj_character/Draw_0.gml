/// @description
//Draw Shadow
/*
var _pos = position;
_pos[vZ]=-.5;

matrix_set(matrix_world,matrix_build_srt(scale,rotation,_pos));
var _tex = sprite_get_texture(spr_char_shadow,0);
vertex_submit(shadow_vertex,primitive_type,_tex);

// Normal Draw
event_inherited();
*/

rotation[vX]=-90;
matrix_set(matrix_world,matrix_build_srt(scale,rotation,position));
draw_sprite(sprite_index,image_index,0,0);
draw_text(0,-50,string(x)+","+string(y));
rotation[vX]=0;
position[vZ]=-.5;
matrix_set(matrix_world,matrix_build_srt(scale,rotation,position));
draw_sprite(spr_char_shadow,0,0,0);