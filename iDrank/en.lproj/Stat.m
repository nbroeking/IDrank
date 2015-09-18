//
//  Stat.m
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "Stat.h"

@implementation Stat
@synthesize drink_alc_content;
@synthesize type;
@synthesize start_time;
@synthesize time_prev_drink;
@synthesize time_interval;
@synthesize total_num_alc_oz;
@synthesize running_drink_list;
@synthesize tot_num_drinks;
@synthesize night_is_started;

- (id) init
{
    total_num_alc_oz = 0.0;
    tot_num_drinks = 0;
    running_drink_list = [NSMutableArray arrayWithObjects: nil];
    return self;
}

- (id) set_night_is_started: (BOOL) bit;
{
    night_is_started = bit;
    return self;
}

- (BOOL) get_night_is_started;
{
    return night_is_started;
}


- (id) set_running_drink_list: (NSMutableArray*) my_list;
{
    running_drink_list =[[NSMutableArray alloc] initWithArray:my_list];
    return self;
}

- (NSMutableArray*) get_running_drink_list
{
    return running_drink_list;
}

- (double) get_drink_alc_content
{
    return drink_alc_content;
}

- (id) set_drink_alc_content:(double)drink_ac
{
    drink_alc_content = drink_ac;
    return self;
}

- (NSString*) get_type
{
    return type;
}

- (id) set_type:(NSString *)drink_type
{
    type = drink_type;
    return self;
}

- (NSDate*) get_start_time
{
    return start_time;
}


- (id) set_time_prev_drink:(NSDate *)time
{
    time_prev_drink = time;
    return self;
}

- (NSDate*) get_time_prev_drink
{
    return time_prev_drink;
}

- (id) set_time_interval:(NSDate *)first_time witharg2: (NSDate*) second_time
{
    time_interval = fabs([second_time timeIntervalSinceDate:first_time]);
    return self;
}

- (id) set_tot_num_drinks: (int) number;
{
    tot_num_drinks = number;
    return self;
}

- (int) get_tot_num_drinks;
{
    return tot_num_drinks;
}

- (double) get_time_interval
{
    return time_interval;
}

- (id) set_total_num_alc_oz: (double) my_drink_alc_content witharg2: (double) my_drink_size;
{
    double standard_size;
    
    standard_size = my_drink_size;
    
    total_num_alc_oz += standard_size * drink_alc_content;
    return self;
}

- (double) get_total_num_alc_oz
{
    return total_num_alc_oz;
}

- (double) calculate_bac: (double) tot_alc_oz witharg2: (double) weight witharg3: (NSString*) gender witharg4: (NSDate*) starttime;
{
    double distr_ratio;
    if([gender isEqualToString:@"male"])
    {
        distr_ratio = .73;
    }
    else if([gender isEqualToString:@"female"])
    {
        distr_ratio = .66;
    }
    double bac;
    NSDate *present = [NSDate date];
    double timeInterval = [starttime timeIntervalSinceDate:present];
    bac = (tot_alc_oz * 5.14/weight * distr_ratio) - .015 * timeInterval;
    return bac;
}

- (void) do_everything: (Drink*) my_drink;

{
    [self set_total_num_alc_oz:[my_drink get_ac] witharg2:[my_drink get_size]];
    //[self calculate_bac:[self get_total_num_alc_oz] witharg2:weight witharg3:gender witharg4:start_date];
}

- (void) add_drink: (Drink*) my_drink;
{
    [running_drink_list addObject:my_drink];
    tot_num_drinks++;
}

- (void) delete_drink: (int) index;
{
    [running_drink_list removeObjectAtIndex:index];
    tot_num_drinks = tot_num_drinks - 1;
}




@end
