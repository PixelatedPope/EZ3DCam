/// @description Draw 3D
var _cam = view_camera[0];
var _vw = camera_get_view_width(_cam);
var _vh = camera_get_view_height(_cam);
var _ortho_view_mat = camera_get_view_mat(_cam);
var _ortho_proj_mat = camera_get_proj_mat(_cam);
var _surf_width = getWidth();
var _surf_height = getHeight();
var _scale = _vw/_surf_width;

rebuildCameraMatrix();
draw_set_color(c_white);

if(!surface_exists(cameraSurface))
	cameraSurface = surface_create(_surf_width,_surf_height);
surface_set_target(cameraSurface);
draw_clear_alpha(cameraSurfaceBgColor,cameraSurfaceBgAlpha);


#region 3D Projection Setup
camera_set_view_mat(_cam, viewMatrix);
camera_set_proj_mat(_cam, progMatrix);
camera_apply(_cam);
#endregion

#region Draw 3D Objects

//draw_light_define_ambient(c_black);
draw_set_lighting(true);
draw_light_define_point(0,cameraPosition[vX],cameraPosition[vY],cameraPosition[vZ],1500,c_white);
draw_light_enable(0,true);

//Draw Skybox
with(skyboxId)
{
 event_perform(ev_draw,0); 
}


gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(10);
gpu_set_zwriteenable(true);

for(var _i=0; _i< ds_list_size(instanceRegister); _i++)
{
 with(instanceRegister[| _i])
 {
  if(id == other.skyboxId) continue;
 	event_perform(ev_draw,0);
 }
}
gpu_set_fog(false,0,0,0);
#endregion

surface_reset_target();

#region//Reset back to Ortho
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_alphatestenable(false);
matrix_set(matrix_world,matrix_build_identity()); 

_ortho_proj_mat[5] = abs(_ortho_proj_mat[5]); //Why? Because GM is kinda dumb.
camera_set_view_mat(_cam, _ortho_view_mat);
camera_set_proj_mat(_cam, _ortho_proj_mat);
camera_set_view_size(_cam, prevViewWidth, prevViewHeight);
camera_apply(_cam);

#endregion

//Finally, draw the 3D
if(cameraShouldDrawSurface)
 draw_surface_ext(cameraSurface,camera_get_view_x(_cam),camera_get_view_y(_cam),_scale,_scale,0,c_white,1);

timer++;