///@param array_yaw_pitch_roll
///Adjusts the current yaw, pitch, and roll values of the camera by the given amount.
with(EZ3D)
{
	var _array=argument0;
	ez3dcam_set_orientation([camera_yaw   + _array[0],
													 camera_pitch + _array[1],
													 camera_roll  + _array[2]]);
}