/// @description Insert description here
event_inherited();
var _size = 64;

x=room_width/2;
y=room_width/2;
z=-_size;
rotation=vZERO;


cube = vertex_buffer_create_mapped_cube(EZ3D.vertex_format, _size, [_size/2,_size/2,_size/2], c_white,sprite_get_uvs(sprite_index,0));