//
//  MainMenuViewController.m
//  BooleanFunctionsSimplifier
//
//  Created by Nikita Belosludcev on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "Algo.h"
#import "ViewController.h"
@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize function0;
@synthesize function1;
@synthesize function2;
@synthesize function3;
@synthesize function4;
@synthesize function5;
@synthesize function6;
@synthesize function7;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setFunction0:nil];
    [self setFunction1:nil];
    [self setFunction2:nil];
    [self setFunction3:nil];
    [self setFunction4:nil];
    [self setFunction5:nil];
    [self setFunction6:nil];
    [self setFunction7:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [function0 release];
    [function1 release];
    [function2 release];
    [function3 release];
    [function4 release];
    [function5 release];
    [function6 release];
    [function7 release];
    [super dealloc];
}
- (IBAction)runCompute:(id)sender
{
    
    NSMutableArray *arrayWithNumbers=[[NSMutableArray alloc] init];
    if (!function0.selectedSegmentIndex) {
        [arrayWithNumbers addObject:[NSNumber numberWithInt:0]];
    }
    if (!function1.selectedSegmentIndex) {
        [arrayWithNumbers addObject:[NSNumber numberWithInt:1]];
    }
    if (!function2.selectedSegmentIndex) {
        [arrayWithNumbers addObject:[NSNumber numberWithInt:2]];
    }
    if (!function3.selectedSegmentIndex) {
        [arrayWithNumbers addObject:[NSNumber numberWithInt:3]];
    }
    if (!function4.selectedSegmentIndex) {
        [arrayWithNumbers addObject:[NSNumber numberWithInt:4]];
    }
    if (!function5.selectedSegmentIndex) {
        [arrayWithNumbers addObject:[NSNumber numberWithInt:5]];
    }
    if (!function6.selectedSegmentIndex) {
        [arrayWithNumbers addObject:[NSNumber numberWithInt:6]];
    }
    if (!function7.selectedSegmentIndex) {
        [arrayWithNumbers addObject:[NSNumber numberWithInt:7]];
    }

    Algo *algo=[[Algo alloc] init];
    

    ViewController *v=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    v.delegate=self;
    v.arrayWithElements=[algo makeComputeWithArray:arrayWithNumbers ];
    [algo release];
    [self presentModalViewController:v animated:YES];
    [v release];




}
@end
