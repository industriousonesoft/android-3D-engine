precision highp float;

// MVP matrices
uniform mat4 u_MMatrix;
uniform mat4 u_VMatrix;
uniform mat4 u_PMatrix;

// mesh
attribute vec4 a_Position;

// textures
uniform bool u_Textured;
attribute vec2 a_TexCoordinate;
varying vec2 v_TexCoordinate;

// lights
uniform vec3 u_LightPos;
uniform vec3 u_cameraPos;
attribute vec3 a_Normal;

// normalMap
varying vec3 v_Model;
varying vec3 v_Normal;
varying vec3 v_Light;

void main(){

    // calculate MVP matrix
    mat4 u_MVMatrix = u_VMatrix * u_MMatrix;
    mat4 u_MVPMatrix = u_PMatrix * u_MVMatrix;

    // calculate rendered position
    gl_Position = u_MVPMatrix * a_Position;

    // Transform the vertex into eye space.
    vec3 modelVertex = vec3(u_MMatrix * a_Position);
    v_Model = modelVertex;

    // Transform the normal's orientation into eye space.
    vec3 modelNormal = normalize(vec3(u_MMatrix * vec4(a_Normal, 0.0)));
    v_Normal = modelNormal;

    // Get a lighting direction vector from the light to the vertex.
    vec3 lightVector = normalize(u_LightPos - modelVertex);
    v_Light = lightVector;

    // pass texture to fragment shader
    if (u_Textured) {
        v_TexCoordinate = a_TexCoordinate;
    }
}