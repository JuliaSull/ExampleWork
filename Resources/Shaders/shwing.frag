//Fragment shader

#version 330 core
in vec2 TexCoord;
in vec3 WorldPos;

out vec4 gl_FragColor;

uniform vec4 tint;
uniform sampler2D Texture;

uniform vec2 texOffset;
uniform vec2 frameSize;

uniform bool mirrorX;

uniform bool paused;

uniform float time;

uniform vec3 player_world_position;

float maxdist = 250;

void main()
{
  float timescale = -0.4;
  float worldscale = 250;
  
	vec2 actualTex = TexCoord + texOffset;
  
	if(mirrorX)
	{
		actualTex.x = texOffset.x + frameSize.x - TexCoord.x;
	}
  
  float shwingness = cos(time * timescale + ((WorldPos.x - WorldPos.y) / worldscale));
  shwingness = shwingness * shwingness;
  shwingness -= 0.9999;
  if(shwingness < 0) shwingness = 0;
  
  shwingness *= 2000;

	mediump vec4 basecolor = tint * texture2D(Texture, actualTex);
  
  basecolor.r += shwingness;
  basecolor.g += shwingness;
  basecolor.b += shwingness;
  
	//Discard if transparent
	if(basecolor.a < 0.01)
	{
		discard;
	}

	gl_FragColor = basecolor;
}
