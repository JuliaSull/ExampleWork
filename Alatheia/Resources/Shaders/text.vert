// Vertex Shader

#version 330 core

layout (location = 0) in vec4 position;

out vec2 TexCoords;
out vec3 WorldPos;

uniform mat4 world_to_screen_transform;
uniform mat4 object_to_world_transform;

uniform float time;

void main()
{
  mat4 scaledown = mat4(
    vec4(0.005, 0, 0, 0),
    vec4(0, 0.005, 0, 0),
    vec4(0, 0, 1, 0),
    vec4(0, 0, 0, 1)
    );

  gl_Position = (world_to_screen_transform *object_to_world_transform *  scaledown * vec4(position.xy, 0.0, 1.0));
  WorldPos = (object_to_world_transform * vec4(position.xy, 0.0, 1.0)).xyz;
  TexCoords = position.zw;
}
