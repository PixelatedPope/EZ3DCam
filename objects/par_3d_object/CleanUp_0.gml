/// @description
if(instance_exists(objEz3dCam))
	objEz3dCam.ezCam.deregisterInstance(id);

if(vertex != noone)  vertex_delete_buffer(vertex);