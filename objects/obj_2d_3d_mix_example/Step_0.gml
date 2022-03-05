/// @description
if(keyboard_check_pressed(ord("R")))
 objEz3dCam.ezCam.setSize(objEz3dCam.ezCam.getWidth() != VIEW_W ? VIEW_W : window_get_width(),
          objEz3dCam.ezCam.getHeight() != VIEW_H ? VIEW_H : window_get_height());