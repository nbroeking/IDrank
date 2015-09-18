//
//  Main_Navigation_View_Controller.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "Main_Navigation_View_Controller.h"
#import "ViewController.h"
#import "Stat.h"
#import "ListOfDrinks.h"

@interface Main_Navigation_View_Controller ()

@end

@implementation Main_Navigation_View_Controller
@synthesize night;
@synthesize person;
@synthesize historyNights;
@synthesize drinkList;

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
// Initilaizing code
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
   
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    // Allocate objects
    night = [[Stat alloc] init];
    person = [[Information alloc] init];
    historyNights = [[NSMutableArray alloc] init];
    drinkList = [[ListOfDrinks alloc] init];

    //Load data
    [self load_data];
    
    // If we were in the middle of a night resume
    if( [person first_log] )
    {
        [(ViewController*)self.topViewController performSegueWithIdentifier:@"disclamerSegue" sender:self];
    }
    
    if( [night get_night_is_started] == true)
    {
        [(ViewController*)self.topViewController performSegueWithIdentifier:@"startNightSeque" sender:self];
    }

    /*if we were in the middle of a night */
    
    // Custom initialization
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
// Saving loading and updating data
-(void) save_data
{
    // Saves the objects 
    [person saveData];
    [night saveData];
    [drinkList saveData];
    [NSKeyedArchiver archiveRootObject:historyNights toFile: [self archivePath]];

}
-(void) load_data
{
    // Loads all the objects in
    [person loadData];
  
    Stat *temp1 = [NSKeyedUnarchiver unarchiveObjectWithFile:[night archivePath]];

    if( temp1 != NULL)
    {
        [self setNight:temp1];
    }
    
    NSMutableArray *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    
    if( temp != NULL )
    {
        [self setHistoryNights:temp];
    }

    ListOfDrinks *temp2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[drinkList archivePath]];
    
    if(temp2 != NULL)
    {
        [self setDrinkList:temp2];
    }
    else
    {
        [drinkList resetDrinkList:self];
    }


    //Makes sure night is synced
    [night set_user_gender:[person get_gender]];
    [night set_user_weight:[person get_weight]];
    [night setUser_age:[person age]];
    [night setLocation:[person location]];
    
}

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
// As the night is about to start
-(void)start_night_data
{
    // ALlocate objects
    night = [[Stat alloc] init];
    [night set_night_is_started:true];
    [night setUser_gender:[person get_gender]];
    [night setUser_weight:[person get_weight]];
    [night setUser_age:[person age]];
    [night setLocation:[person location ]];
    [self save_data];
}

-(long) isReadyStart
{
    // Checks for settings errors 
    if(([person get_gender] == 0)&&([person get_weight]==0)&&([person age]== 0))
       {
           return 4; //Return 4 if none of the settings are set
       }
    else if((([person get_gender] == 0)&&([person get_weight]==0))||(([person get_gender] == 0)&&([person age] == 0 ) )||(([person get_weight] == 0)&&([person age] == 0)))
    {
        return 5; // Return 5 if only 2 of the settings are set
    }
    else if( ([person get_gender] == 0))
       {
           return 1; // Return 1 if gender is not set
       }
    else if( [person get_weight] == 0 )
       {
           return 2; // Return 2 if weight is not set
       }
    else if( [person age] == 0)
    {
        return 3; // Return 3 if age is not set
    }
    return 0; // If everything is good return 0
}

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
// Set and get methods
-(double) getPersonWeight
{
    return [person get_weight];
}
-(long) getPersonSex
{
    return [person get_gender];
}

-(void) setPersonData: (long)maleGender : (double)weight
{
    [person set_weight: weight];
    [person set_gender: maleGender];
}
-(Stat*) getStat
{
    return night;
}

-(ListOfDrinks*) getDrinkList
{
    return drinkList;
}


//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
// End Night methods
-(void)endNightData
{
    // Sets is night started to false
    // adds the night to the hisory nights array
    [night set_night_is_started:false];
    
    if( [night get_start_time] != NULL)
    {
        [historyNights addObject:night];
    }
    // Save Data
    [self save_data];
}

-(NSString*) archivePath
{
    // This finds the archive path for history nights
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [ directories objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"HistoryData.bin"];
}
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
-(void)resetData
{
    // This resets all of the data
    [person set_gender:0];
    [person set_weight:0];
    [person setLocation:false];
    [person setAge:0];
    
    [drinkList resetDrinkList:self];
    
}
@end
