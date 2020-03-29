///@param EZ3dCam.render_target_
///@param width
///@param height
///@param surface_bg_color
///@param surface_bg_alpha

with(EZ3D)
{
	if(argument0 == EZ3DCam.render_target_default)
	{
		camera_width = undefined;
		camera_height = undefined;
		if(camera_surface != undefined && surface_exists(camera_surface))
			surface_free(camera_surface);
		camera_surface = undefined;
	}
	else
	{
		camera_width = argument1;
		camera_height = argument2;
		camera_surface = noone;
		camera_surface_bg_color = argument3;
		camera_surface_bg_alpha = argument4;
	}
}