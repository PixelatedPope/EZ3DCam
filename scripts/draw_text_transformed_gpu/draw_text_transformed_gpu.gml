/// @description draw_text_transformed_gpu
/// @param x
/// @param y
/// @param string
/// @param xscale
/// @param yscale
/// @param angle
/// Translated from GMS1 by Kirill Zolovkin
function draw_text_transformed_gpu(_x, _y, _str, _xscale, _yscale, _angle) {
	var _mtx = matrix_build(_x,_y,0,0,0,_angle,_xscale,_yscale,1);
	matrix_set(matrix_world,_mtx);
	draw_text(0,0,_str);
	matrix_set(matrix_world,matrix_build_identity());
}
