/// @description returns a vertex buffer of an unclosed cylinder
/// pr_trianglestrip
/// @param origin_xyz (0,0,0 = centered)
/// @param num_sides
/// @param bot_radius
/// @param top_radius
/// @param Height
/// @param UVs 

var _origin = argument0,
		_sides = clamp(argument1,3,128),
    _bot_rad = argument2,
		_top_rad = argument3,
    _height = argument4,
    _uvs = argument5,
    _hrepeat = 1,
		_vrepeat = 1,
		_cos,_sin,_i;

#region Create sin and cos tables
_cos[_sides] = 0;
_sin[_sides] = 0;

for (_i = 0; _i <= _sides; _i++)
{
  var _rad = (_i * 2.0 * pi) / _sides;
  _cos[_i] = cos(_rad);
  _sin[_i] = sin(_rad);
}
#endregion

var _buff = vertex_create_buffer();
vertex_begin(_buff, EZ3D.vertex_format);
for (_i = 0; _i <= _sides; _i++)
{
	var _pos = (_i*_hrepeat)/_sides;
	var _u = lerp(_uvs[0],_uvs[2],_pos);
	//Top
  vertex_position_3d(_buff,
										 _origin[0]+_cos[_i] * _top_rad, 
										 _origin[1]+_sin[_i] * _top_rad, 
										 _origin[2]-_height/2);
  vertex_normal(_buff,_cos[_i],_sin[_i],0)
	vertex_color(_buff,c_white,1);
	vertex_texcoord(_buff,_u,_uvs[1]);

	//Bot
	vertex_position_3d(_buff, 
										 _origin[0]+_cos[_i] * _bot_rad, 
										 _origin[1]+_sin[_i] * _bot_rad, 
										 _origin[2]+_height/2);
  vertex_normal(_buff,_cos[_i],_sin[_i],0)
	vertex_color(_buff,c_white,1);
	vertex_texcoord(_buff,_u,_uvs[1] + (_uvs[3]-_uvs[1])*_vrepeat);

}

vertex_end(_buff);
vertex_freeze(_buff);
return _buff;