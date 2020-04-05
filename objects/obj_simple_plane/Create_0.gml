/// @description Insert description here
// You can write your code in this editor
event_inherited();
rotation = [0,0,-90] // -90 to face the camera which.

//The most difficult part of working with 3D is building your
//3D "models".  This is an example of a simple textured plane
//made up of two triangles.  

var _w = sprite_get_width(sprite_index)/2,
    _h = sprite_get_height(sprite_index)/2,
    _uvs = sprite_get_uvs(sprite_index,0),
    _buff = vertex_create_buffer();

vertex_begin(_buff,EZ3D.vertex_format);
		
//Top Left Tri
var _l=0,_r=2,_t=1,_b=3;
vertex_position_3d(_buff,-_w,0,-_h);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_t]);
		
vertex_position_3d(_buff,_w,0,-_h);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);
		
vertex_position_3d(_buff,-_w,0,_h);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);
		
//Bottom Right Tri	
vertex_position_3d(_buff,_w,0,_h);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_b]);
		
vertex_position_3d(_buff,-_w,0,_h);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);

vertex_position_3d(_buff,_w,0,-_h);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);
		
vertex_end(_buff);
vertex = _buff;