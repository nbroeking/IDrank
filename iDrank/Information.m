//
//  Information.m
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//
// Nic broeking added encoding information
//
#import "Information.h"

@implementation Information
@synthesize gender;
@synthesize weight;
@synthesize age;
@synthesize location;
@synthesize first_log;

- (id) init
{
    self = [super init];
    
    gender = 0;
    weight = 0.0;
    age = 0.0;
    location = false;
    first_log = true;
    return self;
}

//GETTERS
- (int) get_gender{return gender;}
- (int) get_weight{return weight;}

//SETTERS
- (id) set_gender:(int)my_gender
{
    gender = my_gender;
    return self;
}

- (id) set_weight:(int) newWeight
{
    weight = newWeight;
    return self;
}

//METHODS
- (void) edit_information:(int)new_gender witharg2:(double)new_weight
{
    gender = new_gender;
    weight = new_weight;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    // This initializes the object when loaded from file
    self = [super init];
    [self setGender:[aDecoder decodeIntForKey:@"genderCode"]];
    [self setWeight:[aDecoder decodeIntForKey:@"weightCode"]];
    [self setAge:[aDecoder decodeIntForKey:@"ageCode"]];
    [self setLocation:[aDecoder decodeBoolForKey:@"locationCode"]];
    [self setFirst_log:[aDecoder decodeBoolForKey:@"firstLogCode"]];
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    // Encodes the object when written to file
    [aCoder encodeInt:gender forKey:@"genderCode"];
    [aCoder encodeInt:weight forKey:@"weightCode"];
    [aCoder encodeInt:age forKey:@"ageCode"];
    [aCoder encodeBool:location forKey:@"locationCode"];
    [aCoder encodeBool:first_log forKey:@"firstLogCode"];
}

-(NSString*) archivePath
{
    // This is the save path
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [ directories objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"PersonData.bin"];
}
-(void) saveData
{
    //Saves data
    [NSKeyedArchiver archiveRootObject:self toFile: [self archivePath]];
}
-(void) loadData
{
    // Loads the data
    Information *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    if( temp != NULL)
    {
        [self set_weight:[temp get_weight]];
        [self set_gender:[temp get_gender]];
        [self setAge:[temp age]];
        [self setLocation:[temp location]];
        [self setFirst_log:[temp first_log]];
    }
}
@end
