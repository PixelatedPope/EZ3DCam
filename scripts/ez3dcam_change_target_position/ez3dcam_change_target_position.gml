///@param move_xyz
with(EZ3D)
{
	var _delta = argument0;
	ez3dcam_set_target_position([camera_target[vX]+_delta[vX],
															 camera_target[vY]+_delta[vY],
															 camera_target[vZ]+_delta[vZ]]);
}