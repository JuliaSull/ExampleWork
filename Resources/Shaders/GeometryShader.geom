// Geometry Shader

#version 330 core

layout(points) in;
layout(triangle_strip, max_vertices = 256) out;

const float PI = 3.1415926;

uniform float time;

uniform vec4 color;

void main()
{
  gl_Position = gl_in[0].gl_Position + vec4(offset[0], 0.0f, 0.0f, 0.0f);    // 1:bottom-left
  EmitVertex();
  gl_Position = gl_in[0].gl_Position + vec4(offset[0] + 1, 0.0f, 0.0f, 0.0f);    // 2:bottom-right
  EmitVertex();
  gl_Position = gl_in[0].gl_Position + vec4(offset[0] + 1,  1.0f, 0.0f, 0.0f);    // 3:top-left
  EmitVertex();
  gl_Position = gl_in[0].gl_Position + vec4(offset[0],  1.0f, 0.0f, 0.0f);    // 4:top-right
  EmitVertex();

  EndPrimitive();
}
