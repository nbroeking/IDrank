//
//  WineViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/24/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "WineViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "Stat.h"
@interface WineViewController ()

@end

@implementation WineViewController

@synthesize wineDrink;
@synthesize alcContent;
@synthesize bottleButton;
@synthesize slider;
@synthesize glassButton;
@synthesize picker;
@synthesize pickerDrinks;
@synthesize pickerAc;

@synthesize locationManager;
@synthesize locationMeasurements;
@synthesize bestEffortAtLocation;

//Initializing the view
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

// THis initilazes the wine view controller
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;

    [glassButton setImage:[UIImage imageNamed:@"glasscheck.png"] forState:UIControlStateHighlighted];
    [glassButton setImage:[UIImage imageNamed:@"glass.png"] forState:UIControlStateNormal];
    [bottleButton setImage:[UIImage imageNamed:@"750bottle.png"] forState:UIControlStateNormal];
    [bottleButton setImage:[UIImage imageNamed:@"750bottlecheck.png"] forState:UIControlStateHighlighted];
    
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSMutableArray* array2 = [[NSMutableArray alloc]init];
    for(int i = 0; i < [[[navP getDrinkList]get_drink_list] count]; i++)
    {
        if([[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_name] isEqualToString:@"wine"])
        {
            [array addObject:[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_type]];
            NSString* temp = [NSString stringWithFormat:@"%.1f", [[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_ac]];
            [array2 addObject:temp];
        }
    }
    
    wineDrink = [[Drink alloc] init:@"wine" witharg2:[array objectAtIndex:0] witharg3:[[array2 objectAtIndex:0]doubleValue]];
    
    slider.value = [wineDrink get_ac];
    alcContent.text = [[NSString alloc] initWithFormat:@"%.1f", [ wineDrink get_ac]];
    
    [slider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
    
    [wineDrink set_size:5];
    
    self.pickerDrinks = array;
    self.pickerAc = array2;
    glassButton.highlighted=YES;
    
    
    if( [[navP night] location] == true)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager setDelegate:self];
        self.locationMeasurements = [NSMutableArray array];
    }

 
    // Do any additional setup after loading the view.
}

//Set information
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

-(IBAction)setOunce:(id) sender
{
    glassButton.highlighted = NO;
    bottleButton.highlighted = NO;
    [self performSelector:@selector(flipButton:) withObject:sender afterDelay:0.0];
    double size = 0;
    //detect the size
    if (sender == glassButton)
    {
        size = 5.0;
        [wineDrink set_bottle_bit:FALSE];
        //[[(Main_Navigation_View_Controller*)self.navigationController getStat] set_bottle_bit:FALSE];
    }
    else if (sender == bottleButton)
    {
        size = 25.36;
        [wineDrink set_bottle_bit:TRUE];
        //[[(Main_Navigation_View_Controller*)self.navigationController getStat] set_bottle_bit:TRUE];
    }
    
    //send to drink object
    [wineDrink set_size:size];
}

-(void)updateSlider
{
    [wineDrink set_ac: slider.value];
    alcContent.text = [[NSString alloc] initWithFormat:@"%.1f", [wineDrink get_ac]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Drink adds the drink to the drink list
- (IBAction)drink:(id)sender
{
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;


    //[navP.locationManager ]

    NSDate* current_time = [[NSDate alloc] init];
    [wineDrink set_time_drank:current_time];
    [[navP getStat] do_everything:wineDrink];
    double this_bac = [[navP getStat] get_bac];
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


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [locationMeasurements addObject:newLocation];
    
    for(int i = 0; i < [locationMeasurements count]-1; i++)
    {
        CLLocation* temp = [[self locationMeasurements] objectAtIndex:i];
        CLLocation* temp2 = [[self locationMeasurements] objectAtIndex:i+1];
        
        [wineDrink set_drink_location:temp];
        if (temp == nil || temp.horizontalAccuracy > temp2.horizontalAccuracy) {
            [wineDrink set_drink_location:temp2];
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
    locationManager.delegate = nil;
}

- (void) locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
{

}



//Set view information
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

- (void)flipButton:(UIButton*)sender {
    [sender setHighlighted:YES];
}


-(IBAction)sliderChanged
{
    NSString *tempAlc = [[NSString alloc] initWithFormat:@"%0.2f", slider.value];
    alcContent.text = tempAlc;
    
    [wineDrink set_ac:slider.value];
}

//Picker functions
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
    [wineDrink set_type:current];
    NSUInteger indexOfTheObject = [pickerDrinks indexOfObject:current];
    double currentACContent = [[pickerAc objectAtIndex:indexOfTheObject] doubleValue];
    [wineDrink set_ac:currentACContent];
    slider.value = currentACContent;
    alcContent.text = [[NSString alloc] initWithFormat:@"%0.2f", slider.value];
    
    
}

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

@end
