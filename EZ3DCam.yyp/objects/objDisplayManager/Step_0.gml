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

if(keyboard_check_pressed(ord("R")))
  objEz3dCam.ezCam.setSize(
    objEz3dCam.ezCam.getWidth() != VIEW_W ? VIEW_W : window_get_width(),
    objEz3dCam.ezCam.getHeight() != VIEW_H ? VIEW_H : window_get_height()
  );
