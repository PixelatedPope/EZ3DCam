/// @description
x+=5;
camera_set_view_pos(cam,clamp(x-view_w/2,0,room_width-view_w),0);
if(x > room_width + 100)
  x=-100;