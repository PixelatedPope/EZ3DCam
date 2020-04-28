///Returns the current 3D camera horizontal resolution
with(EZ3D)
{
  return camera_width == undefined ? camera_get_view_width(view_camera[0]) : camera_width;
}