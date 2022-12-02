/// @description
/// @description

objEz3dCam.ezCam.setMode(EZ3DCam.mode_third_person);

objEz3dCam.ezCam.setPosition([room_width/2,room_height/2,-10]);
//Our 3D Objects for this example. 
//For more information on how they are created and manipulated, check out the object.
instance_create_depth(0,0,0,obj_3d_floor);
instance_create_depth(0,0,0,obj_3d_skybox);
character = instance_create_depth(room_width/2,room_height/2,0,obj_character); 
objEz3dCam.ezCam.setTargetPosition([room_width/2,room_height/2,0]);
objEz3dCam.ezCam.setDistanceFromTarget(300);
objEz3dCam.ezCam.setOrientation([0,15,0]);
