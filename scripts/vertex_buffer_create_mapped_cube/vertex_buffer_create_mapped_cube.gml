/// @description returns a vertex buffer of a cube.
///@func vertex_buffer_create_mapped_cube(vertex format, size, originXYZ, color, [uvs]);
function vertex_buffer_create_mapped_cube(_format, _size, _orig, _col, _uvs = [0,0,1,1]) {

	var _buff = vertex_create_buffer(),
			_x1 = -_orig[V_X],
	    _y1 = -_orig[V_Y],
			_z1 = -_orig[V_Z],
			_x2 = _x1+_size,
			_y2 = _y1+_size,
			_z2 = _z1+_size;

	var _u = [lerp(_uvs[0],_uvs[2],.0), 
					  lerp(_uvs[0],_uvs[2],.25), 
						lerp(_uvs[0],_uvs[2],.5), 
						lerp(_uvs[0],_uvs[2],.75), 
						lerp(_uvs[0],_uvs[2],1.0)];
            
	var _v = [lerp(_uvs[1],_uvs[3],.0), 
						lerp(_uvs[1],_uvs[3],1/3), 
						lerp(_uvs[1],_uvs[3],2/3), 
						lerp(_uvs[1],_uvs[3],1.0)];

	//Points
	var _p1 = [_x1,_y1,_z1],
			_p2 = [_x2,_y1,_z1],
			_p3 = [_x1,_y2,_z1],
			_p4 = [_x2,_y2,_z1],
			_p5 = [_x1,_y1,_z2],
			_p6 = [_x2,_y1,_z2],
			_p7 = [_x1,_y2,_z2],
			_p8 = [_x2,_y2,_z2];


	vertex_begin(_buff, _format);

	////DOWN-Z-------------------
	//1,2,3
	vertex_position_3d_vec(_buff,_p1);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[1]);
	vertex_position_3d_vec(_buff,_p2);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[2],_v[1]);
	vertex_position_3d_vec(_buff,_p3);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[1],_v[2]);

	///2,3,4
	vertex_position_3d_vec(_buff,_p2);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[2],_v[1]);
	vertex_position_3d_vec(_buff,_p3);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[1],_v[2]);
	vertex_position_3d_vec(_buff,_p4);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[2],_v[2]);

	///RIGHT------------------------
	//1,2,6
	vertex_position_3d_vec(_buff,_p1);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[1]);
	vertex_position_3d_vec(_buff,_p2);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[2],_v[1]);
	vertex_position_3d_vec(_buff,_p6);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[2],_v[0]);

	//1,6,5
	vertex_position_3d_vec(_buff,_p1);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[1]);
	vertex_position_3d_vec(_buff,_p6);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[2],_v[0]);
	vertex_position_3d_vec(_buff,_p5);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[0]);

	//1,3,7
	vertex_position_3d_vec(_buff,_p1);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[1]);
	vertex_position_3d_vec(_buff,_p3);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[1],_v[2]);
	vertex_position_3d_vec(_buff,_p7);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[0],_v[2]);
	//1,5,7
	vertex_position_3d_vec(_buff,_p1);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[1]);
	vertex_position_3d_vec(_buff,_p5);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[0],_v[1]);
	vertex_position_3d_vec(_buff,_p7);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[0],_v[2]);

	//3,4,7
	vertex_position_3d_vec(_buff,_p3);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[2]);
	vertex_position_3d_vec(_buff,_p4);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[2],_v[2]);
	vertex_position_3d_vec(_buff,_p7);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[3]);
	//4,8,7
	vertex_position_3d_vec(_buff,_p4);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[2],_v[2]);
	vertex_position_3d_vec(_buff,_p8);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[2],_v[3]);
	vertex_position_3d_vec(_buff,_p7);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[1],_v[3]);

	//2,6,4
	vertex_position_3d_vec(_buff,_p2);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[2],_v[1]);
	vertex_position_3d_vec(_buff,_p6);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[3],_v[1]);
	vertex_position_3d_vec(_buff,_p4);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[2],_v[2]);
	//4,8,6
	vertex_position_3d_vec(_buff,_p4);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[2],_v[2]);
	vertex_position_3d_vec(_buff,_p8);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[3],_v[2]);
	vertex_position_3d_vec(_buff,_p6);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[3],_v[1]);

	//6,5,8
	vertex_position_3d_vec(_buff,_p6);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[3],_v[1]);
	vertex_position_3d_vec(_buff,_p5);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[4],_v[1]);
	vertex_position_3d_vec(_buff,_p8);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[3],_v[2]);
	//8,7,5
	vertex_position_3d_vec(_buff,_p8);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[3],_v[2]);
	vertex_position_3d_vec(_buff,_p7);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff, _u[4],_v[2]);
	vertex_position_3d_vec(_buff,_p5);
	vertex_normal(_buff,0,0,0);
	vertex_color(_buff,_col,1);
	vertex_texcoord(_buff,_u[4],_v[1]);

	vertex_end(_buff);
	vertex_freeze(_buff);
	return _buff;
}
