///Zoom window
if(keyboard_check_pressed(vk_f3))
{
  window_scale = window_scale+1 > window_scale_max ? 1 : window_scale+1;
  
  window_set_size(base_width*window_scale,base_height*window_scale);
  surface_resize(application_surface,base_width*window_scale,base_height*window_scale);
  center_window;
}
if(keyboard_check_pressed(vk_f4))
{
  window_set_fullscreen(!window_get_fullscreen());
  if(!window_get_fullscreen())
  {
    window_set_size(base_width*window_scale,base_height*window_scale);
    surface_resize(application_surface,base_width*window_scale,base_height*window_scale);
    center_window;
  }
  else
    surface_resize(application_surface,disp_w,disp_h);
}
