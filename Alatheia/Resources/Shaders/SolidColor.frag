//Fragment shader

#version 330 core

out vec4 gl_FragColor;

uniform vec4 color;


void main()
{
	gl_FragColor = color;
}
