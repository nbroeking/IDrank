//
//  Help_View_ControllerViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/21/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "Help_View_ControllerViewController.h"

@interface Help_View_ControllerViewController ()

@end

@implementation Help_View_ControllerViewController
@synthesize webView;
// Initilization code
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

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
    
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"help" withExtension:@"html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    
    [webView loadRequest:request];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

@end
