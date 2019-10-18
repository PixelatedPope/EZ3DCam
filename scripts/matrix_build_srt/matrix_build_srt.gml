///@param scale_xyz
///@param rotation_xyz
///@param translation_xyz
var _m =  matrix_combine(matrix_build_scale(argument0),
												 matrix_build_rotation(argument1),
												 matrix_build_translation(argument2));
return _m;