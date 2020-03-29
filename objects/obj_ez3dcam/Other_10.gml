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
