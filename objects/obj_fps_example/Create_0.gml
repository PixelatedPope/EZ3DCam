/// @description
EZ3D_ENABLE;
z_floor = -30;
z_speed = 0;
turn_speed = 2;
ez3dcam_set_position([room_width/2,room_height/2,z_floor]);

instance_create_depth(0,0,0,obj_3d_floor);
instance_create_depth(0,0,0,obj_3d_skybox);
