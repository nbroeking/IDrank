//
//  HardLiquorViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/24/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "HardLiquorViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "Stat.h"

@interface HardLiquorViewController ()

@end

@implementation HardLiquorViewController
@synthesize pslider, proof, abv, picker, shots, stepper, pickerDrinks, pickerAc, liqourDrink, proofLabel, abvLabel, shotButton, mixedDrinkButton;
@synthesize shotCount;

@synthesize locationManager;
@synthesize locationMeasurements;
@synthesize bestEffortAtLocation;
@synthesize pickerView;
@synthesize mixedDrinkArray1;
@synthesize mixedDrinkArray2;
@synthesize shotDrinkArray1;
@synthesize shotDrinkArray2;

//Initalize code
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

// This inizializes the view controller
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    shotCount = 1;
    
    stepper.value = 1;
    //
    
    shotDrinkArray1 = [[NSMutableArray alloc] init];
    shotDrinkArray2 = [[NSMutableArray alloc]init];
    mixedDrinkArray1 = [[NSMutableArray alloc]init];
    mixedDrinkArray2 = [[NSMutableArray alloc]init];
    for(long i = 0; i < [[[navP getDrinkList]get_drink_list] count]; i++)
    {
        if([[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_name] isEqualToString:@"liquor"] && [[[[navP getDrinkList] get_drink_list] objectAtIndex:i] get_mixed_drink_bit] == FALSE)
        {
            [shotDrinkArray1 addObject:[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_type]];
            NSString* temp = [NSString stringWithFormat:@"%.1f", [[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_ac]];
            [shotDrinkArray2 addObject:temp];
        }
        else if([[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_name] isEqualToString:@"liquor"] && [[[[navP getDrinkList] get_drink_list] objectAtIndex:i] get_mixed_drink_bit] == TRUE)
        {
            [mixedDrinkArray1 addObject:[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_type]];
            NSString* temp = [NSString stringWithFormat:@"%.1f", [[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_ac]];
            [mixedDrinkArray2 addObject:temp];
        }
    }
    
    liqourDrink = [[Drink alloc] init:@"liquor" witharg2:[shotDrinkArray1 objectAtIndex:0] witharg3:[[shotDrinkArray2 objectAtIndex:0]doubleValue]];
    pslider.value = [liqourDrink get_ac];
    [pslider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
    
    
    [shotButton setImage:[UIImage imageNamed:@"shotcheck.png"] forState:UIControlStateHighlighted];
    [shotButton setImage:[UIImage imageNamed:@"shot.png"] forState:UIControlStateNormal];
    [mixedDrinkButton setImage:[UIImage imageNamed:@"mixeddrink.png"] forState:UIControlStateNormal];
    [mixedDrinkButton setImage:[UIImage imageNamed:@"mixeddrinkcheck.png"] forState:UIControlStateHighlighted];
    
    shotButton.highlighted = YES;
    [liqourDrink set_size:1.5];
    
    pickerDrinks = shotDrinkArray1;
    pickerAc = shotDrinkArray2;
    
    
    NSString *alcoholContentString = [[NSString alloc]initWithFormat:@"%.1f", [liqourDrink get_ac]];
    
    NSString *proofString = [[NSString alloc] initWithFormat:@"%.1f", [liqourDrink get_ac]*2];
    
    NSString *shotCountString = [[NSString alloc] initWithFormat:@"%ldd", shotCount];
    
    
    shots.text = shotCountString;
    abv.text = alcoholContentString;
    proof.text = proofString;
    
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

//Update visual stuff methods
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

// Gets called when the slider changes
- (IBAction)sliderChanged
{
 
    [liqourDrink set_ac:(long)pslider.value];
    
    NSString *alcoholContentString = [[NSString alloc]initWithFormat:@"%.0f", [liqourDrink get_ac]];
    
    NSString *proofString = [[NSString alloc] initWithFormat:@"%.0f", [liqourDrink get_ac]*2];
    
    abv.text = alcoholContentString;
    proof.text = proofString;
}

- (void)flipButton:(UIButton*)sender {
    [sender setHighlighted:YES];
}

// Gets called when the type of drink is changed
-(IBAction)changePickerMixed:(id)sender
{
    pickerDrinks = mixedDrinkArray1;
    pickerAc = mixedDrinkArray2;
    [self.picker reloadAllComponents];
    [picker selectRow:0 inComponent:0 animated:YES];
    [liqourDrink setType:[mixedDrinkArray1 objectAtIndex:0]];
}
// Gets called when the type of drink is changed
-(IBAction)changePickerShot:(id)sender
{
    //
    pickerDrinks = shotDrinkArray1;
    pickerAc = shotDrinkArray2;
    [self.picker reloadAllComponents];
    [picker selectRow:0 inComponent:0 animated:YES];
    [liqourDrink setType:[shotDrinkArray1 objectAtIndex:0]];
}

// gets called when the stepper is changed
- (IBAction)step:(id)sender
{
    [liqourDrink set_size:(1.5*stepper.value)];
    
    NSString *shotString = [[NSString alloc] initWithFormat:@"%ld", (long)stepper.value];
    
    shots.text = shotString;
}

// Set information methods
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

// Adds a drink to the drink List
- (IBAction)drink:(id)sender {
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    NSDate* current_time = [[NSDate alloc] init];
    [liqourDrink set_time_drank:current_time];

    
    [[navP getStat] set_time_prev_drink:current_time];
    [[navP getStat] do_everything:liqourDrink];
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

    for(long i = 0; i < [locationMeasurements count]-1; i++)
    {
        CLLocation* temp = [[self locationMeasurements] objectAtIndex:i];
        CLLocation* temp2 = [[self locationMeasurements] objectAtIndex:i+1];
        
        [liqourDrink set_drink_location:temp];
        if (temp == nil || temp.horizontalAccuracy > temp2.horizontalAccuracy) {
            [liqourDrink set_drink_location:temp2];
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


// Sets the number of ounces
-(IBAction)setOz:(id)sender
{
    shotButton.highlighted = NO;
    mixedDrinkButton.highlighted = NO;
    [self performSelector:@selector(flipButton:) withObject:sender afterDelay:0.0];
    double size = 0;
    //detect the size
    if (sender == shotButton)
    {
        size = 1.5;
        [liqourDrink set_mixed_drink_bit:FALSE];
        //[[(Main_Navigation_View_Controller*)self.navigationController getStat] set_mixed_drink_bit:FALSE];

    }
    else if (sender == mixedDrinkButton)
    {
        size = 1.5;
        [liqourDrink set_mixed_drink_bit:TRUE];
        //[[(Main_Navigation_View_Controller*)self.navigationController getStat] set_mixed_drink_bit:TRUE];
    }
    
    //send to drink object
    [liqourDrink set_size:size];
    
}

//Picker methods
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

//Required for the UIPickerViewDataSource protocol
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1; //number of components
}

//Required for the UIPickerViewDataSource protocol

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
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
    NSString *current;
    
    if( mixedDrinkButton.highlighted == true)
    {
        current = [mixedDrinkArray1 objectAtIndex:row];
    }
    else
    {
        current = [shotDrinkArray1 objectAtIndex:row];
    }
    [liqourDrink set_type:current];
    
    NSUInteger indexOfTheObject = [pickerDrinks indexOfObject:current];
    
    double currentACContent = [[pickerAc objectAtIndex:indexOfTheObject] doubleValue];
    
    [liqourDrink set_ac:currentACContent];
    pslider.value = currentACContent;
    NSString *alcoholContentString = [[NSString alloc]initWithFormat:@"%.1f", [liqourDrink get_ac]];
    
    NSString *proofString = [[NSString alloc] initWithFormat:@"%.1f", [liqourDrink get_ac]*2];
    
    abv.text = alcoholContentString;
    proof.text = proofString;
    
    //proofLabel.text = [[NSString alloc] initWithFormat:@"%0.2f", pslider.value];
}




//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------

@end
