///@param move_xyz
with(EZ3D)
{
	var _delta = argument0;
	ez3dcam_set_position([camera_position[vX]+_delta[vX],
												camera_position[vY]+_delta[vY],
												camera_position[vZ]+_delta[vZ]]);
}