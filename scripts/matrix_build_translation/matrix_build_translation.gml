/// @param pos_xyz

var _arr = argument0;
if(array_length_1d(_arr) == 3)
	return matrix_build(_arr[vX],_arr[vY],_arr[vZ],0,0,0,1,1,1);

return matrix_build(_arr[mX],_arr[mY],_arr[mZ],0,0,0,1,1,1);