///@description Sets the field of view angle 
///@param fov_angle (default 45)
with(EZ3D)
{
	if(fov == argument0) exit;
	
	fov = clamp(argument0,1,179);
	camera_has_moved=true;
}