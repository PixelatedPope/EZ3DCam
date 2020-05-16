/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_create() {

	return [1.0, 0.0, 0.0, 0.0000001];



}
///@param quat1
///@param quat2
///@param <quat3>
///@param <quat...>
function quaternion_combine() {


	var _q = quaternion_multiply(argument[0],argument[1])
	for(var _i=2; _i<argument_count; _i++)
	{
		_q = quaternion_multiply(_q,argument[_i]);
	}
	return _q;


}
/// @desc Makes a 4x4 column-major transform matrix from a quaternion.
/// @param quaternion
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_matrix(argument0) {

	var _quaternion = argument0;

	var _r = _quaternion[0];
	var _x = _quaternion[1];
	var _y = _quaternion[2];
	var _z = _quaternion[3];

	var _length = sqrt(_x*_x + _y*_y + _z*_z);
	var _hyp_sqr = _length*_length + _r*_r;

	//Calculate trig coefficients
	var _c   = 2*_r*_r / _hyp_sqr - 1;
	var _s   = 2*_length*_r*_hyp_sqr;
	var _omc = 1 - _c;

	//Normalise the input vector
	_x /= _length;
	_y /= _length;
	_z /= _length;

	//Build matrix
	return [_omc*_x*_x + _c   , _omc*_x*_y + _s*_z,  _omc*_x*_z - _s*_y, 0,
	        _omc*_x*_y - _s*_z, _omc*_y*_y + _c   ,  _omc*_y*_z + _s*_x, 0,
	        _omc*_x*_z + _s*_y, _omc*_y*_z - _s*_x,  _omc*_z*_z + _c   , 0,
	                         0,                  0,                   0, 1];


}
/// @desc Multiplies two quaternions together, adding one rotation onto another.
/// @param quat1
/// @param quat2
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_multiply(argument0, argument1) {

	var _q1 = argument0;
	var _q2 = argument1;

	var _x1 = _q1[0], _y1 = _q1[1], _z1 = _q1[2], _w1 = _q1[3];
	var _x2 = _q2[0], _y2 = _q2[1], _z2 = _q2[2], _w2 = _q2[3];

	return [_x1*_x2 - _y1*_y2 - _z1*_z2 - _w1*_w2,
	        _x1*_y2 + _y1*_x2 + _z1*_w2 - _w1*_z2,
	        _x1*_z2 + _z1*_x2 + _w1*_y2 - _y1*_w2,
	        _x1*_w2 + _w1*_x2 + _y1*_z2 - _z1*_y2];



}
/// @desc Rotates around the model's local x-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_localx(argument0, argument1) {

	return quaternion_multiply([argument0[0], argument0[1], argument0[2], argument0[3]],
	                           [dcos(argument1/2), dsin(argument1/2), 0, 0]);



}
/// @desc Rotates around the model's local y-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_localy(argument0, argument1) {

	return quaternion_multiply([argument0[0], argument0[1], argument0[2], argument0[3]],
	                           [dcos(argument1/2), 0, 0, dsin(argument1/2)]);


}
/// @desc Rotates around the model's local z-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_localz(argument0, argument1) {

	return quaternion_multiply([argument0[0], argument0[1], argument0[2], argument0[3]],
	                           [dcos(argument1/2), 0, dsin(argument1/2), 0]);


}
/// @desc Rotates a 3D vector (3-element 1D array) by a quaternion.
/// @param vector
/// @param quaternion
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_vector(argument0, argument1) {

	var _vector     = argument0;
	var _quaternion = argument1;

	_vector = quaternion_multiply([_quaternion[0], _quaternion[1], _quaternion[2], _quaternion[3]],
	                                           [0,     _vector[0],     _vector[1],     _vector[2]]);

	_vector = quaternion_multiply([_quaternion[0], _quaternion[1], _quaternion[2], _quaternion[3]],
	                                           [0,    -_vector[1],    -_vector[2],    -_vector[3]]);

	return [_vector[1], _vector[2], _vector[3]];


}
/// @desc Rotates around the world's x-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_worldx(argument0, argument1) {

	return quaternion_multiply([dcos(argument1/2), dsin(argument1/2), 0, 0],
	                           [argument0[0], argument0[1], argument0[2], argument0[3]]);



}
/// @desc Rotates around the world's y-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_worldy(argument0, argument1) {

	return quaternion_multiply([dcos(argument1/2), 0, dsin(argument1/2), 0],
	                           [argument0[0], argument0[1], argument0[2], argument0[3]]);



}
/// @desc Rotates around the world's z-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_worldz(argument0, argument1) {

	return quaternion_multiply([dcos(argument1/2), 0, 0, dsin(argument1/2)],
	                           [argument0[0], argument0[1], argument0[2], argument0[3]]);


}
