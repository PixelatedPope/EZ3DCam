/// @description Draw 3D
var _cam = view_camera[0];
var _vw = camera_get_view_width(_cam);
var _vh = camera_get_view_height(_cam);
var _ortho_view_mat = camera_get_view_mat(_cam);
var _ortho_proj_mat = camera_get_proj_mat(_cam);
var _surf_width = ez3dcam_get_width();
var _surf_height = ez3dcam_get_height();
var _scale = _vw/_surf_width;

event_user(0); //Build View and Matrix Projections

draw_set_color(c_white);

if(!surface_exists(camera_surface))
	camera_surface = surface_create(_surf_width,_surf_height);
//surface_set_target(camera_surface);
//draw_clear_alpha(camera_surface_bg_color,camera_surface_bg_alpha);


#region 3D Projection Setup
camera_set_view_mat(_cam, view_matrix);
camera_set_proj_mat(_cam, proj_matrix);
camera_apply(_cam);
#endregion

#region Draw 3D Objects
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(10);
gpu_set_zwriteenable(true);

//draw_light_define_ambient(c_black);
draw_set_lighting(true);
draw_light_define_point(0,camera_position[vX],camera_position[vY],camera_position[vZ],1500,c_white);
draw_light_enable(0,true);

for(var _i=0; _i< ds_list_size(instance_register); _i++)
{
  with(instance_register[| _i])
  	event_perform(ev_draw,0);

}
gpu_set_fog(false,0,0,0);
#endregion

//surface_reset_target();

#region//Reset back to Ortho
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_alphatestenable(false);
matrix_set(matrix_world,matrix_build_identity()); 

_ortho_proj_mat[5] = abs(_ortho_proj_mat[5]); //Why?  Because GM is kinda dumb.
camera_set_view_mat(_cam, _ortho_view_mat);
camera_set_proj_mat(_cam, _ortho_proj_mat);
camera_set_view_size(_cam, prev_view_width, prev_view_height);
camera_apply(_cam);

#endregion

//Finally, draw the 3D
//if(camera_draw_surface)
//  draw_surface_ext(camera_surface,camera_get_view_x(_cam),camera_get_view_y(_cam),_scale,_scale,0,c_white,1);

timer++;