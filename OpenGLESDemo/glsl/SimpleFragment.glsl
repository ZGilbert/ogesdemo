varying lowp vec4 DestinationColor;

varying lowp vec2 TexCoordOut; //30.
uniform sampler2D Texture; //30.

void main(void) {
//    gl_FragColor = DestinationColor;
    gl_FragColor = DestinationColor * texture2D(Texture, TexCoordOut); //30.
}


// for 30.'s explain
// We used to set the output color to just the destination color – now we multiply the color by whatever is in the texture at the specified coordinate. texture2D is a built-in GLSL function that samples a texture for us.
