/// @desc Rotates around the model's local z-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams

return quaternion_multiply([argument0[0], argument0[1], argument0[2], argument0[3]],
                           [dcos(argument1/2), 0, dsin(argument1/2), 0]);