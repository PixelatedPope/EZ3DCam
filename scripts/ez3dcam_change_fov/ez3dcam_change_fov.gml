///@description Sets the field of view angle 
///@param fov_delta (default 45)
with(EZ3D)
{
	if(fov == fov+argument0) exit;
	
	fov = clamp(fov+argument0,1,179);
	camera_has_moved=true;
}