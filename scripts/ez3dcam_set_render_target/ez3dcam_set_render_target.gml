///@param width (same as view: -1)
///@param height (same as view: -1)
///@param surface_bg_color (default: c_black)
///@param surface_bg_alpha (default: 0);
///@param automatic_drawing_enabled (default: true)

with(EZ3D)
{
	camera_width = argument0 == -1 ? undefined : argument0;
	camera_height = argument1 == -1 ? undefined : argument1;
	camera_surface_bg_color = argument2;
  camera_surface_bg_alpha = argument3;
  camera_draw_surface = argument4;
}