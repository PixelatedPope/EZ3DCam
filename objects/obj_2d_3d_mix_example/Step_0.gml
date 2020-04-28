/// @description
if(keyboard_check_pressed(ord("R")))
  ez3dcam_set_size(ez3dcam_get_width() != view_w ? view_w : window_get_width(),
                   ez3dcam_get_height() != view_h ? view_h : window_get_height());