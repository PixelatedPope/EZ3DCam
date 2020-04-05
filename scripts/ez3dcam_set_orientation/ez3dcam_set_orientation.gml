///@param array_yaw_pitch_roll
with(EZ3D)
{
	var _array = argument0;
	if(camera_yaw != _array[0])
	{
		camera_has_moved=true;
		camera_yaw = _array[0];
	}
	if(camera_pitch != _array[1])
	{
		camera_has_moved=true;
		camera_pitch = _array[1];
	}
	if(camera_roll != _array[2])
	{
		camera_has_moved=true;
		camera_roll = _array[2];
	}
}
