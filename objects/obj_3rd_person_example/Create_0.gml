/// @description
/// @description
ez3dcam_enable(); //Enables EZ3D at this object's depth.
ez3dcam_set_mode(EZ3DCam.mode_third_person);

ez3dcam_set_position([room_width/2,room_height/2,-10]);
//Our 3D Objects for this example.  
//For more information on how they are created and manipulated, check out the object.
instance_create_depth(0,0,0,obj_3d_floor);
instance_create_depth(0,0,0,obj_3d_skybox);
character = instance_create_depth(room_width/2,room_height/2,0,obj_character); 
ez3dcam_set_target_position([room_width/2,room_height/2,0]);
ez3dcam_set_distance_from_target(300);
ez3dcam_set_orientation([0,15,0]);
