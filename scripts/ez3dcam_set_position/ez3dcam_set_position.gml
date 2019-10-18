///@param pos_xyz
with(EZ3D)
{
	if(array_equals(camera_position, argument0)) exit;
	camera_has_moved = true;
	camera_position = argument0;
}