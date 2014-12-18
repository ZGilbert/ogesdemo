//
//  OpenGLView.m
//  OpenGLDemo
//
//  Created by zhu_hbo on 14/12/3.
//  Copyright (c) 2014年 zhu_hbo. All rights reserved.
//

#import "OpenGLView.h"
#import "CC3GLMatrix.h"

//36.
#define TEX_COORD_MAX 1

//10. 一个用于跟踪所有顶点信息的结构Vertex(目前只包含位置和颜色)
typedef struct {
    float Position[3];
    float Color[4];
    float TexCoord[2]; //31. Add texture coordinates to Vertex structure as this
    
} Vertex;

//40. define a new set of vertices for the rectangle where we’ll draw the fish texture. Note we make it a little bit smaller than the front face, and we also make the z coordinate slightly taller so it will show up. Otherwise, it could be discarded by the depth test.
const Vertex Vertices2[] = {
    {{0.5, -0.5, 0.01}, {1, 1, 1, 1}, {1, 1}},
    {{0.5, 0.5, 0.01}, {1, 1, 1, 1}, {1, 0}},
    {{-0.5, 0.5, 0.01}, {1, 1, 1, 1}, {0, 0}},
    {{-0.5, -0.5, 0.01}, {1, 1, 1, 1}, {0, 1}},
};

//40.
const GLubyte Indices2[] = {
    1, 0, 2, 3
};

/*//11. 定义了以上面这个Vertex结构为类型的array
//21.
const Vertex Vertices[] = {{{1, -1, 0}, {1, 0, 0, 1}}, {{1, 1, 0}, {0, 1, 0, 1}}, {{-1, 1, 0}, {0, 0, 1, 1}}, {{-1, -1, 0}, {0, 0, 0, 1}}};

//18. 把之前的vertices数据修改一下,让z坐标为-7
//const Vertex Vertices[] = {
//    {{1, -1, -7}, {1, 0, 0, 1}},
//    {{1, 1, -7}, {0, 1, 0, 1}},
//    {{-1, 1, -7}, {0, 0, 1, 1}},
//    {{-1, -1, -7}, {0, 0, 0, 1}}
//};

//12. 一个用于表示三角形顶点的数组
const GLubyte Indices[] = {0, 1, 2, 2, 3, 0};*/ //"25"之后, "26"之前

/*//26. 3D方块
const Vertex Vertices[] = {
//    {{1, -1, 0}, {1, 0, 0, 1}},
//    {{1, 1, 0}, {1, 0, 0, 1}},
//    {{-1, 1, 0}, {0, 1, 0, 1}},
//    {{-1, -1, 0}, {0, 1, 0, 1}},
//    {{1, -1, -1}, {1, 0, 0, 1}},
//    {{1, 1, -1}, {1, 0, 0, 1}},
//    {{-1, 1, -1}, {0, 1, 0, 1}},
//    {{-1, -1, -1}, {0, 1, 0, 1}} //31.之后 32.之前
    
    //32. Add texture coordinates to Vertices as follows
    {{1, -1, 0}, {1, 0, 0, 1}, {1, 0}},
    {{1, 1, 0}, {1, 0, 0, 1}, {1, 1}},
    {{-1, 1, 0}, {0, 1, 0, 1}, {0, 1}},
    {{-1, -1, 0}, {0, 1, 0, 1}, {0, 0}},
    {{1, -1, -1}, {1, 0, 0, 1}, {1, 0}},
    {{1, 1, -1}, {1, 0, 0, 1}, {1, 1}},
    {{-1, 1, -1}, {0, 1, 0, 1}, {0, 1}},
    {{-1, -1, -1}, {0, 1, 0, 1}, {0, 0}}
};*/ //36之后,37之前

//37.
const Vertex Vertices[] = {

    // Front
    {{1, -1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, 0}, {0, 0, 0, 1}, {0, 0}},
    // Back
    {{1, 1, -2}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{-1, -1, -2}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, -1, -2}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, 1, -2}, {0, 0, 0, 1}, {0, 0}},
    // Left
    {{-1, -1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{-1, 1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -2}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, -2}, {0, 0, 0, 1}, {0, 0}},
    // Right
    {{1, -1, -2}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, -2}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, 1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{1, -1, 0}, {0, 0, 0, 1}, {0, 0}},
    // Top
    {{1, 1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, -2}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -2}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, 1, 0}, {0, 0, 0, 1}, {0, 0}},
    // Bottom
    {{1, -1, -2}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, -1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, -1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, -2}, {0, 0, 0, 1}, {0, 0}}
};

/*const GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 6, 5,
    4, 7, 6,
    // Left
    2, 7, 3,
    7, 6, 2,
    // Right
    0, 4, 1,
    4, 1, 5,
    // Top
    6, 2, 1,
    1, 6, 5,
    // Bottom
    0, 3, 7,
    0, 7, 4    
};*/ //37之后, 38之前

//38.
const GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 5, 6,
    4, 5, 7,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};

@implementation OpenGLView


//7. 编译vertex shader和fragment shader
-(GLuint) compileShader:(NSString *)shaderName withType:(GLenum)shaderType {
    
    //1. 这是一个UIKit编程的标准用法,就是在NSBundle中查找某个文件.
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
    
    NSError *error;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    //2. 调用glCreateShader来创建一个代表shader的OpenGL对象.这时必须告诉OpenGL,你想创建fragment shader
    //还是vertex shader. 所以便有了这个参数:shaderType
    GLuint shaderHandle = glCreateShader(shaderType);
    
    //3. 调用glShaderSource,让OpenGL获取到这个shader的源代码.(就是glsl)这里我们还把NSString转换成C-string
    const char *shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    //4. 最后,调用glCompileShader在运行时编译shader
    glCompileShader(shaderHandle);
    
    //5. 如果编译失败,glGetShderiv和glGetShaderInfoLog会把error信息输出到屏幕.(然后退出)
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    
    /*char dataBytes[21] = "kjashdjkjashdjkjashdj";
    NSData * data = [NSData dataWithBytes:dataBytes length:sizeof(dataBytes)];
    char * bytes = (char *)[data bytes];
    NSMutableString * mutaStr = [NSMutableString string];
    NSInteger i = 0;
    while (bytes[i] != '\0') {
        [mutaStr appendFormat:@"%x", bytes[i]];
        i++;
    }
    NSLog(@"%@", mutaStr);*/
    
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    return shaderHandle;
    
}

//8. 我们还需要一些步骤来编译vertex shader和fragment shader
//  把它们俩关联起来
//  告诉OpenGL来调用这个程序,还需要一些指针什么的.
-(void) compileShaders {
    
    //1. 用来调用刚刚写的动态编译方法, 分别编译了vertex shader和fragment shader
    GLuint vertexShader = [self compileShader:@"SimpleVertex" withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:@"SimpleFragment" withType:GL_FRAGMENT_SHADER];
    
    //2. 调用了glCreateProgram glAttachShader glLinkProgram连接vertex和fragment shader成一
    //个完整的program
    GLuint programHandle = glCreateProgram();
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    glLinkProgram(programHandle);
    
    //3. 调用glGetProgramiv glGetProgramInfoLog来检查是否有error,并输出信息
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    //4. 调用glUseProgram让OpenGL真正执行你的program
    glUseProgram(programHandle);
    
    //5. 最后,调用glGetAttribLocation来获取指向vertex shader传入变量的指针.以后可能通过这些
    //指针来使用了.还有调用glEnableVertexAttribArray来启用这些数据.(因为默认是disabled的)
    _positionSlot = glGetAttribLocation(programHandle, "Position");
    _colorSlot = glGetAttribLocation(programHandle, "SourceColor");
    _projectionUniform = glGetUniformLocation(programHandle, "Projection"); //15. 通过调用glGetUniformLocation来获取在vertex shader中的Projection输入变量
    _modelViewUniform = glGetUniformLocation(programHandle, "Modelview"); //19. 获取那个model view uniform的传入变量
    
    glEnableVertexAttribArray(_positionSlot);
    glEnableVertexAttribArray(_colorSlot);
    
    //33.
    _texCoordSlot = glGetAttribLocation(programHandle, "TexCoordIn");
    glEnableVertexAttribArray(_texCoordSlot);
    _textureUniform = glGetAttribLocation(programHandle, "Texture");
}

//13.
//-(void) setupVBOs {
//    
//    GLuint vertexBuffer;
//    
//    //13.1 glGenBuffers - 创建一个Vertex Buffer对象
//    glGenBuffers(1, &vertexBuffer);
//    
//    //13.2 告诉OpenGL我们的vertexBuffer是指GL_ARRAY_BUFFER
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
//    
//    //13.3 把数据传到OpenGL-land
//    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
//    
//    GLuint indexBuffer;
//    glGenBuffers(1, &indexBuffer);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
//    
//}  //40之后,41之前

//41. store the vertex/index buffers we create in the new instance variables rather than local variables. We also create a second vertex/index buffer with our new vertices/indexes for the fish rectangle.
- (void)setupVBOs {
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_vertexBuffer2);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer2);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices2), Vertices2, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer2);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer2);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices2), Indices2, GL_STATIC_DRAW);
    
}

//30. we have to somehow give the image data to OpenGL.
-(GLuint) setupTexture:(NSString *)fileName {

    //1. Get Core Graphics image reference. As you can see this is the simplest step. We just use the UIImage imageNamed initializer I’m sure you’ve seen many times, and then access its CGImage property.
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
    
    //2. Create Core Graphics bitmap context. To create a bitmap context, you have to allocate space for it yourself. Here we use some function calls to get the width and height of the image, and then allocate width*height*4 bytes.
    //“Why times 4?” you may wonder. When we call the method to draw the image data, it will write one byte each for red, green, blue, and alpha – so 4 bytes in total.
    //“Why 1 byte per each?” you may wonder. Well, we tell Core Graphics to do this when we set up the context. The fourth parameter to CGBitmapContextCreate is the bits per component, and we set this to 8 bits (1 byte).
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte *spriteData = (GLubyte *)calloc(width*height*4, sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    
    //3. Draw the image into the context. This is also a pretty simiple step – we just tell Core Graphics to draw the image at the specified rectangle. Since we’re done with the context at this point, we can release it.
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    
    CGContextRelease(spriteContext);
    
    
    //4. Send the pixel data to OpenGL. We first need to call glGenTextures to create a texture object and give us its unique ID (called “name”).
    GLuint texName;
    glGenTextures(1, &texName);
    //We then call glBindTexture to load our new texture name into the current texture unit.
    glBindTexture(GL_TEXTURE_2D, texName);
    //The next step is to set a texture parameter for our texture, using glTexParameteri. Here we’re setting the GL_TEXTURE_MIN_FILTER (the case where we have to shrink the texture for far away objects) to GL_NEAREST (when drawing a vertex, choose the closest corresponding texture pixel).
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    //Another easy way to think of GL_NEAREST is “pixel art-like” while GL_LINEAR is “smooth”.
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    free(spriteData);
    
    return texName;
    
    /*
     Note: Setting the GL_TEXTURE_MIN_FILTER is actually required if you aren’t using mipmaps (like this case!) I didn’t know this at first and didn’t include this line, and nothing showed up. I found out later on that this is actually listed in the OpenGL common mistakes – d’oh!
     The final step is to send the pixel data buffer we created earlier over to OpenGL with glTexImage2D. When you call this function, you specify the format of the pixel data you send in. Here we specify GL_RGBA and GL_UNSIGNED_BYTE to say “there’s 1 byte for red, green, blue, and alpha.”
     OpenGL supports other pixel formats if you’d like (this is how the Cocos2D pixel formats work). But for this tutorial, we’ll stick with this simple case.
     Once we’ve sent the image data to OpenGL, we can deallocate the pixel buffer – we don’t need it anymore because OpenGL is storing the texture in the GPU. We finish by returning the texture name, which we’ll need to refer to it later when drawing.

     */
}

-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
        [self setupContext];
        [self setupDepthBuffer];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
        
        //9. 7、8步之后,添加shaders:顶点着色器和片段着色器
        [self compileShaders];
        //        [self render1];
        
        
        [self setupVBOs];
//        [self render2]; //"23"之后, "24"之前
        
        //24
        [self setupDisplayLink];
        
        //34.
        _floorTexture = [self setupTexture:@"tile_floor.png"];
        _fishTexture = [self setupTexture:@"item_powerup_fish"];
    }
    
    return self;
}

//1. 设置layer class 为CAEAGLLayer
//想要显示OpenGL的内容,你需要把它缺省的layer设置为一个特殊的layer
+(Class) layerClass {
    
    return [CAEAGLLayer class];
}

//2. 设置layer为不透明
-(void)setupLayer {
    
    _eaglLayer = (CAEAGLLayer *) self.layer;
    
    //因为缺省的话,CALayer是透明的,而透明的层对性能负荷很大,特别是OpenGL的层
    //如果可能,尽量都把层设置为不透明.
    //另一个比较明显的例子是自定义tableview cell
    _eaglLayer.opaque = YES;
}

//3. 创建OpenGL context
-(void) setupContext {
    
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    
    if (!_context) {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }
    
    if (![EAGLContext setCurrentContext:_context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}

//4. 创建render buffer (渲染缓冲区)
//Render buffer 是OpenGL的一个对象, 用于存放渲染过的图像
//有时候你会发现render buffer会作为一个color buffer被引用,因为本质上它就是存放用于显示的颜色
-(void) setupRenderBuffer {
    
    //4.1 调用glGenRenderbuffers 来创建一个新的render buffer object.这里返回一个唯一的integer来
    //标记render buffer(这里把这个唯一值赋值到_colorRenderBuffer).有时候你会发现这个唯一值被用来作为
    //程序内的一个OpenGL的名称.(反正它唯一嘛)
    glGenRenderbuffers(1, &_colorRenderBuffer);
    
    //4.2 调用glBindRenderbuffer,告诉这个OpenGL: 我在后面引用GL_RENDERBUFFER的地方,其实是想用
    //_colorRenderBuffer.其实就是告诉OpenGL,我们定义的buffer对象是属于哪一种OpenGL对象
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    
    //4.3 最后,为render buffer分配空间.renderbufferStorage
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

//27. 3D
-(void) setupDepthBuffer {

    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
    
    //这里使用了glRenderbufferStorage, 而不是context的renderBufferStorage（这个是在OpenGL的view中特别为color render buffer而设的）
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
    
}


//5. 创建一个frame buffer (帧缓冲区)
//Frame buffer也是OpenGL的对象,它包含了前面提到的render buffer, 以及其它后面会讲到的诸如:depth buffer、
//stencil buffer和accumulation buffer.
-(void) setupFrameBuffer {
    
    //5.1 类似render buffer的创建
    GLuint framebuffer;
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    
    //5.2 把前面创建的buffer render依附在frame buffer的 GL_COLOR_ATTACHMENT0 位置上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
    
    //28. 调用glFramebufferRenderbuffer，来关联depth buffer和render buffer。还记得，我说过frame buffer中储存着很多种不同的buffer？这正是一个新的buffer。
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
}

//22. 理想状态下，我们希望OpenGL的渲染频率跟屏幕的刷新频率一致。
-(void) setupDisplayLink {

    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

//6. 清理屏幕
//为了尽快在屏幕上显示一些什么,在我们和那些vertexes,shaders打交道之前,把屏幕清理一下,显示另一个颜色(RGB0,104,55,绿色)
//这里每个RGB色的范围是0~1,所以每个要除一下255.
-(void) render1 {
    
    //6.1 调用glClearColor,设置一个RGB颜色和透明度, 接下来会用这个颜色涂满全屏.
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    
    //6.2 调用glClear来进行这个"填色"的动作(大概就是photoshop那个油桶).还记得前面说过有很多buffer的话,这里我们要用
    //到GL_COLOR_BUFFER_BIT来声明要清理哪一个缓冲区.
    glClear(GL_COLOR_BUFFER_BIT);
    
    //6.3 调用OpenGL context的presentRenderbuffer方法,把缓冲区(render buffer和color buffer)的颜色呈现到UIView上
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

//14. 用新的渲染方法来把顶点数据画到屏幕上
-(void) render2 {
    
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    //16. 使用math library来创建投影矩阵.通过这个让你指定坐标, 以及远近屏位置的方式,来创建矩阵,会让事情比较简单.
    CC3GLMatrix *projection = [CC3GLMatrix matrix];
    float h = 4.0f * self.frame.size.height /self.frame.size.width;
    [projection populateFromFrustumLeft:-2 andRight:2 andBottom:-h/2 andTop:h/2 andNear:4 andFar:10];
    
    //17. 你用来把数据 传入到vertex shader的方式,叫做glUniformMatrix4fv.这个CC3GLMatrix类有一个很方便的方法
    //glMatrix,来把矩阵转换成OpenGL的array的格式.
    glUniformMatrix4fv(_projectionUniform, 1, 0, projection.glMatrix);
    
    
    //20. 使用cocos3d math库来创建一个新的矩阵，在变换中装入矩阵。
    //变换是在z轴上移动-7，而为什么sin(当前时间) 呢？
    //哈哈，如果你还记得高中时候的三角函数。sin()是一个从-1到1的函数。已PI（3.14）为一个周期。这样做的话，约每3.14秒，这个函数会从-1到1循环一次。
    CC3GLMatrix *modelView = [CC3GLMatrix matrix];
//    NSLog(@"currentTime ==> %f", CACurrentMediaTime()*1000);
    [modelView populateFromTranslation:CC3VectorMake(sin(CACurrentMediaTime()), 0, -7)];
    glUniformMatrix4fv(_modelViewUniform, 1, 0, modelView.glMatrix);
    
    
    //14.1 调用glViewport设置UIView中用于渲染的部分.这个例子中指定了整个屏幕.但如果你希望用更小的部分,可以更变这些参数
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    
    
    //14.2 调用glVertexAttribPointer来为vertex shader的两个输入参数配置两个合适的值.
    //这是一个很重要的方法
    //第一个参数,声明这个属性的名称,之前我们称之为glGetAttribLocaiton
    //第二个参数,定义这个属性由多少个值组成.譬如说position是由3个float(x, y, z)组成,而颜色是4个float(r, g, b, a)
    //第三个参数,声明每一个值是什么类型.(这例子中无论是位置还是颜色, 我们都用了GL_GLOAT)
    //第四个参数,..总是false就好了.
    //第五个参数,指stride的大小.这是一个描述每个vertex数据大小的方式.所以我们可以简单地传入sizeof(Vertex),让编译器计算出来就好.
    //最后一个,是这个数据结构的偏移量.表示在这个结构中,从哪里开始获取我们的值.Position的值在前面,所以传0进去就可以了.而颜色是紧接着位置
    //的数据,而position的大小是3个float的大小,所以是从3*sizeof(float)开始的.
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *)(sizeof(float)*3));
    
    
    //14.3 调用glDrawElements ，它最后会在每个vertex上调用我们的vertex shader，以及每个像素调用fragment shader，最终画出我们的矩形。
    //它也是一个重要的方法，我们来仔细研究一下：
    //第一个参数，声明用哪种特性来渲染图形。有GL_LINE_STRIP 和 GL_TRIANGLE_FAN。然而GL_TRIANGLES是最常用的，特别是与VBO 关联的时候。
    //第二个参数，告诉渲染器有多少个图形要渲染。我们用到C的代码来计算出有多少个。这里是通过个 array的byte大小除以一个Indice类型的大小得到的。
    //第三个参数，指每个indices中的index类型
    //最后一个，在官方文档中说，它是一个指向index的指针。但在这里，我们用的是VBO，所以通过index的array就可以访问到了
    //（在GL_ELEMENT_ARRAY_BUFFER传过了），所以这里不需要.
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
    
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

//23. 新的渲染方法
-(void) render:(CADisplayLink *)displayLink {
    
    //44. The first line uses glBlendFunc to set the blending algorithm. It’s set to GL_ONE for the source (which means “take all of the source”) and GL_ONE_MINS_SRC_ALPHA for the destination (which means “take all of the destination except where the source is set”).
    //For more discussion on blending modes, check out this tutorial for more information and a pointer to a cool online tool.
    //The second line enables blending. And that’s it!
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    /*
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);*/ //"28"之后, "29"之前
    
    //29. 3D实体化 我们在每次update时都清除深度buffer，并启用depth  testing。
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    //16. 使用math library来创建投影矩阵.通过这个让你指定坐标, 以及远近屏位置的方式,来创建矩阵,会让事情比较简单.
    CC3GLMatrix *projection = [CC3GLMatrix matrix];
    float h = 4.0f * self.frame.size.height /self.frame.size.width;
    [projection populateFromFrustumLeft:-2 andRight:2 andBottom:-h/2 andTop:h/2 andNear:4 andFar:10];
    
    //17. 你用来把数据 传入到vertex shader的方式,叫做glUniformMatrix4fv.这个CC3GLMatrix类有一个很方便的方法
    //glMatrix,来把矩阵转换成OpenGL的array的格式.
    glUniformMatrix4fv(_projectionUniform, 1, 0, projection.glMatrix);
    
    
    //20. 使用cocos3d math库来创建一个新的矩阵，在变换中装入矩阵。
    //变换是在z轴上移动-7，而为什么sin(当前时间) 呢？
    //哈哈，如果你还记得高中时候的三角函数。sin()是一个从-1到1的函数。已PI（3.14）为一个周期。这样做的话，约每3.14秒，这个函数会从-1到1循环一次。
    CC3GLMatrix *modelView = [CC3GLMatrix matrix];
//    NSLog(@"currentTime ==> %f", CACurrentMediaTime()*1000);
    [modelView populateFromTranslation:CC3VectorMake(sin(CACurrentMediaTime()), 0, -7)];
    
    //25. 添加了一个叫_currentRotation的float，每秒会增加90度。
    //通过修改那个model view矩阵（这里相当于一个用于变型的矩阵），增加旋转。
    //旋转在x、y轴上作用，没有在z轴的
    _currentRotation += displayLink.duration * 90;
    [modelView rotateBy:CC3VectorMake(_currentRotation, _currentRotation, 0)];
    
    //20. 下面一行是第20, 上面的第25是插入其中的
    glUniformMatrix4fv(_modelViewUniform, 1, 0, modelView.glMatrix);
    
    //42. bind the cube vertex/index buffer before drawing it, because we can no longer assume it’s already set.
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    
    //14.1 调用glViewport设置UIView中用于渲染的部分.这个例子中指定了整个屏幕.但如果你希望用更小的部分,可以更变这些参数
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    
    //14.2 调用glVertexAttribPointer来为vertex shader的两个输入参数配置两个合适的值.
    //这是一个很重要的方法
    //第一个参数,声明这个属性的名称,之前我们称之为glGetAttribLocaiton
    //第二个参数,定义这个属性由多少个值组成.譬如说position是由3个float(x, y, z)组成,而颜色是4个float(r, g, b, a)
    //第三个参数,声明每一个值是什么类型.(这例子中无论是位置还是颜色, 我们都用了GL_GLOAT)
    //第四个参数,..总是false就好了.
    //第五个参数,指stride的大小.这是一个描述每个vertex数据大小的方式.所以我们可以简单地传入sizeof(Vertex),让编译器计算出来就好.
    //最后一个,是这个数据结构的偏移量.表示在这个结构中,从哪里开始获取我们的值.Position的值在前面,所以传0进去就可以了.而颜色是紧接着位置
    //的数据,而position的大小是3个float的大小,所以是从3*sizeof(float)开始的.
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *)(sizeof(float)*3));
    
    
    //35. Based on what we covered in the tutorial series so far, most of this should be straightforward.
    //The only thing worth mentioning in more detail is the final three lines. This is how we set the “Texture” uniform we defined in our fragment shader to the texture we loaded in code.
    //First, we activate the texture unit we want to load our texture into. On iOS, we’re guaranteed to have at least 2 texture units, and most of the time 8. This can be good if you need to perform computations on more than one texture at a time. However, for this tutorial, we don’t really need to use more than one texture unit at a time, so we’ll just stick the first texture unit (GL_TEXTURE0).
    //We then bind the texture into the current texture unit (GL_TEXTURE0). Finally, we set the texture uniform to the index of the texture unit it’s in (0).
    //Note that lines 1 and 3 aren’t strictly necessary, and a lot of times you’ll see code that doesn’t even include those lines. This is because it’s assuming GL_TEXTURE0 is already the active texture unit, and doesn’t bother setting the uniform because it defaults to 0 anyway. However, I’m including the lines here because I think it makes it a lot easier to understand for beginners.
    //35.0
    glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *)(sizeof(float)*7));
    
    //35.1
    glActiveTexture(GL_TEXTURE0);
    //35.2
    glBindTexture(GL_TEXTURE_2D, _floorTexture);
    //35.3
    glUniform1i(_textureUniform, 0);
    //now, Well… sort of. The front of the cube looks good, but the sides of the cube look wonky and stretched – what’s going on with that?
    
    //14.3 调用glDrawElements ，它最后会在每个vertex上调用我们的vertex shader，以及每个像素调用fragment shader，最终画出我们的矩形。
    //它也是一个重要的方法，我们来仔细研究一下：
    //第一个参数，声明用哪种特性来渲染图形。有GL_LINE_STRIP 和 GL_TRIANGLE_FAN。然而GL_TRIANGLES是最常用的，特别是与VBO 关联的时候。
    //第二个参数，告诉渲染器有多少个图形要渲染。我们用到C的代码来计算出有多少个。这里是通过个 array的byte大小除以一个Indice类型的大小得到的。
    //第三个参数，指每个indices中的index类型
    //最后一个，在官方文档中说，它是一个指向index的指针。但在这里，我们用的是VBO，所以通过index的array就可以访问到了
    //（在GL_ELEMENT_ARRAY_BUFFER传过了），所以这里不需要.
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
    
    //43. 鱼骨头 bind the fish rectangle vertex/index buffers, load in the fish texture, and set up all the attributes. Note we draw the triangles with a new method – GL_TRIANGLE_STRIP.
    //After the first three vertices, GL_TRIANGLE_STRIP makes new triangles by combining the previous two vertices with the next vertex. This can be nice to use because it can reduce the index buffer size. I use it here mainly to show you how it works.
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer2);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer2);
    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _fishTexture);
    glUniform1i(_textureUniform, 0);
    
    glUniformMatrix4fv(_modelViewUniform, 1, 0, modelView.glMatrix);
    
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *)(sizeof(float)*3));
    glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *)(sizeof(float)*7));
    
    glDrawElements(GL_TRIANGLE_STRIP, sizeof(Indices2)/sizeof(Indices2[0]), GL_UNSIGNED_BYTE, 0); // now,It drew our fish image, but it didn’t nicely blend the fish image with the rest of the drawing going on. To enable this just add the following two lines to the top of render:
    
    //14.4
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
