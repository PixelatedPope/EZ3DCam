///@func triangle_normal(x1, y1, z1, x2, y2, z2, x3, y3, z3)
function triangle_normal(_x1, _y1, _z1, _x2, _y2, _z2, _x3, _y3, _z3) {

	gml_pragma("forceinline");

	var v1x = _x2 - _x1;
	var v1y = _y2 - _y1;
	var v1z = _z2 - _z1;
	var v2x = _x3 - _x1;
	var v2y = _y3 - _y1;
	var v2z = _z3 - _z1;

	var cx = v1y * v2z - v1z * v2y;
	var cy = -v1x * v2z + v1z * v2x;
	var cz = v1x * v2y - v1y * v2x;

	var cpl = point_distance_3d(0, 0, 0, cx, cy, cz);

	if (cpl != 0) {
	  return [cx / cpl, cy / cpl, cz / cpl];
	}

	return [0, 0, 1];
}
