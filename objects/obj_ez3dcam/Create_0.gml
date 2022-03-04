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

//Standard vertex format.  Feel free to replace with your own if necessary

vertex_format_begin()
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_colour();
vertex_format_add_texcoord();
vertex_format = vertex_format_end();

instance_register = ds_list_create();
skybox_id = noone; 

///@param distance_delta
function change_distance_from_target(argument0) {
	if(camera_mode != EZ3DCam.mode_third_person || camera_distance == camera_distance+argument0) exit;
	camera_distance += argument0;
	camera_has_moved = true;
}
///@description Sets the field of view angle 
///@param fov_delta (default 45)
function change_fov(argument0) {
		if(fov == fov+argument0) exit;
	
		fov = clamp(fov+argument0,1,179);
		camera_has_moved=true;
}
///@param array_yaw_pitch_roll
///Adjusts the current yaw, pitch, and roll values of the camera by the given amount.
function change_orientation(argument0) {
	var _array=argument0;
	set_orientation([camera_yaw   + _array[0],
									 camera_pitch + _array[1],
									 camera_roll  + _array[2]]);
}
///@param move_xyz
function change_position(argument0) {
		var _delta = argument0;
		set_position([camera_position[vX]+_delta[vX],
									camera_position[vY]+_delta[vY],
									camera_position[vZ]+_delta[vZ]]);
}
///@param move_xyz
function change_target_position(argument0) {
		var _delta = argument0;
		set_target_position([camera_target[vX]+_delta[vX],
												 camera_target[vY]+_delta[vY],
												 camera_target[vZ]+_delta[vZ]]);
}
///@param x
///@param y
///@param xscale
///@param yscale
///@param rot
///@param col
///@param alpha
function draw_surface(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	if(camera_surface != undefined && surface_exists(camera_surface))
		draw_surface_ext(camera_surface,argument0,argument1,argument2,argument3,argument4,argument5,argument6);
}

///Returns a vector that is "forward" relative to the camera's angle
function get_direction() {
	return camera_direction;
}
///Returns a vector that is "right" relative to the camera's angle
function get_direction_right() {
	return camera_direction_right;
}
///Returns a vector that is "up" relative to the camera's angle
function get_direction_up() {
	return camera_direction_up;
}
/// @param [x,y,z]
function get_distance_to_point(argument0) {
	var _pos = argument0,
	    _x = _pos[vX],
			_y = _pos[vY],
			_z = _pos[vZ],
			_cx = camera_position[vX],
			_cy = camera_position[vY],
			_cz = camera_position[vZ];
		
	return point_distance_3d(_x,_y,_z,_cx,_cy,_cz);
}
///@description Gets the field of view angle 
function get_fov() {
	return fov;
}
///Returns the current 3D camera horizontal resolution
function get_height() {
	return camera_height == undefined ? camera_get_view_height(view_camera[0]) : camera_height;
}
function get_mode() {
	return camera_mode;
}
///Returns array [yaw,pitch,roll]
function get_orientation() {
	return [camera_yaw, camera_pitch, camera_roll];
}
function get_pitch() {
	return camera_pitch;
}
///@description returns the current position of the camera as an array.
function get_position() {
	return camera_position;
}
function get_roll() {
	return camera_roll;
}
function get_rotation_mode() {
	return camera_rotation_mode;
}
function get_target_position() {
	return camera_target;
}
///Returns the current 3D camera horizontal resolution
function get_width() {
  return camera_width == undefined ? camera_get_view_width(view_camera[0]) : camera_width;
}
function get_yaw() {
	return camera_yaw;
}
///@description Gets the field of view angle 

///@param instance_id
function register_instance() {
	var _id = argument0;
	_id.visible = false;
	  ds_list_add(instance_register, _id);
}
///@param instance_id
///@param [instance]
function register_skybox() {
	var _id = argument0;
	_id.visible = false;
	skybox_id = _id;
}
///@param distance
function set_distance_from_target(argument0) {
	if(camera_mode != EZ3DCam.mode_third_person || camera_distance == argument0) exit;
	camera_distance = argument0;
	camera_has_moved = true;
}
///@description Sets the field of view angle 
///@param fov_angle (default 45)
function set_fov(argument0) {
	if(fov == argument0) exit;
	
	fov = clamp(argument0,1,179);
	camera_has_moved=true;
}
///@param EZ3DCam.mode_ default: EZ3DCam.mode_first_person
function set_mode(argument0) {
	if(argument0 == camera_mode) exit;
	camera_mode = argument0;
	camera_has_moved = true;
}
///@param array_yaw_pitch_roll
function set_orientation(argument0) {
	var _array = argument0;
	if(camera_yaw != _array[0])
	{
		camera_has_moved=true;
		camera_yaw = _array[0];
	}
	if(camera_pitch != _array[1])
	{
		camera_has_moved=true;
		camera_pitch = _array[1];
	}
	if(camera_roll != _array[2])
	{
		camera_has_moved=true;
		camera_roll = _array[2];
	}
}
///@param pos_xyz
function set_position(argument0) {
	if(array_equals(camera_position, argument0)) exit;
	camera_has_moved = true;
	camera_position = argument0;
	camera_distance = get_distance_to_point(camera_target);
}
///@param width (same as view: -1)
///@param height (same as view: -1)
///@param surface_bg_color (default: c_black)
///@param surface_bg_alpha (default: 0);
///@param automatic_drawing_enabled (default: true)
function set_render_target(argument0, argument1, argument2, argument3, argument4) {
	camera_width = argument0 == -1 ? undefined : argument0;
	camera_height = argument1 == -1 ? undefined : argument1;
	camera_surface_bg_color = argument2;
	camera_surface_bg_alpha = argument3;
	camera_draw_surface = argument4;
}
///@param mode default: EZ3DCam.rotation_local
function set_rotation_mode(argument0) {
	camera_rotation_mode = argument0;


}
///@param width
///@param height
function set_size(argument0, argument1) {
	if(camera_width == argument0 && camera_height == argument1) exit;
	camera_width = argument0;
	camera_height = argument1;
	surface_free(camera_surface);
}
///@param xyz_pos
function set_target_position(argument0) {
	if(array_equals(camera_target, argument0)) exit;
	camera_has_moved = true;
	camera_target = argument0;
	if(camera_mode == EZ3DCam.mode_track_target)
		camera_distance = get_distance_to_point(camera_target);
}
///@description Sets the view distance
///@param distance default: 10000
function set_zfar(argument0) {
	if(zfar == argument0) exit;
	
	zfar = max(argument0,1);
	camera_has_moved=true;
}
function get_zfar() {
	return zfar;
}
///@param instance_id
///@param [instance]
function unregister_instance() {
	var _id = argument0;
	
	if(!ds_exists(ds_type_list,instance_register)) exit;
	var _index = ds_list_find_index(instance_register,_id);
	if(_index != -1)
	  ds_list_delete(instance_register, _index);	
}
///@param distance_delta
function rebuildCameraMatrix(){
	/// @description Rebuild Camera Matrix
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