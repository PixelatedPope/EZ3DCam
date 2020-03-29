/// @description
randomize();
EZ3D_ENABLE;
ez3dcam_set_zfar(10000);
ez3dcam_set_position([room_width/2,room_height/2,-50]);
ez3dcam_set_rotation_mode(EZ3DCam.rotation_world);
ez3dcam_set_mode(EZ3DCam.mode_third_person);
distance = 300;

ez3dcam_set_render_target(EZ3DCam.render_target_surface,200,200,c_black,.5);
instance_create_depth(room_width/2,room_height/2,0,obj_simple_plane);