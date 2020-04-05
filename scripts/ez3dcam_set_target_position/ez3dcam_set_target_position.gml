///@param xyz_pos
with(EZ3D)
{
	if(array_equals(camera_target, argument0)) exit;
	camera_has_moved = true;
	camera_target = argument0;
	if(camera_mode == EZ3DCam.mode_track_target)
		camera_distance = ez3dcam_get_distance_to_point(camera_target);
}