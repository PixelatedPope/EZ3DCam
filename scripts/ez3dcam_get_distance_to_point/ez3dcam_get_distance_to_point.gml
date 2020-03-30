/// @param [x,y,z]
with(EZ3D)
{
	var _pos = argument0,
      _x = _pos[vX],
			_y = _pos[vY],
			_z = _pos[vZ],
			_cx = camera_position[vX],
			_cy = camera_position[vY],
			_cz = camera_position[vZ];
		
	return point_distance_3d(_x,_y,_z,_cx,_cy,_cz);
}