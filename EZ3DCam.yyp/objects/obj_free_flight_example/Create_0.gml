/// @description
objEz3dCam.ezCam.setZFar(10000);
objEz3dCam.ezCam.setPosition([5000,5000,-50]);
objEz3dCam.ezCam.changeOrientation([45,0,0]);
objEz3dCam.ezCam.setRotationMode(EZ3DCam.rotation_world);

instance_create_depth(0,0,0,obj_3d_floor);
instance_create_depth(0,0,0,obj_3d_skybox);

throttle = 0;