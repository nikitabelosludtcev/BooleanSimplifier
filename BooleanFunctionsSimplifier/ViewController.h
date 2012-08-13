//
//  ViewController.h
//  BooleanFunctionsSimplifier
//
//  Created by Nikita Belosludcev on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface ViewController : GLKViewController
{
    
}

@property (assign,nonatomic) id delegate;
@property (retain ,nonatomic) NSMutableArray *arrayWithElements;
- (IBAction)runHome:(id)sender;

@end
