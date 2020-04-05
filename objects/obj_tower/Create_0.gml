/// @description
event_inherited();
var _height = 800;
var _sides = 64;
surf = noone;
position=[x,y,250];
primitive_type = pr_trianglestrip;
vertex = vertex_buffer_create_cylinder([0,0,-_height/2],_sides,200,200,_height,sprite_get_uvs(sprite_index,0));