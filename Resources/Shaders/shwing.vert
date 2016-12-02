// Vertex Shader

#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec2 texCoord;

out vec2 TexCoord;
out vec3 WorldPos;

uniform mat4 world_to_screen_transform;
uniform mat4 object_to_world_transform;

uniform float time;

void main()
{
  mat4 broken = mat4(
    vec4(0.5, sin(time) / 4, 0.0, sin(time / 3)),
    vec4(0.0, 0.5, 0.0, 0.0),
    vec4(0.0, 0.0, 0.1, 0.0),
    vec4(0.0, 0.0, 0.0, 1.0)
  );

  gl_Position = (world_to_screen_transform * object_to_world_transform * vec4(position, 1.0f));
  WorldPos = (object_to_world_transform * vec4(position, 1.0)).xyz;

  TexCoord = texCoord;
}
