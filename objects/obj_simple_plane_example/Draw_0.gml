/// @description
//EZ3D.drawSurface(VIEW_W/2-100,VIEW_H/2-100,1,1,0,c_white,1);

/// @description
var _dir = EZ3D.getDirection();
//Lighting
draw_light_define_direction(1,_dir[vX],_dir[vY],_dir[vZ],c_white)
draw_light_enable(1,true);