///Zoom window
if(keyboard_check_pressed(ord("1")))
{
 windowScale = windowScale+1 > windowScale_max ? 1 : windowScale+1;
 
 window_set_size(BASE_W*windowScale,BASE_H*windowScale);
 surface_resize(application_surface,BASE_W*windowScale,BASE_H*windowScale);
 alarm[0]=1;
}
if(keyboard_check_pressed(ord("2")))
{
 window_set_fullscreen(!window_get_fullscreen());
}
// if(!window_get_fullscreen())
// {
//  window_set_size(BASE_W*windowScale,BASE_H*windowScale);
//  surface_resize(application_surface,BASE_W*windowScale,BASE_H*windowScale);
//  alarm[0]=1;
// }
// else
//  surface_resize(application_surface,disp_w,disp_h);
//}
