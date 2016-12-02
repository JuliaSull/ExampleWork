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

float saturation = 0.4;       //Saturation to use when paused
int numSamples = 6;           //Number of samples to use (should be even otherwise can look wierd)
float sampleSpacing = 0.004;  //Distance between each sample

void main()
{
  vec2 actualTex = TexCoord + texOffset;
  
  float dist = distance(WorldPos, player_world_position);
  float timescale = 0.5;

  if(mirrorX)
  {
	actualTex.x = texOffset.x + frameSize.x - TexCoord.x;
  }

  mediump vec4 basecolor;
  
  if(paused)
  {
    int totalSamples = numSamples * numSamples;
    int side = numSamples / 2;
    
    float baseA = basecolor.a;
     
    basecolor = vec4(0.0);
    
    for(int x = -side; x < side / 2; x++)
    {
      for(int y = -side; y < side; y++)
      {
        basecolor += texture2D(Texture, actualTex + vec2(x * sampleSpacing, y * sampleSpacing)) * 1 / totalSamples;
      }
    }
    
    
    float avgcolor = basecolor.r + basecolor.g + basecolor.b;
    avgcolor  = avgcolor / 3;
    
    basecolor.r = (saturation * basecolor.r + (1 - saturation) * avgcolor);
    basecolor.g = (saturation * basecolor.g + (1 - saturation) * avgcolor);
    basecolor.b = (saturation * basecolor.b + (1 - saturation) * avgcolor);
    
    if(basecolor.a < baseA) basecolor.a = baseA;
  }
  else
  {
	basecolor = tint * texture2D(Texture, actualTex);
  }

  //Discard if transparent
  if(basecolor.a < 0.01)
  {
  	discard;
  }
  
  //Apply fade out for background 
  if(WorldPos.z < player_world_position.z)
  {
    float avgcolor = basecolor.r + basecolor.g + basecolor.b;
    avgcolor  = avgcolor / 3;
    
    float sat = (WorldPos.z / player_world_position.z);
    basecolor.r = (sat * basecolor.r + (1 - sat) * avgcolor);
    basecolor.g = (sat * basecolor.g + (1 - sat) * avgcolor);
    basecolor.b = (sat * basecolor.b + (1 - sat) * avgcolor);
  }
  
  gl_FragColor = basecolor;
}
