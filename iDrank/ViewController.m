//
//  ViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/19/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "ViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "SettingsTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//Initization code
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

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

//Start Night code
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

- (IBAction)startNight:(id)sender
{
    //allocate night object
    
    // Checks if everything is ok with settings drink
    if([self checkIfOkToStart])
        {
            // checks if everything is ok with the rest of the settings
            int ok = [(Main_Navigation_View_Controller*)self.navigationController isReadyStart];
            if( ok == 0 )
            {
                [self performSegueWithIdentifier:@"startNightSeque" sender:self];
                [(Main_Navigation_View_Controller*)self.navigationController start_night_data];
            }
            else if( ok == 1)
            {
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You must set your gender." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [error show];
        
                [self performSegueWithIdentifier: @"settingSegue" sender:self];
            }
            else if( ok == 3)
            {
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You must set your age." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [error show];
        
                [self performSegueWithIdentifier:@"settingSegue" sender:self];
            }
            else if( ok == 4)
            {
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"Please set your settings before using our app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [error show];
                [self performSegueWithIdentifier:@"settingSegue" sender:self];
            }
            else if( ok == 5)
            {
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You need to set your settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [error show];
                [self performSegueWithIdentifier:@"settingSegue" sender:self];
            }
            else
            {
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You must set your weight." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [error show];
        
                [self performSegueWithIdentifier: @"settingSegue" sender:self];
            }
        }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must have at least one drink in each category." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [self performSegueWithIdentifier:@"settingSegue" sender:self];
    }
}
// Hide the navigation controller code
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

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
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
-(bool)checkIfOkToStart
{
    
    // Checks the drink List
    bool isBeerThere = false;
    bool isWineThere = false;
    bool isLiquorThere = false;
    bool isMixedDrinkThere = false;
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    ListOfDrinks* temp = [navP getDrinkList];
    
    isBeerThere = [temp isDrinkWithName:@"beer"];
    isWineThere = [temp isDrinkWithName:@"wine"];

    isLiquorThere = [temp areShotsThere];
    isMixedDrinkThere = [temp isMixedDrinkThere];
    
    return (isBeerThere && isWineThere && isLiquorThere && isMixedDrinkThere);
}

@end
