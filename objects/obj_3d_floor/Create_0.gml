/// @description Insert description here
// You can write your code in this editor
event_inherited();

var _w = sprite_get_width(spr_ground);
var _h = sprite_get_height(spr_ground);

var _uvs = sprite_get_uvs(sprite_index,0);

var _buff = vertex_create_buffer();
var _tile_count = 250;

light_enabled = false;
fog_enabled = os_browser == browser_not_a_browser;
fog_end = 1000;
fog_start = 600;
fog_color = $a5866a;

vertex_begin(_buff,objEz3dCam.ezCam.vertexFormat);
for(var _x = 0; _x+_w < _w*_tile_count; _x+=_w)
{
	for(var _y = 0; _y+_h < _h*_tile_count; _y+=_h)
	{
		
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