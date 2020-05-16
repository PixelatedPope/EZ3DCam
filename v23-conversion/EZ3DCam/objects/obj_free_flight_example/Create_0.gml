/// @description
ez3dcam_enable();
EZ3D.set_zfar(10000);
EZ3D.set_position([5000,5000,-50]);
EZ3D.change_orientation([45,0,0]);
EZ3D.set_rotation_mode(EZ3DCam.rotation_world);

instance_create_depth(0,0,0,obj_3d_floor);
instance_create_depth(0,0,0,obj_3d_skybox);

throttle = 0;