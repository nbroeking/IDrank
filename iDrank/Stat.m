//
//  Stat.m
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "Stat.h"
#import "Main_Navigation_View_Controller.h"

@implementation Stat
@synthesize drink_alc_content;
@synthesize type;
@synthesize start_time;
@synthesize time_prev_drink;
@synthesize time_longerval;
@synthesize total_num_alc_oz;
@synthesize running_drink_list;
@synthesize tot_num_drinks;
@synthesize night_is_started;
@synthesize user_weight;
@synthesize user_gender;
@synthesize bac;
@synthesize start_time_string;
@synthesize time_prev_drink_string;
@synthesize bac_array;
@synthesize user_age;
@synthesize location;

/*This init method initializes the Stat object. The Stat object is the workhorse of the app and calculates all of the night data*/
- (id) init
{
    if( self = [super init])
    {
        user_age = 0; 
        location = false;
        total_num_alc_oz = 0.0;  //total number of alcohol alcoholic ounces
        tot_num_drinks = 0; // total number of drinks drunk
        start_time_string = @""; // time the night started
        time_prev_drink_string = @""; //time the night ended
        running_drink_list = [[NSMutableArray alloc] init]; //Array that holds all of the drinks that the user drank
        bac_array = [[NSMutableArray alloc] init]; //Array that holds all of the BACs the user had during the night
        night_is_started = false;
    }
    return self;
}

//GETTERS
- (double) get_bac{return bac;}
- (double) get_drink_alc_content {return drink_alc_content;}
- (NSString*) get_type{return type;}
- (NSDate*) get_start_time {return start_time;}
- (NSDate*) get_time_prev_drink{return time_prev_drink;}
- (double) get_time_longerval{return time_longerval;}
- (double) get_total_num_alc_oz{return total_num_alc_oz;}
- (NSMutableArray*) get_running_drink_list {return running_drink_list;}
- (long) get_tot_num_drinks;{return tot_num_drinks;}
- (BOOL) get_night_is_started{return night_is_started;}
- (NSString*) get_start_time_string {return start_time_string;}
- (NSString*) get_time_prev_drink_string {return time_prev_drink_string;}
- (NSMutableArray*) get_bac_array {return bac_array;}
- (long) get_user_weight {return user_weight;}
- (long) get_user_gender {return user_gender;}

//SETTERS
- (id) set_user_gender:(long)gender
{
    user_gender = gender;
    return self;
}

- (id) set_user_weight:(long)weight
{
    user_weight = weight;
    return self;
}

-(id) set_bac_array:(NSMutableArray *)my_bac_array
{
    bac_array =[[NSMutableArray alloc] initWithArray:my_bac_array];
    return self;
}

- (id) set_drink_alc_content:(double)drink_ac
{
    drink_alc_content = drink_ac;
    return self;
}
- (id) set_type:(NSString *)drink_type
{
    type = drink_type;
    return self;
}
- (id) set_time_prev_drink:(NSDate *)time
{
    time_prev_drink = time;
    [self convert_prev_time];
    return self;
}
- (id) set_time_longerval:(NSDate *)first_time witharg2: (NSDate*) second_time
{
    time_longerval = fabs([second_time timeIntervalSinceDate:first_time]);
    return self;
}
- (id) set_total_num_alc_oz: (double) my_drink_alc_content witharg2: (double) my_drink_size2
{
    double standard_size;
    
    standard_size = my_drink_size2;
    
    total_num_alc_oz = total_num_alc_oz + standard_size * my_drink_alc_content/100;
    return self;
}
-(id) set_num_alc_oz:(double)oz
{
    total_num_alc_oz = oz;
    return self;
}
- (id) set_running_drink_list: (NSMutableArray*) my_list;
{
    running_drink_list =[[NSMutableArray alloc] initWithArray:my_list];
    return self;
}
- (id) set_night_is_started: (BOOL) bit;
{
    night_is_started = bit;
    return self;
}

- (id) set_tot_num_drinks: (long) number
{
    tot_num_drinks = number;
    return self;
}

- (id) set_bac: (double) my_bac
{
    bac = my_bac;
    return self;
}

- (id) set_start_time: (NSDate*) my_start_time
{
    start_time = my_start_time;
    [self convert_start_time];
    return self;
}

- (id) set_start_time_string:(NSString *)my_time
{
    start_time_string = my_time;
    return self;
}

- (id) set_time_prev_drink_string:(NSString *)my_time
{
    time_prev_drink_string = my_time;
    return self;
}

//METHODS

/*This method is responsible for calculating the users BAC based on a number of key factors: the total_alcoholic_ouces consumed, 
 the weight of the user, the gender of the user, and the time the night started. The formula used in this application is the same
 one used in the breathelizer test.*/
- (double) calculate_bac: (double) tot_alc_oz witharg2: (long) weight witharg3: (long) gender witharg4: (NSDate*) starttime
{
    // Girls process alcohol less efficiently than males, so the distribution ratio has to show this. 
    double distr_ratio = 0.0;
    double this_bac;
    if(gender == 1)
    {
        distr_ratio = .73;
    }
    else if(gender == 2)
    {
        distr_ratio = .66;
    }
    NSDate *present = [NSDate date]; //getting present timestamp
    double timeInterval_sec = [present timeIntervalSinceDate:starttime]; //getting time in seconds b/w starttime and present time
    double timeInterval_hr = timeInterval_sec/3600; //converting the time longerval to hours
    
    // Calculating the BAC based on the widely used Widmark's formula. 
    this_bac = ((tot_alc_oz * 5.14)/(weight * distr_ratio)) - (.015 * timeInterval_hr); //calculate bac
    return this_bac;
}

/*This method gets called with the user reloads the stat page without actually having drank another drink. This function was necessary 
 to give a constant recalculation of the BAC throughout the night. */
- (void) recalculate_bac 
{
    double this_bac = [self calculate_bac:[self get_total_num_alc_oz] witharg2:[self get_user_weight] witharg3:[self get_user_gender] witharg4:[self get_start_time]];
    
    /*If enough time has passed after the last drink, then the Widmark formula returns a negative value. If the value is negative, then the BAC
     gets set to 0.0*/
    if(this_bac < 0.0)
        [self set_bac:0.0];
    else
        [self set_bac: this_bac];
}

/*Converts the start time from an NSDate to a NSString to be displayed in the Stat page*/
- (void) convert_start_time
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"hh:mm a"];
    
    NSString *dateString = [format stringFromDate:start_time];
    [self set_start_time_string:dateString];
}

/*Converts the time of the previous drink from an NSDate to an NSString to be displayed in the Stat page*/
- (void) convert_prev_time
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"hh:mm a"];
    
    NSString *dateString = [format stringFromDate:time_prev_drink];
    [self set_time_prev_drink_string:dateString];
}

/*This function is called when the user drinks a drink.*/
- (void) do_everything: (Drink*) my_drink

{
    double this_bac;
    NSDate *start_date = [[NSDate alloc] init];
    
    /*It sets the start time to the current time if the user has had 0 drinks.
        It also calculates the number of drink drank along with the*/
    if(([self get_tot_num_drinks] == 0) || ([self get_bac] == 0.0))
    {
        [self set_num_alc_oz:0.0];
        start_date = [NSDate date];
        [self set_start_time:start_date];
    }

    //Calculates the number of drinks drank when the Drink button was pressed
    [self calculate_num_drinks:my_drink];
    
    //Calculates the new number of total alcoholic ounces
    [self set_total_num_alc_oz:[my_drink get_ac] witharg2:[my_drink get_size]];

    //Calculates the bac
    this_bac = [self calculate_bac:[self get_total_num_alc_oz] witharg2:[self get_user_weight] witharg3:[self get_user_gender] witharg4: [self get_start_time]];
    [self set_bac:this_bac];
    
    [self add_drink:my_drink];
}

//Adds the drink just created to the running drink list
- (void) add_drink: (Drink*) my_drink
{
    [running_drink_list addObject:my_drink];
}

//Deletes a drink at an index from the running drink list
- (void) delete_drink: (long) index
{
    [running_drink_list removeObjectAtIndex:index];
    tot_num_drinks = tot_num_drinks - 1;
}

/*This method calculates the number of drinks the user drank based on what the user just drank*/
- (void) calculate_num_drinks: (Drink*) my_drink
{
    // A beer increments the drink count by 1
    if([[my_drink get_name] isEqualToString: @"beer"])
    {
        [self set_tot_num_drinks:[self get_tot_num_drinks]+1];
    }
    // Liquor increments the drink count by however many shots the user took or by one if a mixed drink
    else if([[my_drink get_name] isEqualToString: @"liquor"])
    {
        if ([my_drink get_mixed_drink_bit] == TRUE)
        {
            [self set_tot_num_drinks:[self get_tot_num_drinks]+1];
        }
        else
        {
            long temp = [my_drink get_size]/1.5;
            [self set_tot_num_drinks:[self get_tot_num_drinks]+temp];
        }
    }
    // a glass of wine increments the drink count by 1 and a bottle by 5. 
    else
    {
        if ([my_drink get_bottle_bit] != TRUE)
        {
            [self set_tot_num_drinks:[self get_tot_num_drinks]+1];
        }
        else
        {
            long temp = [my_drink get_size]/5;
            [self set_tot_num_drinks:[self get_tot_num_drinks]+temp];
        }
    }
}

// Adds the BAC to the bac_array to be used in the running drink list
- (void) add_bac:(double)my_bac
{
    NSNumber* temp = [NSNumber numberWithDouble:(double)my_bac];
    [bac_array addObject:temp];
}

/*When a user deletes a drink from the running drink list, then the bac details of the drinks behind it have to update as well*/
-(void) reset_bac_array
{
    double temp_oz = 0.0;
    NSDate* temp_date;

    for(long i = 0; i < [[self get_running_drink_list] count]; i++)
    {
        temp_oz = temp_oz + ([[[self get_running_drink_list] objectAtIndex:i]get_size] * ([[[self get_running_drink_list]objectAtIndex:i]get_ac]/100));
        
        temp_date = [[[self get_running_drink_list]objectAtIndex:i]get_time_drank];
        
        NSNumber* temp = [NSNumber numberWithDouble:(double)[self calc_small_bac:temp_oz witharg2:[self get_user_weight] witharg3:[self get_user_gender] witharg4:[self get_start_time] witharg5:temp_date]];
        [bac_array setObject:temp atIndexedSubscript:i];

    }
}

/*This method calculates the highest bac in the bac_array 
 to be used to indicate the highest bac attained througout the night. This data is used in History*/
- (double) calculate_highest_BAC
{
    double answer = 0;
    for(long i = 0; i < [[self get_bac_array] count]; i++)
    {
        if([[[self get_bac_array] objectAtIndex:i] doubleValue] > answer)
        {
            answer = [[[self get_bac_array]objectAtIndex:i] doubleValue];
        }
    }
    return answer;
}

/*This method calculates a seperate bac based on the drinks in front of it and the start time. This method is the workhorse behind
 updating the running drink list bac details in real time.*/
- (double) calc_small_bac: (double) tot_alc_oz witharg2: (long) weight witharg3: (long)gender witharg4: (NSDate*) start_time2 witharg5: (NSDate*) current_time
{
    double distr_ratio = 0.0;
    double this_bac;
    if(gender == 1)
    {
        distr_ratio = .73;
    }
    else if(gender == 2)
    {
        distr_ratio = .66;
    }
    
    double timeInterval_sec = [current_time timeIntervalSinceDate:start_time2]; //getting time in seconds b/w starttime and present time
    double timeInterval_hr = (timeInterval_sec/3600); //converting the time longerval to hours

    this_bac = ((tot_alc_oz * 5.14)/(weight * distr_ratio)) - (.015 * timeInterval_hr); //calculate bac

    return this_bac;
}


//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------

// Added by Nic so we can save data
-(id)initWithCoder:(NSCoder *)aDecoder
{
    // This method initializes the object when loaded from file
    self = [super init];
    if( self = [super init])
    {
        [self setDrink_alc_content:[aDecoder decodeDoubleForKey:@"acCode"]];
        [self setType:[aDecoder decodeObjectForKey:@"typeCode"]];
        [self setStart_time:[aDecoder decodeObjectForKey:@"startTimeCode"]];
        [self setTime_prev_drink:[aDecoder decodeObjectForKey:@"timePrevDrinkCode"]];
        [self setTime_longerval:[aDecoder decodeDoubleForKey:@"timeIntervalCode"]];
        [self setTotal_num_alc_oz:[aDecoder decodeDoubleForKey:@"totalNumCode"]];
        [self setRunning_drink_list:[[aDecoder decodeObjectForKey:@"runningDrinkListCode"] mutableCopy]];
        [self setUser_gender:[aDecoder decodeIntegerForKey:@"genderCode"]];
        [self setUser_weight:[aDecoder decodeIntegerForKey:@"weightCode"]];
        [self setUser_age:[aDecoder decodeIntegerForKey:@"ageCode"]];
        [self setLocation:[aDecoder decodeBoolForKey:@"locationCode"]];
        [self setTot_num_drinks:[aDecoder decodeIntegerForKey:@"totNumDrinksCode"]];
        [self setNight_is_started:[aDecoder decodeBoolForKey:@"nightStartedCode"]];
        [self setBac:[aDecoder decodeDoubleForKey:@"bacCode"]];
        [self setStart_time_string:[aDecoder decodeObjectForKey:@"timeStartStringCode"]];
        [self setTime_prev_drink_string:[aDecoder decodeObjectForKey:@"timePrevStringCode"]];
        [self setBac_array:[[aDecoder decodeObjectForKey:@"bacArrayCode"] mutableCopy]];
    }
    return self;

}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    // This method encodes the object when written to file
    [aCoder encodeDouble:drink_alc_content forKey:@"acCode"];
    [aCoder encodeObject:type forKey:@"typeCode"];
    [aCoder encodeObject:start_time forKey:@"startTimeCode"];
    [aCoder encodeObject:time_prev_drink forKey:@"timePrevDrinkCode"];
    [aCoder encodeDouble:time_longerval forKey:@"timeIntervalCode"];
    [aCoder encodeDouble:total_num_alc_oz forKey:@"totalNumCode"];
    [aCoder encodeObject:running_drink_list forKey:@"runningDrinkListCode"];
    [aCoder encodeInteger:user_gender forKey:@"genderCode"];
    [aCoder encodeInteger:user_weight forKey:@"weightCode"];
    [aCoder encodeInteger:user_age forKey:@"ageCode"];
    [aCoder encodeBool:location forKey:@"locationCode"];
    [aCoder encodeInteger:tot_num_drinks forKey:@"totNumDrinksCode"];
    [aCoder encodeBool:night_is_started forKey:@"nightStartedCode"];
    [aCoder encodeDouble:bac forKey:@"bacCode"];
    [aCoder encodeObject:start_time_string forKey:@"timeStartStringCode"];
    [aCoder encodeObject:time_prev_drink_string forKey:@"timePrevStringCode"];
    [aCoder encodeObject:bac_array forKey:@"bacArrayCode"];
    
}
-(NSString*) archivePath
{
    // This is the archive path
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [ directories objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"NightData.bin"];
}
-(void) saveData
{
    // Writes object to file
    [NSKeyedArchiver archiveRootObject:self toFile: [self archivePath]];
}
-(void) loadData
{
    // = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
}


@end
