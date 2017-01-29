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
float saturation = 0.35;

void main()
{
	vec2 actualTex = TexCoord + texOffset;
  
  float dist = distance(WorldPos, player_world_position);
	float timescale = 0.5;

	if(mirrorX)
	{
		actualTex.x = texOffset.x + frameSize.x - TexCoord.x;
	}

	mediump vec4 basecolor = tint * texture2D(Texture, actualTex);
  
	//Discard if transparent
	if(basecolor.a < 0.01)
	{
		discard;
	}

	gl_FragColor = basecolor;
}
