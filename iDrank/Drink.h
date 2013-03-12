//
//  Drink.h
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface Drink : NSObject
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* type;
@property double alc_content;
@property double size;
@property BOOL mixed_drink_bit;
@property BOOL bottle_bit;
@property NSString* time_drank_string;
@property NSDate* time_drank;
@property CLLocation* drink_location;



- (id) init: (NSString*) new_name witharg2: (NSString*) new_type witharg3: (double) ac;
-(id) init: (NSString*) new_name witharg2: (NSString*) new_type witharg3: (double) ac witharg4: (BOOL)isMixedDrink;


//SETTERS
- (id) set_name: (NSString*) new_name;
- (id) set_type: (NSString*) new_type;
- (id) set_ac: (double) ac;
- (id) set_size: (double) drink_size;
- (id) set_mixed_drink_bit: (BOOL) bit;
- (id) set_bottle_bit: (BOOL) bit;
- (id) set_time_drank: (NSDate*) time;
- (id) set_time_drank_string: (NSString*) time_string;
- (id) set_drink_location: (CLLocation*) location;


//GETTERS
- (double) get_size;
- (NSString*) get_name;
- (NSString*) get_type;
- (double) get_ac;
- (BOOL) get_mixed_drink_bit;
- (BOOL) get_bottle_bit;
- (NSString*) get_time_drank_string;
- (NSDate*) get_time_drank;
- (CLLocation*) get_drink_location;


//METHODS
- (void) edit_drink: (NSString*) new_name witharg2: (NSString*) new_type witharg3: (double) new_ac;
- (void) convert_time;

//Saving and Loading
-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(NSString*) archivePath;

@end
