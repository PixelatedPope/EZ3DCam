/// @description Insert description here
// You can write your code in this editor
event_inherited();

var _w = sprite_get_width(spr_ground);
var _h = sprite_get_height(spr_ground);

var _uvs = sprite_get_uvs(sprite_index,0);

var _buff = vertex_create_buffer();
var _tile_count = 250;

light_enabled = false;
fog = true;
fog_end = EZ3D.get_zfar();
fog_start = 500;
fog_color = $a5866a;

vertex_begin(_buff,EZ3D.vertex_format);
for(var _x = 0; _x+_w < _w*_tile_count; _x+=_w)
{
	for(var _y = 0; _y+_h < _h*_tile_count; _y+=_h)
	{
		///vertex_buffer_build_tri(vbuff, x1,y1,z1,x2,y2,z2,x3,y3,z3,_col,_alpha,_uvs)
		vertex_position_3d(_buff,_x,_y,0);
    vertex_normal(_buff,0,0,-1);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[0], _uvs[1]);
		
		vertex_position_3d(_buff,_x+_w,_y,0);
    vertex_normal(_buff,0,0,-1);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[2], _uvs[1]);
		
		vertex_position_3d(_buff,_x,_y+_h,0);
    vertex_normal(_buff,0,0,-1);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[0], _uvs[3]);
		
		
		vertex_position_3d(_buff,_x+_w,_y+_w,0);
    vertex_normal(_buff,0,0,-1);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[2], _uvs[3]);
		
		vertex_position_3d(_buff,_x,_y+_h,0);
    vertex_normal(_buff,0,0,-1);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[0], _uvs[3]);

		vertex_position_3d(_buff,_x+_w,_y,0);
    vertex_normal(_buff,0,0,-1);
		vertex_colour(_buff, c_white, 1);
		vertex_texcoord(_buff, _uvs[2], _uvs[1]);
		
		
	}
}
vertex_end(_buff);
vertex = _buff;