/// @description
//objEz3dCam.ezCam.drawSurface(VIEW_W/2-100,VIEW_H/2-100,1,1,0,c_white,1);

/// @description
var _dir = objEz3dCam.ezCam.getDirection();
//Lighting
draw_light_define_direction(1,_dir[V_X],_dir[V_Y],_dir[V_Z],c_white)
draw_light_enable(1,true);