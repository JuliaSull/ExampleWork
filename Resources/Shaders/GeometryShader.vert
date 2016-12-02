// Vertex Shader

#version 330 core

uniform mat4 object_to_world_transform;
uniform mat4 world_to_screen_transform;

in vec3 pos;

void main()
{
    gl_Position = world_to_screen_transform * object_to_world_transform * vec4(pos.x, 0, 0, 1.0);

}
