///@param width
///@param height
with(EZ3D)
{
  if(camera_width == argument0 && camera_height == argument1) exit;
	camera_width = argument0;
	camera_height = argument1;
  surface_free(camera_surface);
}