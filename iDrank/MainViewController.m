//
//  ViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/19/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getInformationFromCurrentNight
{
    NSLog(@"hello");
}

- (void) viewWillDisappear:(BOOL)animated
{
    if (self.navigationController.topViewController != self)
    {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    
    [super viewWillDisappear:animated];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}
@end
