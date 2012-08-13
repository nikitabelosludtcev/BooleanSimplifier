//
//  ViewController.m
//  BooleanFunctionsSimplifier
//
//  Created by Nikita Belosludcev on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    UNIFORM_NORMAL_MATRIX,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_NORMAL,
    NUM_ATTRIBUTES
};

GLfloat gCubeVertexData[492] = 
{
    // оси координат 0-6
    0.0f, 0.0f, 0.0f,         1.0f, 1.0f, 1.0f,
    5.0f, 0.0f, 0.0f,        1.0f, 1.0f, 1.0f,
    0.0f, 0.0f, 0.0f,         1.0f, 1.0f, 1.0f,
    0.0f, 5.0f, 0.0f,        1.0f, 1.0f , 1.0f,
    0.0f, 0.0f, 0.0f,         1.0f, 1.0f, 1.0f,
    0.0f, 0.0f, 5.0f,        1.0f, 1.0f, 1.0f,
    
    
    // "точки" 6-22
    // x=0 y=0 z=0
    0.0f, 0.0f, 0.0f,         1.0f, 1.0f, 1.0f,
    0.1f, 0.1f, 0.1f,        1.0f, 1.0f, 1.0f,
    //x=0 y=0 z=1
    0.0f, 0.0f, 1.0f,         1.0f, 1.0f, 1.0f,
    0.0f, 0.0f, 1.1f,        1.0f, 1.0f, 1.0f,
    
    //x=0 y=1 z=0
    0.0f, 1.0f, 0.0f,         1.0f, 1.0f, 1.0f,
    0.0f, 1.1f, 0.0f,        1.0f, 1.0f, 1.0f,
    //x=0 y=1 z=1
    0.0f, 1.0f, 1.0f,         1.0f, 1.0f, 1.0f,
    0.0f, 1.1f, 1.1f,        1.0f, 1.0f, 1.0f,
    // x=1 y=0 z=0
    1.0f, 0.0f, 0.0f,         1.0f, 1.0f, 1.0f,
    1.1f, 0.0f, 0.0f,        1.0f, 1.0f, 1.0f,
    // x=1 y=0 z=1
    1.0f, 0.0f, 1.0f,         1.0f, 1.0f, 1.0f,
    1.1f, 0.0f, 1.1f,        1.0f, 1.0f, 1.0f,
    
    // x=1 y=1 z=0
    1.0f, 1.0f, 0.0f,         1.0f, 1.0f, 1.0f,
    1.1f, 1.1f, 0.0f,        1.0f, 1.0f, 1.0f,
    
    // x=1 y=1 z=1
    1.0f, 1.0f, 1.0f,         1.0f, 1.0f, 1.0f,
    1.1f, 1.1f, 1.1f,        1.0f, 1.0f, 1.0f,
    
    //плоскости 
    
    //x 22-28
    1.0f, 0.0f, 0.0f,         1.0f, 0.0f, 0.0f,
    1.0f, 1.0f, 0.0f,         1.0f, 0.0f, 0.0f,
    1.0f, 1.0f, 1.0f,         1.0f, 0.0f, 0.0f,
    1.0f, 1.0f, 1.0f,         1.0f, 0.0f, 0.0f,
    1.0f, 0.0f, 0.0f,         1.0f, 0.0f, 0.0f,
    1.0f, 0.0f, 1.0f,         1.0f, 0.0f, 0.0f,
    //`x 28-34
    0.0f, 0.0f, 0.0f,         -1.0f, 0.0f, 0.0f,
    0.0f, 1.0f, 0.0f,         -1.0f, 0.0f, 0.0f,
    0.0f, 1.0f, 1.0f,         -1.0f, 0.0f, 0.0f,
    0.0f, 1.0f, 1.0f,         -1.0f, 0.0f, 0.0f,
    0.0f, 0.0f, 0.0f,         -1.0f, 0.0f, 0.0f,
    0.0f, 0.0f, 1.0f,         -1.0f, 0.0f, 0.0f,
    
    //y 34-40
    0.0f, 1.0f, 0.0f,         0.0f, 1.0f, 0.0f,
    1.0f, 1.0f, 0.0f,         0.0f, 1.0f, 0.0f,
    0.0f, 1.0f, 1.0f,         0.0f, 1.0f, 0.0f,
    0.0f, 1.0f, 1.0f,         0.0f, 1.0f, 0.0f,
    1.0f, 1.0f, 0.0f,         0.0f, 1.0f, 0.0f,
    1.0f, 1.0f, 1.0f,         0.0f, 1.0f, 0.0f,
    
    //`y 40-46
    0.0f, 0.0f, 0.0f,         0.0f, -1.0f, 0.0f,
    1.0f, 0.0f, 0.0f,         0.0f, -1.0f, 0.0f,
    0.0f, 0.0f, 1.0f,         0.0f, -1.0f, 0.0f,
    0.0f, 0.0f, 1.0f,         0.0f, -1.0f, 0.0f,
    1.0f, 0.0f, 0.0f,         0.0f, -1.0f, 0.0f,
    1.0f, 0.0f, 1.0f,         0.0f, -1.0f, 0.0f,
    
    //z 46-52
    0.0f, 0.0f, 1.0f,         0.0f, 0.0f, 1.0f,
    0.0f, 1.0f, 1.0f,         0.0f, 0.0f, 1.0f,
    1.0f, 1.0f, 1.0f,         0.0f, 0.0f, 1.0f,
    1.0f, 1.0f, 1.0f,         0.0f, 0.0f, 1.0f,
    0.0f, 0.0f, 1.0f,         0.0f, 0.0f, 1.0f,
    1.0f, 0.0f, 1.0f,         0.0f, 0.0f, 1.0f,
    
    //`z 52-58
    0.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    0.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    0.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    
    //lines
    
    // -`y`z lines 58-60
    
    0.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    
    //  -y`z lines 60-62
    
    0.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    
    // -yz lines 62-64
    
    0.0f, 1.0f, 1.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 1.0f, 1.0f,         0.0f, 0.0f, -1.0f,    
    
    // -`yz lines 64-66
    
    0.0f, 0.0f, 1.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 0.0f, 1.0f,         0.0f, 0.0f, -1.0f,
    
    
    // `x-`z lines 66-68
    0.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    0.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    
    
    //  x-`z lines 68-70
    1.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
 
    
    // x-z lines 70-72
    1.0f, 0.0f, 1.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 1.0f, 1.0f,         0.0f, 0.0f, -1.0f,
   
    
    // `x-z lines 72-74
    0.0f, 0.0f, 1.0f,         0.0f, 0.0f, -1.0f,
    0.0f, 1.0f, 1.0f,         0.0f, 0.0f, -1.0f,

    
    // `x`y-   lines 74-76
    0.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    0.0f, 0.0f, 1.0f,         0.0f, 0.0f, -1.0f,
    
    
    //  x`y-   lines 76-78
    1.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 0.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    
    
    // xy-     lines 78-80
    1.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    1.0f, 1.0f, 1.0f,         0.0f, 0.0f, -1.0f,
    
    
    // `xy- lines 80-82
    0.0f, 1.0f, 0.0f,         0.0f, 0.0f, -1.0f,
    0.0f, 1.0f, 1.0f,         0.0f, 0.0f, -1.0f,
    
    
    
    
    
    
    
    
    
    
    
};





@interface ViewController () {
    GLuint _program;
    
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    float _rotation;
    float _x,_y;
    GLuint _vertexArray;
    GLuint _vertexBuffer;
}
@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

- (void)setupGL;
- (void)tearDownGL;

- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end

@implementation ViewController
@synthesize delegate;
@synthesize arrayWithElements;
@synthesize context = _context;
@synthesize effect = _effect;

- (void)dealloc
{
    [_context release];
    [_effect release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2] autorelease];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
    _x=0;
    _y=0;
}

- (void)viewDidUnload
{    
    [super viewDidUnload];
    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    // [self loadShaders];
    
    self.effect = [[[GLKBaseEffect alloc] init] autorelease];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);
    
    glEnable(GL_DEPTH_TEST);
    //glEnable (GL_BLEND);
    //glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
    
    glBindVertexArrayOES(0);
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
    
    self.effect = nil;
    
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
 
    
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -10.0f);
    
        // Compute the model view matrix for the object rendered with GLKit
        GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f,  0.0f);
        modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _x, 0.0f, 1.0f, 0.0f);
        modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _y, 1.0f, 0.0f, 0.0f);
        modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    
    
    
    
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glBindVertexArrayOES(_vertexArray);
    // Render the object with GLKit
    [self.effect prepareToDraw];
    
    glLineWidth(4);
    glDrawArrays(GL_LINES, 0, 6);
    
    
    [self.effect prepareToDraw];
    self.effect.material.diffuseColor=GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    glLineWidth(10);
    // glDrawArrays(GL_LINES, 6, 22);
    
    for (NSString *string in arrayWithElements) {
        
        
        
        if ([ string isEqualToString:@"1--"]) {
            glDrawArrays(GL_TRIANGLES, 22, 6);
        }else 
            if ([ string isEqualToString:@"0--"]) {
                glDrawArrays(GL_TRIANGLES, 28, 6);
            }else
                if ([ string isEqualToString:@"-1-"]) {
                    glDrawArrays(GL_TRIANGLES, 34, 6);
                }else
                    if ([ string isEqualToString:@"-0-"]) {
                        glDrawArrays(GL_TRIANGLES, 40, 6);
                    }else
                        if ([ string isEqualToString:@"--1"]) {
                            glDrawArrays(GL_TRIANGLES, 46, 6);
                        }else
                            if ([ string isEqualToString:@"--0"]) {
                                glDrawArrays(GL_TRIANGLES, 52, 6);
                            }
                            else 
                                
                                if ([ string isEqualToString:@"000"]) {
                                    glDrawArrays(GL_LINES, 6, 2);
                                }else
                                    if ([ string isEqualToString:@"001"]) {
                                        glDrawArrays(GL_LINES, 8, 2);
                                    }else
                                        if ([ string isEqualToString:@"010"]) {
                                            glDrawArrays(GL_LINES, 10, 2);
                                        }else
                                            if ([ string isEqualToString:@"011"]) {
                                                glDrawArrays(GL_LINES, 12, 2);
                                            }else
                                                if ([ string isEqualToString:@"100"]) {
                                                    glDrawArrays(GL_LINES, 14, 2);
                                                }else 
                                                    if ([ string isEqualToString:@"101"]) {
                                                        glDrawArrays(GL_LINES, 16, 2);
                                                    }else
                                                        if ([ string isEqualToString:@"110"]) {
                                                            glDrawArrays(GL_LINES, 18, 2);
                                                        }else
                                                            if ([ string isEqualToString:@"111"]) {
                                                                glDrawArrays(GL_LINES, 20, 2);
                                                            }
        
        else
            if ([ string isEqualToString:@"-00"]) {
                glDrawArrays(GL_LINES, 58, 2);
            }        
            else
                if ([ string isEqualToString:@"-01"]) {
                    glDrawArrays(GL_LINES, 64, 2);
                }  else
                    if ([ string isEqualToString:@"-10"]) {
                        glDrawArrays(GL_LINES, 60, 2);
                    }  else
                        if ([ string isEqualToString:@"-11"]) {
                            glDrawArrays(GL_LINES, 62, 2);
                        }  else
                            if ([ string isEqualToString:@"0-0"]) {
                                glDrawArrays(GL_LINES, 66, 2);
                            }  else
                                if ([ string isEqualToString:@"0-1"]) {
                                    glDrawArrays(GL_LINES, 72, 2);
                                }  else
                                    if ([ string isEqualToString:@"1-0"]) {
                                        glDrawArrays(GL_LINES, 68, 2);
                                    }  else
                                        if ([ string isEqualToString:@"1-1"]) {
                                            glDrawArrays(GL_LINES, 70, 2);
                                        }  else
                                            if ([ string isEqualToString:@"00-"]) {
                                                glDrawArrays(GL_LINES, 74, 2);
                                            }  else
                                                if ([ string isEqualToString:@"01-"]) {
                                                    glDrawArrays(GL_LINES, 80, 2);
                                                }  else
                                                    if ([ string isEqualToString:@"10-"]) {
                                                        glDrawArrays(GL_LINES, 76, 2);
                                                    }  else
                                                        if ([ string isEqualToString:@"11-"]) {
                                                            glDrawArrays(GL_LINES, 78, 2);
                                                        }  
        
        
        
        
    }
    
    
    
    
    
    
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
    NSLog(@"as");
        
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {

   
    float difx = [[touches anyObject] locationInView:self.view].x - [[touches anyObject] previousLocationInView:self.view].x;
    float dify = [[touches anyObject] locationInView:self.view].y - [[touches anyObject] previousLocationInView:self.view].y;
    
    
    
    _x+=0.005*difx;
    
    _y+=0.005*dify;
   
     
    
}




- (IBAction)runHome:(id)sender {
    [delegate dismissModalViewControllerAnimated:YES];
}
@end