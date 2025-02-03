/// @description
if(vertex == noone) exit;

if(fog_enabled){
  gpu_set_fog(fog_enabled, fog_color, fog_start, fog_end);  
}

if(light_enabled){
  draw_set_lighting(light_enabled);
}

matrix_set(matrix_world,matrix_build_srt(scale,rotation,position));
vertex_submit(vertex,primitive_type,texture);