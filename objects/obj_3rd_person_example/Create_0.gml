/// @description
/// @description
ez3dcam_enable(); //Enables EZ3D at this object's depth.
EZ3D.setMode(EZ3DCam.mode_third_person);

EZ3D.set_position([room_width/2,room_height/2,-10]);
//Our 3D Objects for this example. 
//For more information on how they are created and manipulated, check out the object.
instance_create_depth(0,0,0,obj_3d_floor);
instance_create_depth(0,0,0,obj_3d_skybox);
character = instance_create_depth(room_width/2,room_height/2,0,obj_character); 
EZ3D.setTargetPosition([room_width/2,room_height/2,0]);
EZ3D.setDistanceFromTarget(300);
EZ3D.setOrientation([0,15,0]);
