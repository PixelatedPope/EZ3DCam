///@description Sets the view distance
///@param distance 
with(EZ3D)
{
	if(zfar == argument0) exit;
	
	zfar = max(argument0,1);
	camera_has_moved=true;
}