/// @description
if(keyboard_check_pressed(ord("R")))
  EZ3D.set_size(EZ3D.get_width() != view_w ? view_w : window_get_width(),
                   EZ3D.get_height() != view_h ? view_h : window_get_height());