/// @description Insert description here
// You can write your code in this editor
if(ez3dcam_get_mode()==EZ3DCam.mode_first_person) exit;

var _pos = ez3dcam_get_target_position();
x=_pos[vX];
y=_pos[vY];
z=_pos[vZ];

matrix_set(matrix_world,matrix_build_srt(vONE,rotation,[x,y,z]));
vertex_submit(cube,pr_trianglelist,sprite_get_texture(sprite_index,0));
