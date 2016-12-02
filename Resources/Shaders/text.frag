
#version 330 core
in vec2 TexCoords;
in vec3 WorldPos;
out vec4 gl_FragColor;

uniform sampler2D text;

uniform vec4 color;

uniform float time;

void main()
{
   float sampled = texture(text, TexCoords).r;


	if(sampled < 0.05)
	{
		discard;
	}

	

	vec4 realcolor = color;

	
	/* RAINBOW EFFECT */
	///realcolor.r = sin(time - (WorldPos.x * 0.0002));
	///realcolor.g = cos(time - (WorldPos.x * 0.0002));
	///realcolor.b = -sin(time - (WorldPos.x * 0.0002));
	
	gl_FragColor = realcolor;
}
