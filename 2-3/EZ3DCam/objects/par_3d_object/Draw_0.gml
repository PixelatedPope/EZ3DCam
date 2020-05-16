/// @description
if(vertex == noone) exit;

gpu_set_fog(fog,fog_color,fog_start,fog_end);
draw_set_lighting(fog);
  
matrix_set(matrix_world,matrix_build_srt(scale,rotation,position));
vertex_submit(vertex,primitive_type,texture);