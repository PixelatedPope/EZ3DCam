///Display Properties
draw_set_font(fnt_default);
randomize();
window_scale_max = max(1,floor(disp_h/base_height));  
window_scale = window_scale_max;
window_set_size(base_width*window_scale,base_height*window_scale);
surface_resize(application_surface,base_width*window_scale,base_height*window_scale);
display_set_gui_size(base_width,base_height);
  
center_window;

room_goto_next();
