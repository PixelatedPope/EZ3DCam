///@param x
///@param y
///@param xscale
///@param yscale
///@param rot
///@param col
///@param alpha
with(EZ3D)
{
	if(camera_surface != undefined && surface_exists(camera_surface))
		draw_surface_ext(camera_surface,argument0,argument1,argument2,argument3,argument4,argument5,argument6);
}