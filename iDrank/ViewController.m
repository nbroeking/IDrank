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
            long ok = [(Main_Navigation_View_Controller*)self.navigationController isReadyStart];
            if( ok == 0 )
            {
                [self performSegueWithIdentifier:@"startNightSeque" sender:self];
                [(Main_Navigation_View_Controller*)self.navigationController start_night_data];
            }
            else if( ok == 1)
            {
                UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error!" message:@"You must set your gender" preferredStyle: UIAlertControllerStyleAlert];
                                            
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [error addAction:defaultAction];
                [self presentViewController:error animated:YES completion:nil];
                [self performSegueWithIdentifier: @"settingSegue" sender:self];
            }
            else if( ok == 3)
            {
                
                UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error!" message:@"You must set your age." preferredStyle: UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [error addAction:defaultAction];
                [self presentViewController:error animated:YES completion:nil];
                
        
                [self performSegueWithIdentifier:@"settingSegue" sender:self];
            }
            else if( ok == 4)
            {
                
                UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"Please set your setting before using our app." preferredStyle: UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [error addAction:defaultAction];
                [self presentViewController:error animated:YES completion:nil];
                
                [self performSegueWithIdentifier:@"settingSegue" sender:self];
            }
            else if( ok == 5)
            {
                UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error!" message:@"You need to set your settings." preferredStyle: UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [error addAction:defaultAction];
                [self presentViewController:error animated:YES completion:nil];
                [self performSegueWithIdentifier:@"settingSegue" sender:self];
            }
            else
            {
        
                UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error!" message:@"You must set your weight" preferredStyle: UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [error addAction:defaultAction];
                [self presentViewController:error animated:YES completion:nil];
                [self performSegueWithIdentifier: @"settingSegue" sender:self];
            }
        }
    else
    {
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error!" message:@"You must have at least one drink in each category." preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [error addAction:defaultAction];
        [self presentViewController:error animated:YES completion:nil];
        
        [self performSegueWithIdentifier:@"settingSegue" sender:self];
    }
}
// Hide the navigation controller code
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

- (void) viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    // Removes the navigation bottom bar
    if (self.navigationController.topViewController != self)
    {
        self.navigationController.navigationBar.hidden = false;
    }
}


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
      // Adds the navigation bottom bar
    self.navigationController.navigationBar.hidden = true;
    //[self.navigationController setNavigationBarHidden:YES];

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
