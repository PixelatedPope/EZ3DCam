/// @description Insert description here
event_inherited();
objEz3dCam.ezCam.registerSkybox(id)
var _size = objEz3dCam.ezCam.getZFar()*.5;
fog = false;
rotation[V_X]=90;
vertex = vertex_buffer_create_mapped_cube(objEz3dCam.ezCam.vertexFormat, 
																				_size, 
																				[_size/2,_size/2,_size/2],
																				c_white,
																				sprite_get_uvs(sprite_index,0));