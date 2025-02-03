function use_ez3d_cam(_mode = EZ3DCam.mode_first_person) {
  var _cam = {    
    cleanup: function(){
      if(__iSurface != undefined && surface_exists(__iSurface))
      	surface_free(__iSurface);     
    },
    
    draw: function(){
      var _cam = view_camera[0];
      var _vw = camera_get_view_width(_cam);
      var _ortho_view_mat = camera_get_view_mat(_cam);
      var _ortho_proj_mat = camera_get_proj_mat(_cam);
      var _surf_width = getWidth();
      var _surf_height = getHeight();
      var _scale = _vw/_surf_width;

      __iRebuildCameraMatrix();
      draw_set_color(c_white);

      if(!surface_exists(__iSurface))
      	__iSurface = surface_create(_surf_width,_surf_height);
      surface_set_target(__iSurface);
      draw_clear_alpha(__iSurfaceBgColor,__iSurfaceBgAlpha);


      #region 3D Projection Setup
      camera_set_view_mat(_cam, __iViewMatrix);
      camera_set_proj_mat(_cam, __iProgMatrix);
      camera_apply(_cam);
      #endregion

      #region Draw 3D Objects

      draw_set_lighting(false);
      draw_light_define_point(0,__iPosition[V_X],__iPosition[V_Y],__iPosition[V_Z],1500,c_white);
      draw_light_enable(0,true);

      //Draw Skybox
      with(__iSkyboxId) {
       event_perform(ev_draw,0); 
      }


      gpu_set_ztestenable(true);
      gpu_set_alphatestenable(true);
      gpu_set_alphatestref(10);
      gpu_set_zwriteenable(true);

      for(var _i=0; _i< array_length(__iInstanceRegistry); _i++) {
       with(__iInstanceRegistry[ _i]) {
        if(id == other.__iSkyboxId) continue;
       	event_perform(ev_draw,0);
       }
      }
      gpu_set_fog(false,0,0,0);
      #endregion

      surface_reset_target();

      #region//Reset back to Ortho
      gpu_set_ztestenable(false);
      gpu_set_zwriteenable(false);
      gpu_set_alphatestenable(false);
      matrix_set(matrix_world,matrix_build_identity()); 

      //_ortho_proj_mat[5] = abs(_ortho_proj_mat[5]); //Why? Because GM is kinda dumb.
      camera_set_view_mat(_cam, _ortho_view_mat);
      camera_set_proj_mat(_cam, _ortho_proj_mat);
      camera_set_view_size(_cam, __iPrevViewWidth, __iPrevViewHeight);
      camera_apply(_cam);

      #endregion

      //Finally, draw the 3D
      if(__iShouldDrawSurface)
       draw_surface_ext(__iSurface,camera_get_view_x(_cam),camera_get_view_y(_cam),_scale,_scale,0,c_white,1);
    },
    
    vertexFormat: undefined, //Public
    
    __iPrevViewWidth: 0,
    __iPrevViewHeight: 0,
    __iMode: EZ3DCam.mode_first_person,
    __iWidth: undefined,
    __iHeight: undefined,
    __iSurface: noone,
    __iShouldDrawSurface: true,
    __iSurfaceBgColor: c_black,
    __iSurfaceBgAlpha: 0,
    __iTarget: V_ZERO,
    __iPosition: V_ZERO,
    __iDirection: V_ZERO,
    __iDirectionLeft: V_ZERO,
    __iDirectionUp: V_ZERO,
    __iUp: matrix_build_translation([0, 0, 1]),
    __iDistance: 1,
    __iAngleMatrix: matrix_build_identity(),
    __IAngleQuat: quaternion_create(),
    __iRoll: 0,
    __iYaw: 0,
    __iPitch: 0,
    __iRotationMode: EZ3DCam.rotation_local,
    __iHasMoved: true,
    __iProgMatrix: [],
    __iViewMatrix: [],
    __iZFar: 10000,
    __iFov: 45,
        
    __iInstanceRegistry: [],
    __iSkyboxId: noone,
    
    changeDistanceFromTarget: function(_dif) {
      if (__iMode != EZ3DCam.mode_third_person || __iDistance == __iDistance + _dif) exit;
      __iDistance += _dif;
      __iHasMoved = true;
    },
    
    changeFov: function(_dif) {
      if (__iFov == __iFov + _dif) exit;
      __iFov = clamp(__iFov + _dif, 1, 179);
      __iHasMoved = true;
    },
    
    changeOrientation: function(_difArray) {
      setOrientation([__iYaw + _difArray[0],
        __iPitch + _difArray[1],
        __iRoll + _difArray[2]
      ]);
    },
    
    changePosition: function(_difArray) {
      setPosition([__iPosition[V_X] + _difArray[V_X],
        __iPosition[V_Y] + _difArray[V_Y],
        __iPosition[V_Z] + _difArray[V_Z]
      ]);
    },
    
    changeTargetPosition: function(_difArray) {
      setTargetPosition([__iTarget[V_X] + _difArray[V_X],
        __iTarget[V_Y] + _difArray[V_Y],
        __iTarget[V_Z] + _difArray[V_Z]
      ]);
    },
    
    drawSurface: function(_x, _y, _xScale = 1, _yScale = 1, _angle = 0, _col = c_white, _alpha = 1) {
      if (__iSurface == undefined || !surface_exists(__iSurface)) return;
      draw_surface_ext(__iSurface, _x, _y, _xScale, _yScale, _angle, _col, _alpha);
    },
    
    getDirection: function() {
      return __iDirection;
    },
    
    getDirectionLeft: function() {
      return __iDirectionLeft;
    },
    
    getDirectionUp: function() {
      return __iDirectionUp;
    },
    
    getDistanceToPoint: function(_posArray) {
      var _pos = _posArray,
        _x = _pos[V_X],
        _y = _pos[V_Y],
        _z = _pos[V_Z],
        _cx = __iPosition[V_X],
        _cy = __iPosition[V_Y],
        _cz = __iPosition[V_Z];
      return point_distance_3d(_x, _y, _z, _cx, _cy, _cz);
    },
    
    getFov: function() {
      return __iFov;
    },
    
    getHeight: function() {
      return __iHeight == undefined ? camera_get_view_height(view_camera[0]) : __iHeight;
    },
    
    getMode: function() {
      return __iMode;
    },
    
    getOrientation: function() {
      return [__iYaw, __iPitch, __iRoll];
    },
    
    getPitch: function() {
      return __iPitch;
    },
    
    getPosition: function() {
      return __iPosition;
    },
    
    getRoll: function() {
      return __iRoll;
    },
    
    getRotationMode: function() {
      return __iRotationMode;
    },
    
    getTargetPosition: function() {
      return __iTarget;
    },
    
    getWidth: function() {
      return __iWidth == undefined ? camera_get_view_width(view_camera[0]) : __iWidth;
    },
    
    getYaw: function() {
      return __iYaw;
    },
    
    registerInstance: function(_id) {
      _id.visible = false;
      array_push(__iInstanceRegistry, _id);
    },
    
    registerSkybox: function(_id) {
      _id.visible = false;
      __iSkyboxId = _id;
    },
    
    setDistanceFromTarget: function(_dist) {
      if (__iMode != EZ3DCam.mode_third_person || __iDistance == _dist) exit;
      __iDistance = _dist;
      __iHasMoved = true;
    },
    
    setFov: function(_fov) {
      if (__iFov == _fov) exit;
      __iFov = clamp(_fov, 1, 179);
      __iHasMoved = true;
    },
    
    setMode: function(_mode) {
      if (_mode == __iMode) exit;
      __iMode = _mode;
      __iHasMoved = true;
    },
    
    setOrientation: function(_array) {
      if (__iYaw != _array[0]) {
        __iHasMoved = true;
        __iYaw = _array[0];
      }
      if (__iPitch != _array[1]) {
        __iHasMoved = true;
        __iPitch = _array[1];
      }
      if (__iRoll != _array[2]) {
        __iHasMoved = true;
        __iRoll = _array[2];
      }
    },
    
    setPosition: function(_pos) {
      if (array_equals(__iPosition, _pos)) exit;
      __iHasMoved = true;
      __iPosition = _pos;
      __iDistance = getDistanceToPoint(__iTarget);
    },
    
    setRenderTarget: function(_width = -1, _height = 1, _surfaceBgCol = c_black, _surfaceBgAlpha, _autoDrawEnabled = true) {
      __iWidth = _width == -1 ? undefined : _width;
      __iHeight = _height == -1 ? undefined : _height;
      __iSurfaceBgColor = _surfaceBgCol;
      __iSurfaceBgAlpha = _surfaceBgAlpha;
      __iShouldDrawSurface = _autoDrawEnabled;
    },
    
    setRotationMode: function(_mode = EZ3DCam.rotation_local) {
      __iRotationMode = _mode;
    },
    
    setSize: function(_width, _height) {
      if (__iWidth == _width && __iHeight == _height) exit;
      __iWidth = _width;
      __iHeight = _height;
      surface_free(__iSurface);
    },
    
    setTargetPosition: function(_posArray) {
      if (array_equals(__iTarget, _posArray)) exit;
      __iHasMoved = true;
      __iTarget = _posArray;
      if (__iMode == EZ3DCam.mode_track_target)
        __iDistance = getDistanceToPoint(__iTarget);
    },
    
    setZFar: function(_dist = 10000) {
      if (__iZFar == _dist) exit;
      __iZFar = max(_dist, 1);
      __iHasMoved = true;
    },
    
    getZFar: function() {
      return __iZFar;
    },
    
    deregisterInstance: function(_id) {
      var _len = array_length(__iInstanceRegistry);
      for(var _i = 0; _i < _len; _i++) {
        if(__iInstanceRegistry[_i] == _id) {
          array_delete(__iInstanceRegistry,_i,1);
          break;
        }
      }
    },
    
    __iRebuildCameraMatrix: function() {
      /// @description Rebuild Camera Matrix
      __iPrevViewWidth = camera_get_view_width(view_camera[0]);
      __iPrevViewHeight = camera_get_view_height(view_camera[0]);
      if (__iWidth != undefined && __iHeight != undefined)
        camera_set_view_size(view_camera[0], __iWidth, __iHeight);
        
      var _vw = camera_get_view_width(view_camera[0]);
      var _vh = camera_get_view_height(view_camera[0]);
      
      switch (__iMode) {
        case EZ3DCam.mode_first_person:
          if (!__iHasMoved) break;
          if (__iRotationMode == EZ3DCam.rotation_local) {
            __IAngleQuat = quaternion_create();
            __IAngleQuat = quaternion_rotate_worldz(__IAngleQuat, __iYaw);
            __IAngleQuat = quaternion_rotate_localz(__IAngleQuat, __iPitch);
            __IAngleQuat = quaternion_rotate_localx(__IAngleQuat, __iRoll);
          } else {
            var _pitch = quaternion_create(),
                _yaw = quaternion_create(),
                _roll = quaternion_create();
            _pitch = quaternion_rotate_localz(_pitch, __iPitch);
            _yaw = quaternion_rotate_localy(_yaw, __iYaw);
            _roll = quaternion_rotate_localx(_roll, __iRoll);
            __iPitch = 0;
            __iYaw = 0;
            __iRoll = 0;
            __IAngleQuat = quaternion_combine(__IAngleQuat, _pitch, _yaw, _roll);
          }
          __iAngleMatrix = quaternion_matrix(__IAngleQuat);
          __iDirection = matrix_to_vec3(matrix_combine(matrix_build_translation([1, 0, 0]), __iAngleMatrix));
          __iDirection = vec3_normalize(__iDirection);
          __iDirectionLeft = matrix_to_vec3(matrix_combine(matrix_build_translation([0, -1, 0]), __iAngleMatrix));
          __iDirectionUp = matrix_to_vec3(matrix_combine(matrix_build_translation([0, 0, 1]), __iAngleMatrix));
          __iTarget = vec3_add(__iDirection, __iPosition);
        break;
          
        case EZ3DCam.mode_third_person:
          if (__iRotationMode == EZ3DCam.rotation_local) {
            __IAngleQuat = quaternion_create();
            __IAngleQuat = quaternion_rotate_worldz(__IAngleQuat, __iYaw);
            __IAngleQuat = quaternion_rotate_localz(__IAngleQuat, __iPitch);
            __IAngleQuat = quaternion_rotate_localx(__IAngleQuat, __iRoll);
          } else {
            var _pitch = quaternion_create(),
                _yaw = quaternion_create(),
                _roll = quaternion_create();
            _pitch = quaternion_rotate_localz(_pitch, __iPitch);
            _yaw = quaternion_rotate_localy(_yaw, __iYaw);
            _roll = quaternion_rotate_localx(_roll, -__iRoll);
            __iPitch = 0;
            __iYaw = 0;
            __iRoll = 0;
            __IAngleQuat = quaternion_combine(__IAngleQuat, _pitch, _yaw, _roll);
          }
          __iAngleMatrix = quaternion_matrix(__IAngleQuat);
          var _matrix = matrix_combine(matrix_build_translation([__iDistance, 0, 0]), __iAngleMatrix, matrix_build_translation(__iTarget));
          __iPosition = [_matrix[M_X], _matrix[M_Y], _matrix[M_Z]];
          __iDirection = matrix_to_vec3(matrix_combine(matrix_build_translation([-1, 0, 0]), __iAngleMatrix));
          __iDirectionLeft = matrix_to_vec3(matrix_combine(matrix_build_translation([0, 1, 0]), __iAngleMatrix));
          __iDirectionUp = matrix_to_vec3(matrix_combine(matrix_build_translation([0, 0, 1]), __iAngleMatrix));
        break;
          
        case EZ3DCam.mode_track_target:
          //calculate camera properties
          var _tar = __iTarget;
          var _pos = __iPosition;
          __iDistance = point_distance_vec3(_tar, _pos)
          __iYaw = -point_direction(_pos[V_X], _pos[V_Y], _tar[V_X], _tar[V_Y]);
          var _ratio = (_pos[V_Z] - _tar[V_Z]) / __iDistance;
          __iPitch = radtodeg(arcsin(_ratio));
          var _angle = quaternion_create();
          _angle = quaternion_rotate_worldz(_angle, __iYaw);
          _angle = quaternion_rotate_localz(_angle, __iPitch);
            
          _angle = quaternion_rotate_localx(_angle, __iRoll);
          __IAngleQuat = _angle;
          __iAngleMatrix = quaternion_matrix(_angle);
          __iDirection = matrix_to_vec3(matrix_combine(matrix_build_translation([1, 0, 0]), __iAngleMatrix));
          __iDirectionLeft = matrix_to_vec3(matrix_combine(matrix_build_translation([0, -1, 0]), __iAngleMatrix));
          __iDirectionUp = matrix_to_vec3(matrix_combine(matrix_build_translation([0, 0, 1]), __iAngleMatrix));
        break;
      }
      
      var _up = matrix_combine(matrix_build_translation(__iUp), __iAngleMatrix),
          _aspect = _vw / _vh,
          _pos = __iPosition;
      
      __iViewMatrix = matrix_build_lookat(_pos[V_X], _pos[V_Y], _pos[V_Z],
        _pos[V_X] + __iDirection[V_X], _pos[V_Y] + __iDirection[V_Y], _pos[V_Z] + __iDirection[V_Z],
        _up[M_X], _up[M_Y], _up[M_Z]);
      __iProgMatrix = matrix_build_projection_perspective_fov(__iFov, _aspect, 1, __iZFar);
    },

  }
  
  //Standard vertex format. Feel free to replace with your own if necessary
  vertex_format_begin()
  vertex_format_add_position_3d();
  vertex_format_add_normal();
  vertex_format_add_colour();
  vertex_format_add_texcoord();
  _cam.vertexFormat = vertex_format_end();
  
  if(_mode != EZ3DCam.mode_first_person)
    _cam.setMode(_mode);
  
  return _cam;  
}

#region Matrix Extension Functions

///@func matrix_build_translation([x,y,z])
function matrix_build_translation(_posXYZ) {
	if(array_length(_posXYZ) == 3)
		return matrix_build(_posXYZ[V_X],_posXYZ[V_Y],_posXYZ[V_Z],0,0,0,1,1,1);

	return matrix_build(_posXYZ[M_X],_posXYZ[M_Y],_posXYZ[M_Z],0,0,0,1,1,1);
}

///@func matrix_build_rotation(rotation[x,y,z])
function matrix_build_rotation(_rotationXYZ) {
	if(array_length(_rotationXYZ) == 3)
		return matrix_build(0,0,0,_rotationXYZ[V_X],_rotationXYZ[V_Y],_rotationXYZ[V_Z],1,1,1);

	return matrix_build(0,0,0,_rotationXYZ[M_X],_rotationXYZ[M_Y],_rotationXYZ[M_Z],1,1,1);
}

///@func matrix_build_scale(scale[x,y,z])
function matrix_build_scale(_scaleXYZ) {
	if(array_length(_scaleXYZ) == 3)
		return matrix_build(0,0,0,0,0,0,_scaleXYZ[V_X],_scaleXYZ[V_Y],_scaleXYZ[V_Z]);

	return matrix_build(0,0,0,0,0,0,_scaleXYZ[M_X],_scaleXYZ[M_Y],_scaleXYZ[M_Z]);
}

///@func matrix_build_srt(scale[x,y,z], rotation[x,y,z], translation[x,y,z])
function matrix_build_srt(_scaleXYZ, _rotationXYZ, _translationXYZ) {
	return matrix_combine(matrix_build_scale(_scaleXYZ),
												matrix_build_rotation(_rotationXYZ),
												matrix_build_translation(_translationXYZ));
}

///@func matrix_combine(matrix1, matrix2, matrix3...)
function matrix_combine() {
	var _m = matrix_multiply(argument[0],argument[1])
	for(var _i=2; _i<argument_count; _i++) {
		_m = matrix_multiply(_m,argument[_i]);
	}
	return _m;
}

///@func matrix_to_vec3(matrix);
/// returns a vec3 built from the x,y, and z component of the matrix
function matrix_to_vec3(_mat) {
	return [_mat[M_X],_mat[M_Y],_mat[M_Z]];
}
#endregion

#region Vector 3 Extension Functions

///@func point_distance_vec3(A[x,y,z], B[x,y,z])
function point_distance_vec3(_a, _b) {
	return point_distance_3d(_a[V_X],_a[V_Y],_a[V_Z],_b[V_X],_b[V_Y],_b[V_Z]);
}

///@func vec3_add(vec3, vec3, vec3...)
///returns a new vector with the given vectors added together
function vec3_add() {
	var _new = [0,0,0];
	for(var _i= 0; _i<argument_count; _i++)
	{
		var _vec = argument[_i];
		_new[0]+=_vec[0];
		_new[1]+=_vec[1];
		_new[2]+=_vec[2];
	}
	return _new;
}

///@func vec3_length([x,y,z])
///@description returns the length of the given 3D vector
function vec3_length(_v1) {
	var _tot = 0;
	_tot+=_v1[0]*_v1[0];
	_tot+=_v1[1]*_v1[1];
	_tot+=_v1[2]*_v1[2];
	if(_tot != 0)
		_tot = sqrt(_tot);
	
	return _tot;
}

///@func vec3_normalize([x,y,z])
///@description Returns a 3D vector with a length of 1
function vec3_normalize(_v1) {
	var _v;

	var _tot = 0;
	_v[2] = 0;
	_tot+=_v1[0]*_v1[0];
	_tot+=_v1[1]*_v1[1];
	_tot+=_v1[2]*_v1[2];

	if(_tot != 0)
	{
		_tot = sqrt(_tot);
		_v[0] = _v1[0]/_tot;
		_v[1] = _v1[1]/_tot;
		_v[2] = _v1[2]/_tot;
	}

	return _v;
}

///@fucn vec3_scale([x,y,z], scaler)
/// scales the given vec3 array by the given value
function vec3_scale(_vec, _scale) {
	_vec[0]*=_scale;
	_vec[1]*=_scale;
	_vec[2]*=_scale;
	return _vec;
}
#endregion

#region Quaternian Library by Juju Adams!

/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_create() {
	return [1.0, 0.0, 0.0, 0.0000001];
}
///@param quat1
///@param quat2
///@param <quat3>
///@param <quat...>
function quaternion_combine() {
	var _q = quaternion_multiply(argument[0],argument[1])
	for(var _i=2; _i<argument_count; _i++)
	{
		_q = quaternion_multiply(_q,argument[_i]);
	}
	return _q;
}
/// @desc Makes a 4x4 column-major transform matrix from a quaternion.
/// @param quaternion
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_matrix(argument0) {

	var _quaternion = argument0;

	var _r = _quaternion[0];
	var _x = _quaternion[1];
	var _y = _quaternion[2];
	var _z = _quaternion[3];

	var _length = sqrt(_x*_x + _y*_y + _z*_z);
	var _hyp_sqr = _length*_length + _r*_r;

	//Calculate trig coefficients
	var _c  = 2*_r*_r / _hyp_sqr - 1;
	var _s  = 2*_length*_r*_hyp_sqr;
	var _omc = 1 - _c;

	//Normalise the input vector
	_x /= _length;
	_y /= _length;
	_z /= _length;

	//Build matrix
	return [_omc*_x*_x + _c  , _omc*_x*_y + _s*_z, _omc*_x*_z - _s*_y, 0,
	    _omc*_x*_y - _s*_z, _omc*_y*_y + _c  , _omc*_y*_z + _s*_x, 0,
	    _omc*_x*_z + _s*_y, _omc*_y*_z - _s*_x, _omc*_z*_z + _c  , 0,
	             0,         0,          0, 1];
}
/// @desc Multiplies two quaternions together, adding one rotation onto another.
/// @param quat1
/// @param quat2
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_multiply(argument0, argument1) {
	var _q1 = argument0;
	var _q2 = argument1;

	var _x1 = _q1[0], _y1 = _q1[1], _z1 = _q1[2], _w1 = _q1[3];
	var _x2 = _q2[0], _y2 = _q2[1], _z2 = _q2[2], _w2 = _q2[3];

	return [_x1*_x2 - _y1*_y2 - _z1*_z2 - _w1*_w2,
	    _x1*_y2 + _y1*_x2 + _z1*_w2 - _w1*_z2,
	    _x1*_z2 + _z1*_x2 + _w1*_y2 - _y1*_w2,
	    _x1*_w2 + _w1*_x2 + _y1*_z2 - _z1*_y2];
}
/// @desc Rotates around the model's local x-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_localx(argument0, argument1) {
	return quaternion_multiply([argument0[0], argument0[1], argument0[2], argument0[3]],
	              [dcos(argument1/2), dsin(argument1/2), 0, 0]);
}
/// @desc Rotates around the model's local y-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_localy(argument0, argument1) {

	return quaternion_multiply([argument0[0], argument0[1], argument0[2], argument0[3]],
	              [dcos(argument1/2), 0, 0, dsin(argument1/2)]);
}
/// @desc Rotates around the model's local z-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_localz(argument0, argument1) {
	return quaternion_multiply([argument0[0], argument0[1], argument0[2], argument0[3]],
	              [dcos(argument1/2), 0, dsin(argument1/2), 0]);
}
/// @desc Rotates a 3D vector (3-element 1D array) by a quaternion.
/// @param vector
/// @param quaternion
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_vector(argument0, argument1) {
	var _vector   = argument0;
	var _quaternion = argument1;
	_vector = quaternion_multiply([_quaternion[0], _quaternion[1], _quaternion[2], _quaternion[3]],
	                      [0,   _vector[0],   _vector[1],   _vector[2]]);
	_vector = quaternion_multiply([_quaternion[0], _quaternion[1], _quaternion[2], _quaternion[3]],
	                      [0,  -_vector[1],  -_vector[2],  -_vector[3]]);
	return [_vector[1], _vector[2], _vector[3]];
}
/// @desc Rotates around the world's x-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_worldx(argument0, argument1) {
	return quaternion_multiply([dcos(argument1/2), dsin(argument1/2), 0, 0],
	              [argument0[0], argument0[1], argument0[2], argument0[3]]);
}
/// @desc Rotates around the world's y-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_worldy(argument0, argument1) {
	return quaternion_multiply([dcos(argument1/2), 0, dsin(argument1/2), 0],
	              [argument0[0], argument0[1], argument0[2], argument0[3]]);
}
/// @desc Rotates around the world's z-axis.
/// @param quaternion
/// @param angle
///
/// Quaternion library
/// 5th May 2019
/// @jujuadams
function quaternion_rotate_worldz(argument0, argument1) {
	return quaternion_multiply([dcos(argument1/2), 0, 0, dsin(argument1/2)],
	              [argument0[0], argument0[1], argument0[2], argument0[3]]);
}
#endregion

///Enum
enum EZ3DCam {
  //Camera
  mode_first_person,
  mode_third_person,
  mode_track_target,
  rotation_local,
  rotation_world,
}

//Vectors
#macro V_X 0
#macro V_Y 1
#macro V_Z 2
#macro V_U 2
#macro V_V 3

//Common Vector Shortcuts
#macro V_ZERO [0, 0, 0]
#macro V_ONE [1, 1, 1]

//Matrices
#macro M_X 12
#macro M_Y 13
#macro M_Z 14