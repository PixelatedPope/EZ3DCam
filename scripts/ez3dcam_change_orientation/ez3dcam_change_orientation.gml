///@param yaw
///@param pitch
///@param roll
with(EZ3D)
{
	ez3dcam_set_orientation(camera_yaw   + argument0,
																camera_pitch + argument1,
																camera_roll  + argument2);
}