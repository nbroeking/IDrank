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
@property double time_longerval;
@property double total_num_alc_oz;
@property (strong, nonatomic) NSMutableArray* running_drink_list;
@property long user_gender;
@property long user_weight;
@property long user_age;
@property BOOL location;
@property long tot_num_drinks;
@property BOOL night_is_started;
@property double bac;
@property NSString* start_time_string;
@property NSString* time_prev_drink_string;
@property NSMutableArray* bac_array;

//SETTERS
- (id) init;
- (id) set_drink_alc_content: (double) drink_ac;
- (id) set_type: (NSString*) drink_type;
- (id) set_time_prev_drink: (NSDate*) time;
- (id) set_time_longerval:(NSDate *)first_time witharg2: (NSDate *) second_time;
- (id) set_total_num_alc_oz: (double) my_drink_alc_content witharg2: (double) my_drink_size2;
- (id) set_num_alc_oz: (double) oz;
- (id) set_running_drink_list: (NSMutableArray*) my_list;
- (id) set_tot_num_drinks: (long) number;
- (id) set_night_is_started: (BOOL) bit;
- (id) set_bac: (double) my_bac;
- (id) set_start_time: (NSDate*) my_start_time;
- (id) set_start_time_string: (NSString*) my_time;
- (id) set_time_prev_drink_string: (NSString*) my_time;
//- (id) set_mixed_drink_bit: (BOOL) bit;
//- (id) set_bottle_bit: (BOOL) bit;
- (id) set_bac_array: (NSMutableArray*) my_bac_array;
- (id) set_user_weight: (long) weight;
- (id) set_user_gender: (long) gender;

//GETTERS
- (double) get_bac;
- (double) get_drink_alc_content;
- (NSString*) get_type;
- (NSDate*) get_start_time;
- (NSDate*) get_time_prev_drink;
- (double) get_time_longerval;
- (double) get_total_num_alc_oz;
- (NSMutableArray*) get_running_drink_list;
- (long) get_tot_num_drinks;
- (BOOL) get_night_is_started;
- (NSString*) get_start_time_string;
- (NSString*) get_time_prev_drink_string;
//- (BOOL) get_mixed_drink_bit;
//- (BOOL) get_bottle_bit;
- (NSMutableArray*) get_bac_array;
- (long) get_user_weight;
- (long) get_user_gender;

//METHODS
- (double) calculate_bac: (double) tot_alc_oz witharg2: (long) weight witharg3: (long)gender witharg4: (NSDate*) time;
- (double) calc_small_bac: (double) tot_alc_oz witharg2: (long) weight witharg3: (long)gender witharg4: (NSDate*) start_time2 witharg5: (NSDate*) current_time;
- (void) recalculate_bac;
- (void) convert_start_time;
- (void) convert_prev_time;
- (void) do_everything: (Drink*) my_drink;
- (void) add_drink: (Drink*) my_drink;
- (void) delete_drink: (long) index;
- (void) calculate_num_drinks: (Drink*) my_drink;
- (void) add_bac: (double) my_bac;
- (void) reset_bac_array;
- (double) calculate_highest_BAC;

//Added by nic so we can save data in the middle of the night.
-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(NSString*) archivePath;
-(void) saveData;
-(void) loadData;

@end
