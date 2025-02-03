/// @description

/*All the EZ3DCam settings are "default" right now. 
 This is a basic 3D cameraat 0,0,0 looking "right".
 But what is "right"?
 objEz3dCam.ezCam's coordinate system is the same as your room's. So "right" is x+
 so if we want to create objects "in front" of the camera, we create them
 at any x position greater than 0. Adjusting their y position will shift them
 left (-) and right(+).
*/
gpu_set_cullmode(cull_noculling);

//Our 3D Objects for this example. 
//For more information on it is created and manipulated, check out the object.
instance_create_depth(700,0,0,obj_tower);
//Want to change how the 3D is rendered?
//Uncomment the below line.
//Set the last argument to false and uncomment the line in the draw event.
//objEz3dCam.ezCam.setRenderTarget(200,100,c_black,0,true);
//Play with the size and color/alpha options!