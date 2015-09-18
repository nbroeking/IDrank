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

-(id) init: (NSString*) new_name witharg2: (NSString*) new_type witharg3: (double) ac
{
    name = new_name;
    type = new_type;
    alc_content = ac;
    return self;
}

- (id) set_size: (NSString*) drink_size;
{
    size = drink_size;
    return self;
}

- (NSString*) get_size;
{
    return size;
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

- (NSString*) get_name;
{
    return name;
}

- (NSString*) get_type;
{
    return type;
}

- (double) get_ac;
{
    return alc_content;
}

- (void) edit_drink: (NSString*) new_name witharg2: (NSString*) new_type witharg3: (double) new_ac;
{
    name = new_name;
    type = new_type;
    alc_content = new_ac;
}









@end
