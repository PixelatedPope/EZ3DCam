/// @desc Rotates around the world's z-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams

return quaternion_multiply([dcos(argument1/2), 0, 0, dsin(argument1/2)],
                           [argument0[0], argument0[1], argument0[2], argument0[3]]);