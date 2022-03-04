/// @description
if(keyboard_check_pressed(ord("R")))
 EZ3D.setSize(EZ3D.getWidth() != VIEW_W ? VIEW_W : window_get_width(),
        EZ3D.getHeight() != VIEW_H ? VIEW_H : window_get_height());