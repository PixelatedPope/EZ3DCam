//FOG AND LIGHTING (should be defaulted to true but bug prevents this in HTML5)
#macro FOG_DEFAULT_ON os_browser == browser_not_a_browser
#macro LIGHT_DEFAULT_ON os_browser == browser_not_a_browser


///Display
#macro DISP_W display_get_width()
#macro DISP_H display_get_height()
#macro WIN_W window_get_width()
#macro WIN_H window_get_height()

#macro BASE_H 400
#macro BASE_W 800

#macro VIEW view_camera[0]
#macro VIEW_X camera_get_view_x(VIEW)
#macro VIEW_Y camera_get_view_y(VIEW)
#macro VIEW_W camera_get_view_width(VIEW)
#macro VIEW_H camera_get_view_height(VIEW)
#macro VIEW_R (VIEW_X + VIEW_W)
#macro VIEW_B (VIEW_Y + VIEW_H)
#macro VIEW_CENTER_X (VIEW_X + VIEW_W/2)
#macro VIEW_CENTER_Y (VIEW_Y + VIEW_H/2)

#macro GUI_W display_get_gui_width()
#macro GUI_H display_get_gui_height()

//Directions
#macro NO_DIRECTION (-1)
#macro EAST 0
#macro NORTH 90
#macro WEST 180
#macro SOUTH 270
#macro NORTH_EAST 45
#macro NORTH_WEST 135
#macro SOUTH_WEST 225
#macro SOUTH_EAST 315