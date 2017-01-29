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

uniform float time;

uniform vec3 player_world_position;

float maxdist = 250;


void main()
{
	vec2 actualTex = TexCoord + texOffset;
  
  float dist = distance(WorldPos, player_world_position);
	float timescale = 0.5;

	if(mirrorX)
	{
		actualTex.x = texOffset.x + frameSize.x - TexCoord.x;
	}
  
  //actualTex.x -= cos((dist * sin(time)) / 15) * 0.05;
  //actualTex.y += sin((dist * (cos(time))) / 15) * 0.05;
 
  //actualTex.y += sin(WorldPos.x * time * 0.00002) * 0.15;
  
  //actualTex.x += (WorldPos - player_world_position).x * 0.001;
  //actualTex.y += (WorldPos - player_world_position).y * 0.001;

	mediump vec4 basecolor = tint * texture2D(Texture, actualTex);
  
	//Discard if transparent
	if(basecolor.a < 0.01)
	{
		discard;
	}
  
  

	float timeval = (sin(time * timescale));

	float maxDay = 0.5;
	float maxNight = 1.0;

	if(timeval > maxDay)
	{
		timeval = maxDay;
	}
	else if(timeval < -maxNight)
	{
		timeval = maxNight;
	}

	//basecolor.r += timeval * dist / maxdist;
	//basecolor.g += timeval * dist / maxdist;
	//basecolor.b += timeval * dist / maxdist;
  //
	//basecolor.r +=  timeval * 0.1;
	//basecolor.b += -timeval * 0.1;
	//basecolor.b += -(cos(time * timescale)) * 0.1;
       
  basecolor.r += (cos(time * timescale)) * 0.3;
	basecolor.b += (sin(time * timescale)) * 0.3;
	basecolor.g += (-cos(time * timescale)) * 0.3;
 
	//basecolor.r = dist / maxdist;
	//basecolor.g = WorldPos.z / maxdist;
	//basecolor.b = WorldPos.z / maxdist;

	gl_FragColor = basecolor;
}
