///Returns the current 3D camera horizontal resolution
with(EZ3D)
{
  return camera_height == undefined ? camera_get_view_height(view_camera[0]) : camera_height;
}