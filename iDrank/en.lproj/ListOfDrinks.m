//
//  ListOfDrinks.m
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "ListOfDrinks.h"
#import "Drink.h"

@implementation ListOfDrinks
@synthesize drink_list;
@synthesize drink;

-(id) init
{
    drink_list = [[[NSMutableArray alloc] init];
    return self;
}

- (id) set_drink_list:(NSMutableArray *)drink_list_value
{
    drink_list =[[NSMutableArray alloc] initWithArray:drink_list_value];
    return self;
}

- (NSMutableArray*) get_drink_list
{
    return drink_list;
}

- (void) add_drink: (Drink*) drink
{
    [drink_list addObject:drink];
}

- (void) remove_drink:(int) index
{
    [drink_list removeObjectAtIndex:index];
}

- (Drink*) search_drinks: (NSString*) drink_name;
{
    for(int i = 0; i < sizeof drink_list; i++)
    {
        if([])
    }
}


@end
