///@param EZ3DCam.mode_
with(EZ3D)
{
	if(argument0 == camera_mode) exit;

	camera_mode = argument0;
	camera_has_moved = true;
}