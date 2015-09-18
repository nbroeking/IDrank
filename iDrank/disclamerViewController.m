//
//  disclamerViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 1/22/13.
//  Copyright (c) 2013 MANNW. All rights reserved.
//

#import "disclamerViewController.h"
#import "Main_Navigation_View_Controller.h"

@interface disclamerViewController ()

@end

@implementation disclamerViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    // Removes the navigation bottom bar
    if (self.navigationController.topViewController != self)
    {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Adds the navigation bottom bar
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(IBAction)accept:(id)sender
{
    [[(Main_Navigation_View_Controller*)self.navigationController person] setFirst_log:false];
    [self.navigationController popViewControllerAnimated:YES];
    [(Main_Navigation_View_Controller*)self.navigationController save_data];
}
-(IBAction)deny:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Note" message:@"In order to use this app you must accept the disclamer. If you do not want to accept the disclamer please terminate the app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

@end
