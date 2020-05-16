 ///  @description Properties
#macro EZ3D obj_ez3dcam

#region Camera and Projection
prev_view_width = 0;
prev_view_height = 0;
camera_mode = EZ3DCam.mode_first_person;
camera_width = undefined;
camera_height = undefined;
camera_surface = noone;
camera_draw_surface = true;
camera_surface_bg_color = c_black;
camera_surface_bg_alpha = 0;

camera_target = vZERO;
camera_position = vZERO;
camera_direction = vZERO;
camera_direction_right = vZERO;
camera_direction_up = vZERO;

camera_up = matrix_build_translation([0,0,1]);
camera_distance = 1;

camera_angle_matrix = matrix_build_identity();
camera_angle_quat = quaternion_create();
camera_roll = 0;
camera_yaw = 0;
camera_pitch = 0;
camera_rotation_mode = EZ3DCam.rotation_local;
camera_has_moved = true;

proj_matrix = [];
view_matrix = [];

zfar = 10000;
fov = 45;
#endregion

#region vertex format
//Standard vertex format.  Feel free to replace with your own if necessary
vertex_format_begin()
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_colour();
vertex_format_add_texcoord();
vertex_format = vertex_format_end();
instance_register = ds_list_create();
#endregion

#region functions
function setMode(_mode) //default: EZ3DCam.mode_first_person
{
	if(_mode == camera_mode) exit;
	camera_mode = _mode;
	camera_has_moved = true;
}
function setRotationMode(_mode) //Default EZ3DCam.rotation_local
{
	camera_rotation_mode = _mode;
}
function getMode() 
{
	return camera_mode;
}

function getRotationMode() 
{
	return camera_rotation_mode;
}

function getTargetPosition() 
{
	return camera_target;
}
function setTargetPosition(_posXYZ) 
{	
	if(array_equals(camera_target, _posXYZ)) exit;
	camera_has_moved = true;
	camera_target = _posXYZ;
	if(camera_mode == EZ3DCam.mode_track_target)
		camera_distance = getDistanceToPoint(camera_target);	
}
function setDistanceFromTarget(_dist) {
	if(camera_mode != EZ3DCam.mode_third_person || camera_distance == _dist) exit;
	camera_distance = _dist;
	camera_has_moved = true;
}
function changeDistanceFromTarget(_distDelta) 
{
	if(camera_mode != EZ3DCam.mode_third_person || camera_distance == camera_distance+_distDelta) exit;
	camera_distance += _distDelta;
	camera_has_moved = true;
}
function getZfar() 
{
	return zfar;
}
function setZfar(_zfar) ///default: 10000
{
	if(zfar == _zfar) exit;
	
	zfar = max(_zfar,1);
	camera_has_moved=true;
}
function getFov() 
{
	return fov;
}
function setFov(_fov) 
{
	if(fov == _fov) exit;
	
	fov = clamp(_fov,1,179);
	camera_has_moved=true;
}
function changeFov(_fovDelta) 
{
	if(fov == fov+_fovDelta) exit;
		fov = clamp(fov+_fovDelta,1,179);
	camera_has_moved=true;
}
function getHeight() 
{
  return camera_height == undefined ? camera_get_view_height(view_camera[0]) : camera_height;
}
function getWidth() 
{
  return camera_width == undefined ? camera_get_view_width(view_camera[0]) : camera_width;
}
function setSize(_width, _height) 
{
	camera_width = _width;
	camera_height = _height;
}
function setOrientation(_oriYPR) {
	if(camera_yaw != _oriYPR[0])
	{
		camera_has_moved=true;
		camera_yaw = _oriYPR[0];
	}
	if(camera_pitch != _oriYPR[1])
	{
		camera_has_moved=true;
		camera_pitch = _oriYPR[1];
	}
	if(camera_roll != _oriYPR[2])
	{
		camera_has_moved=true;
		camera_roll = _oriYPR[2];
	}
}
function getOrientation() 
{
	return [camera_yaw, camera_pitch, camera_roll];
}
function getPitch() 
{
	return camera_pitch;
}
function getRoll() {
	return camera_roll;
}
function getYaw() {
	return camera_yaw;
}
function changeOrientation(_oriDeltaYPR) 
{
		setOrientation([camera_yaw   + _oriDeltaYPR[0],
										camera_pitch + _oriDeltaYPR[1],
										camera_roll  + _oriDeltaYPR[2]]);
}
function setPosition(_posXYZ) {
	if(array_equals(camera_position, _posXYZ)) exit;
	camera_has_moved = true;
	camera_position = _posXYZ;
	camera_distance = getDistanceToPoint(camera_target);
}
function getPosition() 
{
	return camera_position;
}

function changePosition(_posDeltaXYZ) 
{
	setPosition([camera_position[vX]+_posDeltaXYZ[vX],
	 						 camera_position[vY]+_posDeltaXYZ[vY],
	 						 camera_position[vZ]+_posDeltaXYZ[vZ]]);
}

function changeTargetPosition(_tarDeltaXYZ) {
		setTargetPosition([camera_target[vX]+_tarDeltaXYZ[vX],
											 camera_target[vY]+_tarDeltaXYZ[vY],
											 camera_target[vZ]+_tarDeltaXYZ[vZ]]);
}
function get_direction() 
{
	return camera_direction;
}
function getDirectionRight() {
	return camera_direction_right;
}
function getDirectionUp() {
	return camera_direction_up;
}
function getDistanceToPoint(_posXYZ) {
	var _x = _posXYZ[vX],
			_y = _posXYZ[vY],
			_z = _posXYZ[vZ],
			_cx = camera_position[vX],
			_cy = camera_position[vY],
			_cz = camera_position[vZ];
		
	return point_distance_3d(_x,_y,_z,_cx,_cy,_cz);
}

function drawSurface(_x, _y, _xscale, _yscale, _rot, _col, _alpha) 
{
		if(camera_surface != undefined && surface_exists(camera_surface))
			draw_surface_ext(camera_surface,_x,_y,_xscale,_yscale,_rot,_col,_alpha);
}

function setRenderTarget(_width, _height, _surfBGCol, _surfBGAlpha, _autoDrawEnabled) 
{
	camera_width = _width == -1 ? undefined : _width;
	camera_height = _height == -1 ? undefined : _height;
	camera_surface_bg_color = _surfBGCol;
	camera_surface_bg_alpha = _surfBGAlpha;
	camera_draw_surface = _autoDrawEnabled;
}

function unregisterInstance(_id) 
{
	if(!ds_exists(ds_type_list,instance_register)) exit;
	var _index = ds_list_find_index(instance_register,_id);
	if(_index != -1)
	  ds_list_delete(instance_register, _index);
}
function registerInstance(_id) 
{
	ds_list_add(instance_register, _id);
}

#endregion

function rebuildCameraMatrix()
{
	prev_view_width = camera_get_view_width(view_camera[0]);
	prev_view_height = camera_get_view_height(view_camera[0]);

	if(camera_width != undefined && camera_height != undefined)
		camera_set_view_size(view_camera[0],camera_width,camera_height);

	var _vw = camera_get_view_width(view_camera[0]);
	var _vh = camera_get_view_height(view_camera[0]);

	switch(camera_mode)
	{
		#region First Person
		case EZ3DCam.mode_first_person:
			if(!camera_has_moved) break;
		
			if(camera_rotation_mode == EZ3DCam.rotation_local)
			{
				camera_angle_quat = quaternion_create();
		    camera_angle_quat = quaternion_rotate_worldz(camera_angle_quat, camera_yaw);
		    camera_angle_quat = quaternion_rotate_localz(camera_angle_quat, camera_pitch);
		    camera_angle_quat = quaternion_rotate_localx(camera_angle_quat, camera_roll);
			}
			else
			{
				var _pitch = quaternion_create(),
						_yaw = quaternion_create(),
						_roll = quaternion_create();
					
				_pitch = quaternion_rotate_localz(_pitch,camera_pitch);
				_yaw = quaternion_rotate_localy(_yaw,camera_yaw);	
				_roll = quaternion_rotate_localx(_roll,camera_roll);		
				camera_pitch=0; camera_yaw=0; camera_roll=0;
				camera_angle_quat = quaternion_combine(camera_angle_quat,_pitch,_yaw,_roll);
			}
			camera_angle_matrix = quaternion_matrix(camera_angle_quat);

			camera_direction = matrix_to_vec3(matrix_combine(matrix_build_translation([1,0,0]),camera_angle_matrix));
			camera_direction = vec3_normalize(camera_direction);		
			camera_direction_right = matrix_to_vec3(matrix_combine(matrix_build_translation([0,-1,0]),camera_angle_matrix));
			camera_direction_up = matrix_to_vec3(matrix_combine(matrix_build_translation([0,0,1]),camera_angle_matrix));
			camera_target = vec3_add(camera_direction,camera_position);
		
		break;
		#endregion
		#region Third Person
		case EZ3DCam.mode_third_person:
			if(camera_rotation_mode == EZ3DCam.rotation_local)
			{
				camera_angle_quat = quaternion_create();
		    camera_angle_quat = quaternion_rotate_worldz(camera_angle_quat, camera_yaw);
		    camera_angle_quat = quaternion_rotate_localz(camera_angle_quat, camera_pitch);
				camera_angle_quat = quaternion_rotate_localx(camera_angle_quat, camera_roll);
			}
			else
			{
				var _pitch = quaternion_create(),
						_yaw = quaternion_create(),
						_roll = quaternion_create();
					
				_pitch = quaternion_rotate_localz(_pitch,camera_pitch);
				_yaw = quaternion_rotate_localy(_yaw,camera_yaw);	
				_roll = quaternion_rotate_localx(_roll,-camera_roll);		
				camera_pitch=0; camera_yaw=0; camera_roll=0;
				camera_angle_quat = quaternion_combine(camera_angle_quat,_pitch,_yaw,_roll);
			}
			camera_angle_matrix = quaternion_matrix(camera_angle_quat);
			var _matrix = matrix_combine(matrix_build_translation([camera_distance,0,0]),
																	 camera_angle_matrix,
																	 matrix_build_translation(camera_target));

			camera_position = [_matrix[mX],_matrix[mY],_matrix[mZ]];
		
			camera_direction = matrix_to_vec3(matrix_combine(matrix_build_translation([-1,0,0]),camera_angle_matrix));
			camera_direction_right = matrix_to_vec3(matrix_combine(matrix_build_translation([0,1,0]),camera_angle_matrix));
			camera_direction_up = matrix_to_vec3(matrix_combine(matrix_build_translation([0,0,1]),camera_angle_matrix));
		
		break;
		#endregion
		#region Track Target
		case EZ3DCam.mode_track_target:
			//calculate camera properties
			var _tar = camera_target;
			var _pos = camera_position;
			camera_distance = point_distance_vec3(_tar,_pos)
			camera_yaw = -point_direction(_pos[vX],_pos[vY],_tar[vX],_tar[vY]);

			var _ratio = (_pos[vZ]-_tar[vZ])/camera_distance;
			camera_pitch = radtodeg(arcsin(_ratio));
		
			var _angle = quaternion_create();
			_angle = quaternion_rotate_worldz(_angle, camera_yaw);
			_angle = quaternion_rotate_localz(_angle, camera_pitch);
			//angle_quat_no_roll = array_duplicate(_angle);
			_angle = quaternion_rotate_localx(_angle, camera_roll);
			camera_angle_quat = _angle;
			camera_angle_matrix = quaternion_matrix(_angle);
		
			camera_direction = matrix_to_vec3(matrix_combine(matrix_build_translation([1,0,0]),camera_angle_matrix));
			camera_direction_right = matrix_to_vec3(matrix_combine(matrix_build_translation([0,-1,0]),camera_angle_matrix));
			camera_direction_up = matrix_to_vec3(matrix_combine(matrix_build_translation([0,0,1]),camera_angle_matrix));
		break;
		#endregion
	}
														 
	var _up = matrix_combine(matrix_build_translation(camera_up),camera_angle_matrix),
			_aspect = _vw/_vh,
			_pos = camera_position;
	view_matrix = matrix_build_lookat(_pos[vX], _pos[vY], _pos[vZ],
									                  _pos[vX] + camera_direction[vX], _pos[vY] + camera_direction[vY], _pos[vZ] + camera_direction[vZ],
									                  _up[mX],_up[mY],_up[mZ]);											 
	proj_matrix = matrix_build_projection_perspective_fov(fov, _aspect, 1, zfar);
	
}
timer=0;