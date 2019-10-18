/// @description Insert description here
event_inherited();
var _size = ez3dcam_get_zfar()*.75;

x=0
y=0
z=0;
rotation=vZERO;


cube = vertex_buffer_create_mapped_cube(EZ3D.vertex_format, 
																				_size, 
																				[_size/2,_size/2,_size/2],
																				make_color_hsv(irandom(255),64,255),
																				sprite_get_uvs(sprite_index,0));