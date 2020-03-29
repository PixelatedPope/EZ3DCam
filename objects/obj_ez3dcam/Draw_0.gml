/// @description Draw 3D
var _cam = view_camera[0];
var _ortho_view_mat = camera_get_view_mat(_cam);
var _ortho_proj_mat = camera_get_proj_mat(_cam);
event_user(0); //Build View and Matrix Projections

draw_set_color(c_white);
if(camera_surface != undefined)
{
	if(!surface_exists(camera_surface))
		camera_surface = surface_create(camera_width, camera_height);
	surface_set_target(camera_surface);
	draw_clear_alpha(camera_surface_bg_color,camera_surface_bg_alpha);
}


#region 3D Projection Setup
camera_set_view_mat(_cam, view_matrix);
camera_set_proj_mat(_cam, proj_matrix);
camera_apply(_cam);
#endregion

#region Draw 3D Objects
gpu_set_ztestenable(true);
gpu_set_alphatestref(254);
gpu_set_zwriteenable(true);

shader_set(shd_default);
with(par_3d_object)
{
	event_perform(ev_draw,0);
}
shader_reset();
#endregion

if(camera_surface != undefined) 
	surface_reset_target();

#region//Reset back to Ortho
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
matrix_set(matrix_world,matrix_build_identity()); 

_ortho_proj_mat[5] = abs(_ortho_proj_mat[5]); //Why?  Because GM is kinda dumb.
camera_set_view_mat(_cam, _ortho_view_mat);
camera_set_proj_mat(_cam, _ortho_proj_mat);
camera_set_view_size(_cam, prev_view_width, prev_view_height);
camera_apply(_cam);

#endregion
timer++;