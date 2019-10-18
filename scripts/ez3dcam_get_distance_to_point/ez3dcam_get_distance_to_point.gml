/// @param x
/// @param y
/// @param <z>
with(EZ3D)
{
	var _x = argument[0],
			_y = argument[1],
			_3d = argument_count > 2,
			_z = _3d ? argument[2] : 0,
			_cx = camera_position[vX],
			_cy = camera_position[vY],
			_cz = camera_position[vZ];
		
	return _3d ? point_distance(_x,_y,_cx,_cy) : point_distance_3d(_x,_y,_z,_cx,_cy,_cz);
}