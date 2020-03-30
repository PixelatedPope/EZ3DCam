/// @description
if(vertex == noone) exit;

matrix_set(matrix_world,matrix_build_srt(scale,rotation,position));
vertex_submit(vertex,pr_trianglelist,texture);