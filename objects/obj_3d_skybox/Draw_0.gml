/// @description Insert description here
// You can write your code in this editor
var _pos = ez3dcam_get_position();
x=_pos[vX];
y=_pos[vY];
z=_pos[vZ];
draw_set_color(c_red);
matrix_set(matrix_world,matrix_build_srt(vONE,rotation,[x,y,z]));
vertex_submit(cube,pr_trianglelist,sprite_get_texture(sprite_index,0));
draw_set_color(c_white);