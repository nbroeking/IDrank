//
//  Stat.h
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drink.h"
#import "Information.h"

@interface Stat : NSObject
@property double drink_alc_content;
@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) NSDate* start_time;
@property (strong, nonatomic) NSDate* time_prev_drink;
@property double time_interval;
@property double total_num_alc_oz;
@property (strong, nonatomic) NSMutableArray* running_drink_list;
@property (strong, nonatomic) NSString* user_gender;
@property double user_weight;
@property int tot_num_drinks;
@property BOOL night_is_started;


- (id) init;
- (id) set_drink_alc_content: (double) drink_ac;
- (id) set_type: (NSString*) drink_type;
- (id) set_time_prev_drink: (NSDate*) time;
- (id) set_time_interval:(NSDate *)first_time witharg2: (NSDate *) second_time;
- (id) set_total_num_alc_oz: (double) my_drink_alc_content witharg2: (double) my_drink_size;
- (id) set_running_drink_list: (NSMutableArray*) my_list;
- (id) set_tot_num_drinks: (int) number;
- (id) set_night_is_started: (BOOL) bit;
- (double) get_drink_alc_content;
- (NSString*) get_type;
- (NSDate*) get_start_time;
- (NSDate*) get_time_prev_drink;
- (double) get_time_interval;
- (double) get_total_num_alc_oz;
- (NSMutableArray*) get_running_drink_list;
- (int) get_tot_num_drinks;
- (BOOL) get_night_is_started;
- (double) calculate_bac: (double) tot_alc_oz witharg2: (double) weight witharg3: (NSString*)gender witharg4: (NSDate*) time;
- (void) add_drink: (Drink*) my_drink;
- (void) delete_drink: (int) index;
- (void) do_everything: (Drink*) my_drink;

@end
