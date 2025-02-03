/// @description get current frame and angle

var _dir = objEz3dCam.ezCam.getDirection();
_dir = point_direction(0,0,_dir[V_X],_dir[V_Y]);
_dir = round_n(angle_difference(face_dir,_dir),90);
scale = V_ONE;
switch(_dir)
{
	case 0: sprite_index = spr_char_north; break;
	case -90: scale[V_X]=-1;
	case 90: sprite_index = spr_char_east; break;
	case -180:
	case 180: sprite_index = spr_char_south; break;
}

texture = sprite_get_texture(sprite_index,image_index);
var _spr_index = array_get_index(sprites, sprite_index);
vertex = frames[# floor(image_index), _spr_index];

var _cam = objEz3dCam.ezCam.getPosition();
rotation = [0,0,point_direction(x,y,_cam[V_X],_cam[V_Y])-90] // -90 to face the camera.
