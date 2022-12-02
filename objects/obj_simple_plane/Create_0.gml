/// @description Insert description here
// You can write your code in this editor
event_inherited();
rotation = [0,0,-90] // -90 to face the camera which.
scale = [.25,.25,.25];
fog_color = c_black;
//The most difficult part of working with 3D is building your
//3D "models". This is an example of a simple textured plane
//made up of two triangles. 

var _w = sprite_get_width(sprite_index)/2,
  _h = sprite_get_height(sprite_index)/2,
  _uvs = sprite_get_uvs(choose(spr_ace,spr_king,spr_queen,spr_jack),0),
  _buff = vertex_create_buffer(),
  _l=0,_t=1,_r=2,_b=3;

vertex_begin(_buff,objEz3dCam.ezCam.vertexFormat);
#region FRONT  
  
//Top Left Tri
vertex_position_3d(_buff,-_w,0,-_h);
vertex_normal(_buff,0,1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_t]);
		
vertex_position_3d(_buff,_w,0,-_h);
vertex_normal(_buff,0,1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);

vertex_position_3d(_buff,-_w,0,_h);
vertex_normal(_buff,0,1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);

//Bottom Right Tri	
vertex_position_3d(_buff,_w,0,_h);
vertex_normal(_buff,0,1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_b]);
		
vertex_position_3d(_buff,-_w,0,_h);
vertex_normal(_buff,0,1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);

vertex_position_3d(_buff,_w,0,-_h);
vertex_normal(_buff,0,1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);
#endregion
#region BACK
_uvs = sprite_get_uvs(spr_card_back,0);

//Top Left Tri
vertex_position_3d(_buff,-_w,0,-_h);
vertex_normal(_buff,0,-1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_t]);
		
vertex_position_3d(_buff,-_w,0,_h);
vertex_normal(_buff,0,-1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_b]);

vertex_position_3d(_buff,_w,0,-_h);
vertex_normal(_buff,0,-1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_t]);

//Bottom Right Tri	
vertex_position_3d(_buff,_w,0,_h);
vertex_normal(_buff,0,-1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_b]);
		
vertex_position_3d(_buff,_w,0,-_h);
vertex_normal(_buff,0,-1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_l], _uvs[_t]);

vertex_position_3d(_buff,-_w,0,_h);
vertex_normal(_buff,0,-1,0);
vertex_colour(_buff, c_white, 1);
vertex_texcoord(_buff, _uvs[_r], _uvs[_b]);
#endregion
vertex_end(_buff);
vertex = _buff;

