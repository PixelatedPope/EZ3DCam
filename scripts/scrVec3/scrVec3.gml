
///@func point_distance_vec3(A[x,y,z], B[x,y,z])
function point_distance_vec3(_a, _b) {
	return point_distance_3d(_a[vX],_a[vY],_a[vZ],_b[vX],_b[vY],_b[vZ]);
}

///@func vec3_add(vec3, vec3, vec3...)
///returns a new vector with the given vectors added together
function vec3_add() {
	var _new = [0,0,0];
	for(var _i= 0; _i<argument_count; _i++)
	{
		var _vec = argument[_i];
		_new[0]+=_vec[0];
		_new[1]+=_vec[1];
		_new[2]+=_vec[2];
	}
	return _new;
}

///@func vec3_length([x,y,z])
///@description returns the length of the given 3D vector
function vec3_length(_v1) {
	var _tot = 0;
	_tot+=_v1[0]*_v1[0];
	_tot+=_v1[1]*_v1[1];
	_tot+=_v1[2]*_v1[2];
	if(_tot != 0)
		_tot = sqrt(_tot);
	
	return _tot;
}

///@func vec3_normalize([x,y,z])
///@description Returns a 3D vector with a length of 1
function vec3_normalize(_v1) {
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

///@fucn vec3_scale([x,y,z], scaler)
/// scales the given vec3 array by the given value
function vec3_scale(_vec, _scale) {
	_vec[0]*=_scale;
	_vec[1]*=_scale;
	_vec[2]*=_scale;
	return _vec;
}