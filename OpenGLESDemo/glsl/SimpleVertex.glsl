attribute vec4 Position;
attribute vec4 SourceColor;

varying vec4 DestinationColor;

//uniform means it will be used as a constant for all of vertex
//and mat4 means a 4X4 matrix
uniform mat4 Projection;

//add another 4X4 matrix
uniform mat4 Modelview;

attribute vec2 TexCoordIn; //30.
varying vec2 TexCoordOut; //30.
void main(void) {

    DestinationColor = SourceColor;
    gl_Position = Position * Projection * Modelview;
    TexCoordOut = TexCoordIn; //30.
}


// for 30.'s explain
// Here we declare a new attribute called TexCoordIn. Remember that an attribute is a value that you can set for each vertex. So for each vertex, we’ll specify the coordinate on the texture that it should map to.
// Texture Coordinates are kind of weird in that they’re always in the range of 0-1. So (0,0) would be the bottom left of the texture, and (1,1) would be the upper right of the texture.
// Or it would be, but Core Graphics flips images when you load them in. So in the code here (0,1) is actually the bottom left and (0, 0) is the top left, oddly enough.
// We also declare a new varying called TexCoordOut, and set it to TexCoordIn. Remember that a varying is a value that OpenGL will automatically interpolate for us by the time it gets to the fragment shader. So for example if we set the bottom left corner of a square we’re texturing to (0,0) and the bottom right to (1, 0), if we’re rendering the pixel in-between on the bottom, our fragment shader will be automatically passed (0.5, 0).
