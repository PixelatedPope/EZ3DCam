/// @description Insert description here
// You can write your code in this editor
event_inherited();

var _w = sprite_get_width(spr_ground);
var _h = sprite_get_height(spr_ground);

var _uvs = sprite_get_uvs(sprite_index,0);

var _buff = vertex_create_buffer();
vertex_begin(_buff,EZ3D.vertex_format);
		
//Top Left Tri
vertex_position_3d(_buff,0,0,0);
vertex_colour(_buff, c_white, 1);
var _l=0,_r=2,_t=1,_b=3;
vertex_texcoord(_buff, _uvs[_l], _uvs[_t]);
		
vertex_position_3d(_buff,_w,0,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);
		
vertex_position_3d(_buff,0,_h,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);
		
//Bottom Right Tri	
vertex_position_3d(_buff,_w,_w,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_b]);
		
vertex_position_3d(_buff,0,_h,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);

vertex_position_3d(_buff,_w,0,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);
		
vertex_end(_buff);
vertex = _buff;