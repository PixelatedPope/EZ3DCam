/// @description get current frame and angle

var _dir = ez3dcam_get_direction();
_dir = point_direction(0,0,_dir[vX],_dir[vY]);
_dir = round_n(angle_difference(face_dir,_dir),90);
scale = vONE;
switch(_dir)
{
	case 0: sprite_index = spr_char_north; break;
	case -90: scale[vX]=-1;
	case 90: sprite_index = spr_char_east; break;
	case -180:
	case 180: sprite_index = spr_char_south; break;
}

texture = sprite_get_texture(sprite_index,image_index);
vertex = frames[# floor(image_index),sprite_index-spr_char_south];

var _cam = ez3dcam_get_position();
rotation = [0,0,point_direction(x,y,_cam[vX],_cam[vY])-90]  // -90 to face the camera.
