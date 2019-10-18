/// @description Ideal resolution
#macro View_Width obj_display_manager.ideal_width
#macro View_Height obj_display_manager.ideal_height
#macro Display_Width  display_get_width()
#macro Display_Height display_get_height()
ideal_width=0;
ideal_height=256;
window_zoom=3;
max_zoom=1;


//Aspect ratio
aspect_ratio = Display_Width/Display_Height;

//Calculate new ideal width.
ideal_width=round(ideal_height*aspect_ratio);

ideal_width=round_n(ideal_width,2);
ideal_height=round_n(ideal_height,2);
 
max_zoom = floor(Display_Width/ideal_width);
if(max_zoom * ideal_width == Display_Width ||
	 max_zoom * ideal_height == Display_Height)
	 max_zoom--;

window_zoom=max_zoom;
use_sub_pixels=true;

surface_resize(application_surface,
							 use_sub_pixels ? ideal_width * window_zoom : ideal_width,
							 use_sub_pixels ? ideal_height * window_zoom : ideal_height);
display_set_gui_size(ideal_width*window_zoom,ideal_height*window_zoom);
window_set_size(ideal_width*window_zoom,ideal_height*window_zoom);

room_goto_next();
alarm[0]=1;

///Options
draw_set_font(fnt_default);