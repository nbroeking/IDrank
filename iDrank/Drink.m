//
//  Drink.m
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "Drink.h"

@implementation Drink
@synthesize name;
@synthesize type;
@synthesize alc_content;
@synthesize size;
@synthesize mixed_drink_bit;
@synthesize bottle_bit;
@synthesize time_drank;
@synthesize time_drank_string;
@synthesize drink_location;


/*Initializind the Drink object with the class (ex Beer), the type (ex Keystone), and the alcohol content*/
-(id) init: (NSString*) new_name witharg2: (NSString*) new_type witharg3: (double) ac
{
    name = new_name;
    type = new_type;
    alc_content = ac;
    mixed_drink_bit = FALSE; 
    bottle_bit = FALSE;
    return self;
}

/*Another init method to be called when a mixed drink needs to be initialized.*/
-(id) init: (NSString*) new_name witharg2: (NSString*) new_type witharg3: (double) ac witharg4: (BOOL)isMixedDrink
{
    name = new_name;
    type = new_type;
    alc_content = ac;
    mixed_drink_bit = isMixedDrink;
    bottle_bit = FALSE;
    return self;
}

//GETTERS

- (double) get_size{return size;}
- (NSString*) get_name{return name;}
- (NSString*) get_type{return type;}
- (double) get_ac{return alc_content;}
- (BOOL) get_mixed_drink_bit {return mixed_drink_bit;}
- (BOOL) get_bottle_bit {return bottle_bit;}
- (NSString*) get_time_drank_string {return time_drank_string;}
- (NSDate*) get_time_drank {return time_drank;}
- (CLLocation*) get_drink_location {return drink_location;}


//SETTERS

- (id) set_drink_location:(CLLocation *)location
{
    drink_location = location;
    return self;
}

- (id) set_time_drank: (NSDate*) time
{
    time_drank = time;
    [self convert_time];
    return self;
}

- (id) set_time_drank_string:(NSString *) time_string
{
    time_drank_string = time_string;
    return self;
}

- (id) set_mixed_drink_bit:(BOOL)bit
{
    mixed_drink_bit = bit;
    return self;
}

- (id) set_bottle_bit:(BOOL)bit
{
    bottle_bit = bit;
    return self;
}

- (id) set_size: (double) drink_size;
{
    size = drink_size;
    return self;
}


- (id) set_name: (NSString*) new_name;
{
    name = new_name;
    return self;
}

- (id) set_type: (NSString*) new_type;
{
    type = new_type;
    return self;
}

- (id) set_ac: (double) ac;
{
    alc_content = ac;
    return self;
}

//METHODS

/*This method edit's the current Drink object*/
- (void) edit_drink: (NSString*) new_name witharg2: (NSString*) new_type witharg3: (double) new_ac;
{
    name = new_name;
    type = new_type;
    alc_content = new_ac;
}

/*This method takes the NSDate* time_drank member variable and converts it to a NSString* and places
 the result in another member varible*/
- (void) convert_time
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"hh:mm a"];
    
    NSString *dateString = [format stringFromDate:time_drank];
    [self set_time_drank_string:dateString];
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    // THis method inits the object when the object is loaded
   if(self = [super init])
   {
       [self set_name:[aDecoder decodeObjectForKey:@"nameCode"]];
       [self set_type:[aDecoder decodeObjectForKey:@"typeCode"]];
       [self set_ac:[aDecoder decodeDoubleForKey:@"acCode"]];
       [self set_size:[aDecoder decodeDoubleForKey:@"sizeCode"]];
       [self set_mixed_drink_bit:[aDecoder decodeBoolForKey:@"mdBitCode"]];
       [self set_bottle_bit:[aDecoder decodeBoolForKey:@"bottleBitCode"]];
       [self set_time_drank_string:[aDecoder decodeObjectForKey:@"timeDrankStringCode"]];
       [self set_time_drank:[aDecoder decodeObjectForKey:@"timeDrankCode"]];
       [self set_drink_location:[aDecoder decodeObjectForKey:@"drinkLocationCode"]];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    // This method encodes the object when written to file
    [aCoder encodeObject:name forKey:@"nameCode"];
    [aCoder encodeObject:type forKey:@"typeCode"];
    [aCoder encodeDouble:alc_content forKey:@"acCode"];
    [aCoder encodeDouble:size forKey:@"sizeCode"];
    [aCoder encodeBool:mixed_drink_bit forKey:@"mdBitCode"];
    [aCoder encodeBool:bottle_bit forKey:@"bottleBitCode"];
    [aCoder encodeObject:time_drank_string forKey:@"timeDrankStringCode"];
    [aCoder encodeObject:time_drank forKey:@"timeDrankCode"];
    [aCoder encodeObject:drink_location forKey:@"drinkLocationCode"];
}
-(NSString*) archivePath
{
    // This is the drink archive path
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [ directories objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"DrinkData.bin"];
}





@end
