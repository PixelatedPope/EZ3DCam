/// @description
ez3dcam_enable(); //Enables EZ3D at this object's depth.
/*All the EZ3DCam settings are "default" right now.  
  This is a basic First Person camera at 0,0,0 looking "right".
  But what is "right"?
  EZ3D's coordinate system is the same as your room's.  So "right" is x+
  so if we want to create objects "in front" of the camera, we create them
  at any x position greater than 0.  Adjusting their y position will shift them
  left (-) and right(+).
*/

//Our 3D Objects for this example.  
//For more information on how they are created and manipulated, check out the object.
instance_create_depth(500,0,0,obj_simple_plane); 
instance_create_depth(1000,500,0,obj_simple_plane);
instance_create_depth(1500,-500,0,obj_simple_plane);
gpu_set_cullmode(cull_counterclockwise);

//Want to render the 3D element to a surface?
//Uncomment the below line, and the related line in the draw event.
//EZ3D._render_target(EZ3DCam.render_target_surface,200,200,c_black,.5);
//Play with the size and color/alpha options!