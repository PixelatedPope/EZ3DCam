/// @description Draw 3D
var _view = 0;
draw_set_color(c_white);

#region 3D Projection Setup
camera_set_view_mat(view_camera[_view], view_matrix);
camera_set_proj_mat(view_camera[_view], proj_matrix);
camera_apply(view_camera[_view]);
#endregion

#region Draw 3D Objects
gpu_set_ztestenable(true);
gpu_set_alphatestref(254);
gpu_set_zwriteenable(true);

shader_set(shd_default);
with(int_3d_object)
{
	event_perform(ev_draw,0);
}
shader_reset();
#endregion

#region//Reset back to Ortho
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
matrix_set(matrix_world,matrix_build_identity()); 

var _viewmat = matrix_build_lookat(View_Width/2, View_Height/2, -10, View_Width/2, View_Height/2, 0, 0, 1, 0);
var _projmat = matrix_build_projection_ortho(View_Width,View_Height, 1.0, 32000.0);

camera_set_view_mat(view_camera[_view], _viewmat);
camera_set_proj_mat(view_camera[_view], _projmat);

camera_apply(view_camera[_view]);
#endregion
timer++;