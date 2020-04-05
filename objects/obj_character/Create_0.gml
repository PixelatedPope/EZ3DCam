/// @description Insert description here

event_inherited();
rotation = [0,0,-90] // -90 to face the camera.

primitive_type = pr_trianglestrip;
var _w = sprite_get_width(sprite_index)/2,
    _h = sprite_get_height(sprite_index);
var _l=0,_t=1,_r=2,_b=3;
face_dir=0;

frames = ds_grid_create(4,3);
vertex = noone;
for(var _y=0; _y<3; _y++)
{
	for(var _x=0; _x<4; _x++)
	{
		var _uvs = sprite_get_uvs(spr_char_south+_y,_x),
				_buff = vertex_create_buffer();
		vertex_begin(_buff,EZ3D.vertex_format);

		vertex_position_3d(_buff,-_w,0,-_h);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[_l], _uvs[_t]);
		
		vertex_position_3d(_buff,_w,0,-_h);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);
		
		vertex_position_3d(_buff,-_w,0,0);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);
		
		vertex_position_3d(_buff,_w,0,0);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[_r], _uvs[_b]);
		
		vertex_end(_buff);
		vertex_freeze(_buff);
		frames[# _x,_y] = _buff;
	}
}

//Create Shadow
_h /= 2;
_buff = vertex_create_buffer();
_uvs = sprite_get_uvs(spr_char_shadow,0);
var _alpha = .5;
vertex_begin(_buff,EZ3D.vertex_format);

vertex_position_3d(_buff,-_w,-_h,0);
vertex_colour(_buff, c_white, _alpha);
vertex_texcoord(_buff, _uvs[_l], _uvs[_t]);
		
vertex_position_3d(_buff,_w,-_h,0);
vertex_colour(_buff, c_white, _alpha);
vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);
		
vertex_position_3d(_buff,-_w,_h,0);
vertex_colour(_buff, c_white, _alpha);
vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);
		
vertex_position_3d(_buff,_w,_h,0);
vertex_colour(_buff, c_white, _alpha);
vertex_texcoord(_buff, _uvs[_r], _uvs[_b]);
		
vertex_end(_buff);
vertex_freeze(_buff);
shadow_vertex = _buff;

