/// @description
ez3dcam_enable();
ez3dcam_set_zfar(10000);
ez3dcam_set_position([5000,5000,-50]);
ez3dcam_change_orientation(45,0,0);
ez3dcam_set_rotation_mode(EZ3DCam.rotation_world);

instance_create_depth(0,0,0,obj_3d_floor);
instance_create_depth(0,0,0,obj_3d_skybox);

throttle = 0;