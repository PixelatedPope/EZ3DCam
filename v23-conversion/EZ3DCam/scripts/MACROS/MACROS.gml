function MACROS() {
	//Camera and View
#macro cam view_camera[0]
#macro base_width 800
#macro base_height 400
#macro win_w window_get_width()
#macro win_h window_get_height()
#macro disp_w display_get_width() 
#macro disp_h display_get_height() 
#macro gui_w display_get_gui_width()
#macro gui_h display_get_gui_height()
#macro view_x camera_get_view_x(cam)
#macro view_y camera_get_view_y(cam)
#macro view_w camera_get_view_width(cam)
#macro view_h camera_get_view_height(cam)
#macro view_r (view_x+view_w)
#macro view_b (view_y+view_h)
#macro mouse_gui_x device_mouse_x_to_gui(0)
#macro mouse_gui_y device_mouse_y_to_gui(0)
#macro center_window alarm[0]=1

	//Directions
#macro no_direction -1
#macro north 90
#macro east 0
#macro south 270
#macro west 180
#macro north_east 45
#macro north_west 135
#macro south_west 225
#macro south_east 315



}
