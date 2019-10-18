/// @description window_zoom Window & Toggle Sub Pixels
if(keyboard_check_pressed(ord("1")))
{ //Change Window Size
  window_zoom++;
  if(window_zoom>max_zoom)
    window_zoom=1;
  window_set_size(ideal_width*window_zoom,ideal_height*window_zoom);
  display_set_gui_size(ideal_width*window_zoom,ideal_height*window_zoom);
  if(use_sub_pixels)
    surface_resize(application_surface,ideal_width*window_zoom,ideal_height*window_zoom);
  alarm[0]=1;
}

if(keyboard_check_pressed(ord("2")))
{ //Toggle SubPixels
  use_sub_pixels=!use_sub_pixels
  if(use_sub_pixels)
    surface_resize(application_surface,ideal_width*window_zoom,ideal_height*window_zoom);
  else
    surface_resize(application_surface,ideal_width,ideal_height);
}

