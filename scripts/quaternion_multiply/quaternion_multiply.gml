/// @desc Multiplies two quaternions together, adding one rotation onto another.
/// @param quat1
/// @param quat2
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams

var _q1 = argument0;
var _q2 = argument1;

var _x1 = _q1[0], _y1 = _q1[1], _z1 = _q1[2], _w1 = _q1[3];
var _x2 = _q2[0], _y2 = _q2[1], _z2 = _q2[2], _w2 = _q2[3];

return [_x1*_x2 - _y1*_y2 - _z1*_z2 - _w1*_w2,
        _x1*_y2 + _y1*_x2 + _z1*_w2 - _w1*_z2,
        _x1*_z2 + _z1*_x2 + _w1*_y2 - _y1*_w2,
        _x1*_w2 + _w1*_x2 + _y1*_z2 - _z1*_y2];
