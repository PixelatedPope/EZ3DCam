//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying float v_vDistance;

uniform vec3 u_vCamPos;
uniform vec4 u_vColour;
uniform vec4 u_vFog; //enabled, start, end
uniform vec4 u_vFogColour; 
uniform vec4 u_vUv;
uniform vec2 u_vTexRepeat;
uniform int u_iIsBlendAdd;

#define fog_enabled u_vFog[0]
#define fog_start u_vFog[1]
#define fog_end u_vFog[2]

void main()
{
	//Normalize tiled texture UVs
	vec2 texcoord=(v_vTexcoord-u_vUv.xy)/(u_vUv.zw-u_vUv.xy);
  texcoord=mod(texcoord*u_vTexRepeat,1.);
  texcoord=u_vUv.xy+texcoord*(u_vUv.zw-u_vUv.xy);
	
	vec4 base = u_vColour * texture2D( gm_BaseTexture, texcoord );
	float curAlpha = texture2D( gm_BaseTexture, texcoord ).a;
	if(curAlpha <= 0.0) discard;
	
	if(fog_enabled == 1.)
	{
		float dist = v_vDistance;
		
		if(dist > fog_start)
		{
			float range = fog_end-fog_start;
			float amount = (dist-fog_start)/range;
			
			if(u_iIsBlendAdd == 1)
				gl_FragColor = mix(base,vec4(0.,0.,0.,1.),amount); 
			else
			{
				gl_FragColor = mix(base,u_vFogColour,amount)*curAlpha; 
			}
		}
		else
			gl_FragColor = base;
	}
	else
		gl_FragColor = base;
}
