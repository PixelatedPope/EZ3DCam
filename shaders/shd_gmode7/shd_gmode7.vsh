attribute vec3 in_Position;                  // (x,y,z)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec4 in_Colour;                    // (r,g,b,a)

varying vec2 v_vTexcoord;
varying float v_vDistance;

void main()
{
    vec4 object_space_pos = vec4( in_Position.xyz, 1.0);
		vec4 cs_position = gm_Matrices[MATRIX_WORLD_VIEW] * object_space_pos;
    v_vDistance = abs(cs_position.z);
		gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
		v_vTexcoord = in_TextureCoord;
}