//
//  Main_Night_View_Controller.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/21/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "Main_Night_View_Controller.h"
#import "Main_Navigation_View_Controller.h"

@interface Main_Night_View_Controller ()

@end

@implementation Main_Night_View_Controller


//Initialization methods
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
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Hides the navigation bar methods
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

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
    [self.navigationController setNavigationBarHidden:YES animated:animated];   // TEMPFIX THIS SHIT WHEN WE BUILD THE NIGHT GUI
    [super viewWillAppear:animated];
}


// End the night functions
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

-(IBAction)endNight:(id)sender
{
    [(Main_Navigation_View_Controller*)self.navigationController endNightData];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
