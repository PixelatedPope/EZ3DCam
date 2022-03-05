///Enum
enum EZ3DCam {
  //Camera
  mode_first_person,
  mode_third_person,
  mode_track_target,
  rotation_local,
  rotation_world,
}

function use_ez3d_cam() {
  cam = {
    
    cleanup: function(){
      if(cameraSurface != undefined && surface_exists(cameraSurface))
      	surface_free(cameraSurface);
 
      ds_list_destroy(instanceRegister);
    },
    
    draw: function(){
      var _cam = view_camera[0];
      var _vw = camera_get_view_width(_cam);
      var _vh = camera_get_view_height(_cam);
      var _ortho_view_mat = camera_get_view_mat(_cam);
      var _ortho_proj_mat = camera_get_proj_mat(_cam);
      var _surf_width = getWidth();
      var _surf_height = getHeight();
      var _scale = _vw/_surf_width;

      rebuildCameraMatrix();
      draw_set_color(c_white);

      if(!surface_exists(cameraSurface))
      	cameraSurface = surface_create(_surf_width,_surf_height);
      surface_set_target(cameraSurface);
      draw_clear_alpha(cameraSurfaceBgColor,cameraSurfaceBgAlpha);


      #region 3D Projection Setup
      camera_set_view_mat(_cam, viewMatrix);
      camera_set_proj_mat(_cam, progMatrix);
      camera_apply(_cam);
      #endregion

      #region Draw 3D Objects

      //draw_light_define_ambient(c_black);
      draw_set_lighting(true);
      draw_light_define_point(0,cameraPosition[vX],cameraPosition[vY],cameraPosition[vZ],1500,c_white);
      draw_light_enable(0,true);

      //Draw Skybox
      with(skyboxId)
      {
       event_perform(ev_draw,0); 
      }


      gpu_set_ztestenable(true);
      gpu_set_alphatestenable(true);
      gpu_set_alphatestref(10);
      gpu_set_zwriteenable(true);

      for(var _i=0; _i< ds_list_size(instanceRegister); _i++)
      {
       with(instanceRegister[| _i])
       {
        if(id == other.skyboxId) continue;
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

      _ortho_proj_mat[5] = abs(_ortho_proj_mat[5]); //Why? Because GM is kinda dumb.
      camera_set_view_mat(_cam, _ortho_view_mat);
      camera_set_proj_mat(_cam, _ortho_proj_mat);
      camera_set_view_size(_cam, prevViewWidth, prevViewHeight);
      camera_apply(_cam);

      #endregion

      //Finally, draw the 3D
      if(cameraShouldDrawSurface)
       draw_surface_ext(cameraSurface,camera_get_view_x(_cam),camera_get_view_y(_cam),_scale,_scale,0,c_white,1);

      timer++;
    },
    
    prevViewWidth: 0,
    prevViewHeight: 0,
    cameraMode: EZ3DCam.mode_first_person,
    cameraWidth: undefined,
    cameraHeight: undefined,
    cameraSurface: noone,
    cameraShouldDrawSurface: true,
    cameraSurfaceBgColor: c_black,
    cameraSurfaceBgAlpha: 0,
    cameraTarget: vZERO,
    cameraPosition: vZERO,
    cameraDirection: vZERO,
    cameraDirectionRight: vZERO,
    cameraDirectionUp: vZERO,
    cameraUp: matrix_build_translation([0, 0, 1]),
    cameraDistance: 1,
    cameraAngleMatrix: matrix_build_identity(),
    cameraAngleQuat: quaternion_create(),
    cameraRoll: 0,
    cameraYaw: 0,
    cameraPitch: 0,
    cameraRotationMode: EZ3DCam.rotation_local,
    cameraHasMoved: true,
    progMatrix: [],
    viewMatrix: [],
    zFar: 10000,
    fov: 45,
    
    instanceRegister: ds_list_create(),
    skyboxId: noone,
    changeDistanceFromTarget: function(_dif) {
      if (cameraMode != EZ3DCam.mode_third_person || cameraDistance == cameraDistance + _dif) exit;
      cameraDistance += _dif;
      cameraHasMoved = true;
    },
    
    changeFov: function(_dif) {
      if (fov == fov + _dif) exit;
      fov = clamp(fov + _dif, 1, 179);
      cameraHasMoved = true;
    },
    
    changeOrientation: function(_difArray) {
      setOrientation([cameraYaw + _difArray[0],
        cameraPitch + _difArray[1],
        cameraRoll + _difArray[2]
      ]);
    },
    
    changePosition: function(_difArray) {
      set_position([cameraPosition[vX] + _difArray[vX],
        cameraPosition[vY] + _difArray[vY],
        cameraPosition[vZ] + _difArray[vZ]
      ]);
    },
    
    changeTargetPosition: function(_difArray) {
      setTargetPosition([cameraTarget[vX] + _difArray[vX],
        cameraTarget[vY] + _difArray[vY],
        cameraTarget[vZ] + _difArray[vZ]
      ]);
    },
    
    drawSurface: function(_x, _y, _xScale = 1, _yScale = 1, _angle = 0, _col = c_white, _alpha = 1) {
      if (cameraSurface == undefined || !surface_exists(cameraSurface)) return;
      draw_surface_ext(cameraSurface, _x, _y, _xScale, _yScale, _angle, _col, _alpha);
    },
    
    getDirection: function() {
      return cameraDirection;
    },
    
    getDirectionRight: function() {
      return cameraDirectionRight;
    },
    
    getDirectionUp: function() {
      return cameraDirectionUp;
    },
    
    getDistanceToPoint: function(_posArray) {
      var _pos = _posArray,
        _x = _pos[vX],
        _y = _pos[vY],
        _z = _pos[vZ],
        _cx = cameraPosition[vX],
        _cy = cameraPosition[vY],
        _cz = cameraPosition[vZ];
      return point_distance_3d(_x, _y, _z, _cx, _cy, _cz);
    },
    
    getFov: function() {
      return fov;
    },
    
    getHeight: function() {
      return cameraHeight == undefined ? camera_get_view_height(view_camera[0]) : cameraHeight;
    },
    
    getMode: function() {
      return cameraMode;
    },
    
    getOrientation: function() {
      return [cameraYaw, cameraPitch, cameraRoll];
    },
    
    getPitch: function() {
      return cameraPitch;
    },
    
    getPosition: function() {
      return cameraPosition;
    },
    
    getRoll: function() {
      return cameraRoll;
    },
    
    getRotationMode: function() {
      return cameraRotationMode;
    },
    
    getTargetPosition: function() {
      return cameraTarget;
    },
    
    getWidth: function() {
      return cameraWidth == undefined ? camera_get_view_width(view_camera[0]) : cameraWidth;
    },
    
    getYaw: function() {
      return cameraYaw;
    },
    
    registerInstance: function(_id) {
      _id.visible = false;
      ds_list_add(instanceRegister, _id);
    },
    
    registerSkybox: function(_id) {
      _id.visible = false;
      skyboxId = _id;
    },
    
    setDistanceFromTarget: function(_dist) {
      if (cameraMode != EZ3DCam.mode_third_person || cameraDistance == _dist) exit;
      cameraDistance = _dist;
      cameraHasMoved = true;
    },
    
    setFov: function(_fov) {
      if (fov == _fov) exit;
      fov = clamp(_fov, 1, 179);
      cameraHasMoved = true;
    },
    
    setMode: function(_mode) {
      if (_mode == cameraMode) exit;
      cameraMode = _mode;
      cameraHasMoved = true;
    },
    
    setOrientation: function(_array) {
      if (cameraYaw != _array[0]) {
        cameraHasMoved = true;
        cameraYaw = _array[0];
      }
      if (cameraPitch != _array[1]) {
        cameraHasMoved = true;
        cameraPitch = _array[1];
      }
      if (cameraRoll != _array[2]) {
        cameraHasMoved = true;
        cameraRoll = _array[2];
      }
    },
    
    set_position: function(_pos) {
      if (array_equals(cameraPosition, _pos)) exit;
      cameraHasMoved = true;
      cameraPosition = _pos;
      cameraDistance = getDistanceToPoint(cameraTarget);
    },
    
    setRenderTarget: function(_width = -1, _height = 1, _surfaceBgCol = c_black, _surfaceBgAlpha, _autoDrawEnabled = true) {
      cameraWidth = _width == -1 ? undefined : _width;
      cameraHeight = _height == -1 ? undefined : _height;
      cameraSurfaceBgColor = _surfaceBgCol;
      cameraSurfaceBgAlpha = _surfaceBgAlpha;
      cameraShouldDrawSurface = _autoDrawEnabled;
    },
    
    setRotationMode: function(_mode = EZ3DCam.rotation_local) {
      cameraRotationMode = _mode;
    },
    
    setSize: function(_width, _height) {
      if (cameraWidth == _width && cameraHeight == _height) exit;
      cameraWidth = _width;
      cameraHeight = _height;
      surface_free(cameraSurface);
    },
    
    setTargetPosition: function(_posArray) {
      if (array_equals(cameraTarget, _posArray)) exit;
      cameraHasMoved = true;
      cameraTarget = _posArray;
      if (cameraMode == EZ3DCam.mode_track_target)
        cameraDistance = getDistanceToPoint(cameraTarget);
    },
    
    setZFar: function(_dist = 10000) {
      if (zFar == _dist) exit;
      zFar = max(_dist, 1);
      cameraHasMoved = true;
    },
    
    getZFar: function() {
      return zFar;
    },
    
    deregisterInstance: function(_id) {
      if (!ds_exists(ds_type_list, instanceRegister)) exit;
      var _index = ds_list_find_index(instanceRegister, _id);
      if (_index != -1)
        ds_list_delete(instanceRegister, _index);
    },
    
    rebuildCameraMatrix: function() {
      /// @description Rebuild Camera Matrix
      prevViewWidth = camera_get_view_width(view_camera[0]);
      prevViewHeight = camera_get_view_height(view_camera[0]);
      if (cameraWidth != undefined && cameraHeight != undefined)
        camera_set_view_size(view_camera[0], cameraWidth, cameraHeight);
        
      var _vw = camera_get_view_width(view_camera[0]);
      var _vh = camera_get_view_height(view_camera[0]);
      
      switch (cameraMode) {
        case EZ3DCam.mode_first_person:
          if (!cameraHasMoved) break;
          if (cameraRotationMode == EZ3DCam.rotation_local) {
            cameraAngleQuat = quaternion_create();
            cameraAngleQuat = quaternion_rotate_worldz(cameraAngleQuat, cameraYaw);
            cameraAngleQuat = quaternion_rotate_localz(cameraAngleQuat, cameraPitch);
            cameraAngleQuat = quaternion_rotate_localx(cameraAngleQuat, cameraRoll);
          } else {
            var _pitch = quaternion_create(),
                _yaw = quaternion_create(),
                _roll = quaternion_create();
            _pitch = quaternion_rotate_localz(_pitch, cameraPitch);
            _yaw = quaternion_rotate_localy(_yaw, cameraYaw);
            _roll = quaternion_rotate_localx(_roll, cameraRoll);
            cameraPitch = 0;
            cameraYaw = 0;
            cameraRoll = 0;
            cameraAngleQuat = quaternion_combine(cameraAngleQuat, _pitch, _yaw, _roll);
          }
          cameraAngleMatrix = quaternion_matrix(cameraAngleQuat);
          cameraDirection = matrix_to_vec3(matrix_combine(matrix_build_translation([1, 0, 0]), cameraAngleMatrix));
          cameraDirection = vec3_normalize(cameraDirection);
          cameraDirectionRight = matrix_to_vec3(matrix_combine(matrix_build_translation([0, -1, 0]), cameraAngleMatrix));
          cameraDirectionUp = matrix_to_vec3(matrix_combine(matrix_build_translation([0, 0, 1]), cameraAngleMatrix));
          cameraTarget = vec3_add(cameraDirection, cameraPosition);
        break;
          
        case EZ3DCam.mode_third_person:
          if (cameraRotationMode == EZ3DCam.rotation_local) {
            cameraAngleQuat = quaternion_create();
            cameraAngleQuat = quaternion_rotate_worldz(cameraAngleQuat, cameraYaw);
            cameraAngleQuat = quaternion_rotate_localz(cameraAngleQuat, cameraPitch);
            cameraAngleQuat = quaternion_rotate_localx(cameraAngleQuat, cameraRoll);
          } else {
            var _pitch = quaternion_create(),
                _yaw = quaternion_create(),
                _roll = quaternion_create();
            _pitch = quaternion_rotate_localz(_pitch, cameraPitch);
            _yaw = quaternion_rotate_localy(_yaw, cameraYaw);
            _roll = quaternion_rotate_localx(_roll, -cameraRoll);
            cameraPitch = 0;
            cameraYaw = 0;
            cameraRoll = 0;
            cameraAngleQuat = quaternion_combine(cameraAngleQuat, _pitch, _yaw, _roll);
          }
          cameraAngleMatrix = quaternion_matrix(cameraAngleQuat);
          var _matrix = matrix_combine(matrix_build_translation([cameraDistance, 0, 0]), cameraAngleMatrix, matrix_build_translation(cameraTarget));
          cameraPosition = [_matrix[mX], _matrix[mY], _matrix[mZ]];
          cameraDirection = matrix_to_vec3(matrix_combine(matrix_build_translation([-1, 0, 0]), cameraAngleMatrix));
          cameraDirectionRight = matrix_to_vec3(matrix_combine(matrix_build_translation([0, 1, 0]), cameraAngleMatrix));
          cameraDirectionUp = matrix_to_vec3(matrix_combine(matrix_build_translation([0, 0, 1]), cameraAngleMatrix));
        break;
          
        case EZ3DCam.mode_track_target:
          //calculate camera properties
          var _tar = cameraTarget;
          var _pos = cameraPosition;
          cameraDistance = point_distance_vec3(_tar, _pos)
          cameraYaw = -point_direction(_pos[vX], _pos[vY], _tar[vX], _tar[vY]);
          var _ratio = (_pos[vZ] - _tar[vZ]) / cameraDistance;
          cameraPitch = radtodeg(arcsin(_ratio));
          var _angle = quaternion_create();
          _angle = quaternion_rotate_worldz(_angle, cameraYaw);
          _angle = quaternion_rotate_localz(_angle, cameraPitch);
            
          _angle = quaternion_rotate_localx(_angle, cameraRoll);
          cameraAngleQuat = _angle;
          cameraAngleMatrix = quaternion_matrix(_angle);
          cameraDirection = matrix_to_vec3(matrix_combine(matrix_build_translation([1, 0, 0]), cameraAngleMatrix));
          cameraDirectionRight = matrix_to_vec3(matrix_combine(matrix_build_translation([0, -1, 0]), cameraAngleMatrix));
          cameraDirectionUp = matrix_to_vec3(matrix_combine(matrix_build_translation([0, 0, 1]), cameraAngleMatrix));
        break;
      }
      
      var _up = matrix_combine(matrix_build_translation(cameraUp), cameraAngleMatrix),
          _aspect = _vw / _vh,
          _pos = cameraPosition;
      
      viewMatrix = matrix_build_lookat(_pos[vX], _pos[vY], _pos[vZ],
        _pos[vX] + cameraDirection[vX], _pos[vY] + cameraDirection[vY], _pos[vZ] + cameraDirection[vZ],
        _up[mX], _up[mY], _up[mZ]);
      progMatrix = matrix_build_projection_perspective_fov(fov, _aspect, 1, zFar);
    },
    timer: 0
  }
  
  //Standard vertex format. Feel free to replace with your own if necessary
  vertex_format_begin()
  vertex_format_add_position_3d();
  vertex_format_add_normal();
  vertex_format_add_colour();
  vertex_format_add_texcoord();
  cam.vertexFormat = vertex_format_end();
  
  return cam;  
}


//Vectors
#macro vX 0
#macro vY 1
#macro vZ 2
#macro vU 2
#macro vV 3
//Common Vector Shortcuts
#macro vZERO [0, 0, 0]
#macro vONE [1, 1, 1]
//Matrices
#macro mX 12
#macro mY 13
#macro mZ 14