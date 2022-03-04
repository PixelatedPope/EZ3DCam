///Display Properties
draw_set_font(fnt_default);
randomize();
windowScaleMax = max(1, floor(DISP_W / BASE_W)); 
windowScale = windowScaleMax;

window_set_size(BASE_W * windowScale, BASE_H * windowScale);
surface_resize(application_surface, BASE_W * windowScale, BASE_H * windowScale);
display_set_gui_size(BASE_W, BASE_H);
 
alarm[0] = 1;

room_goto_next();
