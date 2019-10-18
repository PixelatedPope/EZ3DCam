///@param xyz_pos
with(EZ3D)
{
	if(array_equals(camera_target, argument0)) exit;
	camera_has_moved = true;
	camera_target = argument0;
}