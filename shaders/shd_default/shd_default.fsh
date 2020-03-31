//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
		if(texture2D( gm_BaseTexture, v_vTexcoord ).a < 0.01) 
			discard;
		
		gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
