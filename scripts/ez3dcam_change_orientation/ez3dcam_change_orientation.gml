///@param yaw
///@param pitch
///@param roll
///Adjusts the current yaw, pitch, and roll values of the camera by the given amount.
with(EZ3D)
{
	ez3dcam_set_orientation(camera_yaw   + argument0,
													camera_pitch + argument1,
													camera_roll  + argument2);
}