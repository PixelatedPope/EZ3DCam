///@param xyz1
///@param xyz2
function point_distance_vec3(argument0, argument1) {
	var _a = argument0;
	var _b = argument1;
	return point_distance_3d(_a[vX],_a[vY],_a[vZ],_b[vX],_b[vY],_b[vZ]);


}
/// returns a new vector with the given vectors added together
/// @param vector1
/// @param vector2
/// @param <vector3...>
function vec3_add() {
	var _new = [0,0,0];
	for(var _i= 0; _i<argument_count; _i++)
	{
		var _vec = argument[_i];
		_new[0]+=_vec[0];
		_new[1]+=_vec[1];
		_new[2]+=_vec[2];
	}
	return _new


}
/// @description returns the length of the given 3D vector
/// @param vector
function vec3_length(argument0) {
	var _v1 = argument0;

	var _tot = 0;
	_tot+=_v1[0]*_v1[0];
	_tot+=_v1[1]*_v1[1];
	_tot+=_v1[2]*_v1[2];
	if(_tot != 0)
		_tot = sqrt(_tot);
	
	return _tot;


}
/// @description Returns a 3D vector with a length of 1
/// @param vec3
function vec3_normalize(argument0) {
	var _v1 = argument0;
	var _v;

	var _tot = 0;
	_v[2] = 0;
	_tot+=_v1[0]*_v1[0];
	_tot+=_v1[1]*_v1[1];
	_tot+=_v1[2]*_v1[2];

	if(_tot != 0)
	{
		_tot = sqrt(_tot);
		_v[0] = _v1[0]/_tot;
		_v[1] = _v1[1]/_tot;
		_v[2] = _v1[2]/_tot;
	}

	return _v;



}
/// scales the given vec3 array by the given value
/// @param vec3
/// @param scalar
function vec3_scale(argument0, argument1) {
	var _vec = argument0;
	var _scale = argument1;
	_vec[0]*=_scale;
	_vec[1]*=_scale;
	_vec[2]*=_scale;
	return _vec;


}
