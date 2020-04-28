/// @description
if(camera_surface != undefined && surface_exists(camera_surface))
	surface_free(camera_surface);
  
ds_list_destroy(instance_register);