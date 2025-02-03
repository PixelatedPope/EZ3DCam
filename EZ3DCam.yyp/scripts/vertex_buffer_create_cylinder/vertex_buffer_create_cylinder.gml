
///Vertex Buffer is of type pr_trianglestrip
///@func vertex_buffer_create_cylinder(originXYZ, side count, bottom radius, top radius, height, uvs)
function vertex_buffer_create_cylinder(_origin, _sides, _botRad, _topRad, _height, _uvs) {
	var _hrepeat = 1,
			_vrepeat = 1,
			_cos, _sin, _i;
  _sides = clamp(_sides,3,128);
	_cos[_sides] = 0;
	_sin[_sides] = 0;

	for (_i = 0; _i <= _sides; _i++)
	{
	 var _rad = (_i * 2.0 * pi) / _sides;
	 _cos[_i] = cos(_rad);
	 _sin[_i] = sin(_rad);
	}

	var _buff = vertex_create_buffer();
	vertex_begin(_buff, objEz3dCam.ezCam.vertexFormat);
	for (_i = 0; _i <= _sides; _i++)
	{
		var _pos = (_i*_hrepeat)/_sides;
		var _u = lerp(_uvs[0],_uvs[2],_pos);
		//Top
	 vertex_position_3d(_buff,
											 _origin[0]+_cos[_i] * _topRad, 
											 _origin[1]+_sin[_i] * _topRad, 
											 _origin[2]-_height/2);
	 vertex_normal(_buff,_cos[_i],_sin[_i],0)
		vertex_color(_buff,c_white,1);
		vertex_texcoord(_buff,_u,_uvs[1]);

		//Bot
		vertex_position_3d(_buff, 
											 _origin[0]+_cos[_i] * _botRad, 
											 _origin[1]+_sin[_i] * _botRad, 
											 _origin[2]+_height/2);
	 vertex_normal(_buff,_cos[_i],_sin[_i],0)
		vertex_color(_buff,c_white,1);
		vertex_texcoord(_buff,_u,_uvs[1] + (_uvs[3]-_uvs[1])*_vrepeat);

	}

	vertex_end(_buff);
	vertex_freeze(_buff);
	return _buff;
}
