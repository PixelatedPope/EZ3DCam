///@param orbit
///@param pitch
///@param roll
with(EZ3D)
{
	if(camera_yaw != argument0)
	{
		camera_has_moved=true;
		camera_yaw = argument0;
	}
	if(camera_pitch != argument1)
	{
		camera_has_moved=true;
		camera_pitch = argument1;
	}
	if(camera_roll != argument2)
	{
		camera_has_moved=true;
		camera_roll = argument2;
	}
}
