//
//  BeerViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/24/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "BeerViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "Stat.h"

@interface BeerViewController ()

@end

@implementation BeerViewController
@synthesize twelveButton;
@synthesize twentyFourButton;
@synthesize fortyButton;
@synthesize beerDrink;
@synthesize alcoholContent;
@synthesize alcoholContentSlider;
@synthesize picker;
@synthesize pickerDrinks;
@synthesize pickerAc;

@synthesize locationManager;
@synthesize locationMeasurements;
@synthesize bestEffortAtLocation;

//Intializing the code
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
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    [twelveButton setImage:[UIImage imageNamed:@"12ozcheck.png"] forState:UIControlStateHighlighted];
    [twelveButton setImage:[UIImage imageNamed:@"12oz.png"] forState:UIControlStateNormal];
    [twentyFourButton setImage:[UIImage imageNamed:@"24oz.png"] forState:UIControlStateNormal];
    [twentyFourButton setImage:[UIImage imageNamed:@"24ozcheck.png"] forState:UIControlStateHighlighted];
    [fortyButton setImage:[UIImage imageNamed:@"40oz.png" ]forState:UIControlStateNormal];
    [fortyButton setImage:[UIImage imageNamed:@"40ozcheck.png"] forState:UIControlStateHighlighted];
    
    //This approach to displaying the objects in the picker will allow for a much easier implementation of adding
    // custom drinks. It uses a ListOfDrinks that is saved in the app that the user can edit. 
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSMutableArray* array2 = [[NSMutableArray alloc]init];
    for(int i = 0; i < [[[navP getDrinkList]get_drink_list] count]; i++)
    {
        if([[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_name] isEqualToString:@"beer"])
        {
            [array addObject:[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_type]];
            NSString* temp = [NSString stringWithFormat:@"%.1f", [[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_ac]];
            [array2 addObject:temp];
        }
    }
    
    beerDrink = [[Drink alloc] init:@"beer" witharg2:[array objectAtIndex:0] witharg3:[[array2 objectAtIndex:0]doubleValue]];
    
    alcoholContentSlider.value = [beerDrink get_ac];
    //alcContent.text = [[NSString alloc] initWithFormat:@"%.1f", [ wineDrink get_ac]];
    
    [alcoholContentSlider addTarget:self action:@selector(updateSlider) forControlEvents:UIControlEventValueChanged];
    
    
    pickerDrinks = array;
    pickerAc = array2;
    
    NSString *alcoholContentString = [[NSString alloc]initWithFormat:@"%.1f", [beerDrink get_ac]];
    
    alcoholContent.text = alcoholContentString;
    twelveButton.highlighted=YES;
    [beerDrink set_size:12.0];
    

    if( [[navP night] location] == true)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager setDelegate:self];
        self.locationMeasurements = [NSMutableArray array];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Set information code
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

// Sets ounce
-(IBAction)setOunce:(UIButton*) sender
{
    twelveButton.highlighted = NO;
    twentyFourButton.highlighted = NO;
    fortyButton.highlighted = NO;
    [self performSelector:@selector(flipButton:) withObject:sender afterDelay:0.0];
    double size = 0;
   //detect the size
    if (sender == twelveButton)
        size = 12.0;
    else if (sender == twentyFourButton)
        size = 24.0;
    else if (sender == fortyButton)
        size = 40.0;
    
    //send to drink object
    [beerDrink set_size:size];
}


// Creates the drink
- (IBAction)drink:(id)sender
{
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    NSDate* current_time = [[NSDate alloc] init];
     [beerDrink set_time_drank:current_time];
    [[navP getStat] do_everything:beerDrink];
    double this_bac = [[(Main_Navigation_View_Controller*)self.navigationController getStat] get_bac];
    [[navP getStat] add_bac:this_bac];
    [[navP getStat] set_time_prev_drink:current_time];
    
    
     if( [[navP night] location] == true)
    {
        [self reset];
        [self.locationManager startUpdatingLocation];
        [self performSelector:@selector(stopUpdatingLocation:) withObject:@"Timed Out" afterDelay:5.0];

    }
    [navP popViewControllerAnimated:YES];
    
}

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
   
    [locationMeasurements addObject:newLocation];
    
    for(int i = 0; i < [locationMeasurements count]-1; i++)
    {
        
        CLLocation* temp = [[self locationMeasurements] objectAtIndex:i];
        CLLocation* temp2 = [[self locationMeasurements] objectAtIndex:i+1];
        
        [beerDrink set_drink_location:temp];
        if (temp == nil || temp.horizontalAccuracy > temp2.horizontalAccuracy) {
            [beerDrink set_drink_location:temp2];
            if (temp2.horizontalAccuracy <= 5.0) {
                return;
            }
        }
    }
}

- (void)reset
{
    self.bestEffortAtLocation = nil;
    [self.locationMeasurements removeAllObjects];
}


- (void)stopUpdatingLocation:(NSString *)state {
    [locationManager stopUpdatingLocation];

}

- (void) locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
{

}
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

// set slider and button code
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

- (void)flipButton:(UIButton*)sender {
    [sender setHighlighted:YES];
}
-(void)updateSlider
{         
    [beerDrink set_ac: alcoholContentSlider.value];
    alcoholContent.text = [[NSString alloc] initWithFormat:@"%.1f", [beerDrink get_ac]];
}

//Picker code
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

//Required for the UIPickerViewDataSource protocol
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1; //number of components
}

//Required for the UIPickerViewDataSource protocol

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
	return [pickerDrinks count];
}

//Picker Delegate methods
//returns the title for a given row
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger) row
            forComponent:(NSInteger) component{
//checks which component was picked and returns the value for the requested component.
    return [pickerDrinks objectAtIndex:row];
}

//called when a row is selected
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    NSString *current = [pickerDrinks objectAtIndex:row];
    [beerDrink set_type:current];
    
    NSUInteger indexOfTheObject = [pickerDrinks indexOfObject:current];
    double currentACContent = [[pickerAc objectAtIndex:indexOfTheObject] doubleValue];
    [beerDrink set_ac:currentACContent];
    alcoholContentSlider.value = currentACContent;
    
    NSString *alcoholContentString = [[NSString alloc]initWithFormat:@"%.1f", [beerDrink get_ac]];
        
    alcoholContent.text = alcoholContentString;
}


//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

@end
