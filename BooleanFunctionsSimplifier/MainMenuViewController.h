//
//  MainMenuViewController.h
//  BooleanFunctionsSimplifier
//
//  Created by Nikita Belosludcev on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController
@property (retain, nonatomic) IBOutlet UISegmentedControl *function0;
@property (retain, nonatomic) IBOutlet UISegmentedControl *function1;
@property (retain, nonatomic) IBOutlet UISegmentedControl *function2;
@property (retain, nonatomic) IBOutlet UISegmentedControl *function3;
@property (retain, nonatomic) IBOutlet UISegmentedControl *function4;
@property (retain, nonatomic) IBOutlet UISegmentedControl *function5;
@property (retain, nonatomic) IBOutlet UISegmentedControl *function6;
@property (retain, nonatomic) IBOutlet UISegmentedControl *function7;
- (IBAction)runCompute:(id)sender;

@end
