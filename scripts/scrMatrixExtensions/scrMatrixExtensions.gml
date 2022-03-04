// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @param angle_xyz
function matrix_build_rotation(_rotationXYZ) {
	if(array_length(_rotationXYZ) == 3)
		return matrix_build(0,0,0,_rotationXYZ[vX],_rotationXYZ[vY],_rotationXYZ[vZ],1,1,1);

	return matrix_build(0,0,0,_rotationXYZ[mX],_rotationXYZ[mY],_rotationXYZ[mZ],1,1,1);
}
/// @param scale_xyz
function matrix_build_scale(_scaleXYZ) {
	if(array_length(_scaleXYZ) == 3)
		return matrix_build(0,0,0,0,0,0,_scaleXYZ[vX],_scaleXYZ[vY],_scaleXYZ[vZ]);

	return matrix_build(0,0,0,0,0,0,_scaleXYZ[mX],_scaleXYZ[mY],_scaleXYZ[mZ]);
}
///@param scale_xyz
///@param rotation_xyz
///@param translation_xyz
function matrix_build_srt(_scaleXYZ, _rotationXYZ, _translationXYZ) {
	return matrix_combine(matrix_build_scale(_scaleXYZ),
												matrix_build_rotation(_rotationXYZ),
												matrix_build_translation(_translationXYZ));
}
/// @param pos_xyz
function matrix_build_translation(_posXYZ) {
	if(array_length(_posXYZ) == 3)
		return matrix_build(_posXYZ[vX],_posXYZ[vY],_posXYZ[vZ],0,0,0,1,1,1);

	return matrix_build(_posXYZ[mX],_posXYZ[mY],_posXYZ[mZ],0,0,0,1,1,1);
}
///@param matrix1
///@param matrix2
///@param <matrix3>
///@param <matrix...>
function matrix_combine() {
	var _m = matrix_multiply(argument[0],argument[1])
	for(var _i=2; _i<argument_count; _i++)
	{
		_m = matrix_multiply(_m,argument[_i]);
	}
	return _m;
}
///@param matrix
/// returns a vec3 built from the x,y, and z component of the matrix
function matrix_to_vec3(_mat) {
	return [_mat[mX],_mat[mY],_mat[mZ]];
}
