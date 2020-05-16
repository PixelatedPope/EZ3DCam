/// @description Insert description here
event_inherited();
var _size = EZ3D.getZfar()*.5;
fog = false;
rotation[vX]=90;
vertex = vertex_buffer_create_mapped_cube(EZ3D.vertex_format, 
																				_size, 
																				[_size/2,_size/2,_size/2],
																				c_white,
																				sprite_get_uvs(sprite_index,0));