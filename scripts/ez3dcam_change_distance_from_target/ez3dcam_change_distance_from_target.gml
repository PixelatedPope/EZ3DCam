///@param distance_delta
with(EZ3D)
{
	if(camera_mode != EZ3DCam.mode_third_person || camera_distance == camera_distance+argument0) exit;
	camera_distance += argument0;
	camera_has_moved = true;
}