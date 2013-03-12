//
//  ListOfDrinks.m
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//
/*
 
 The overall goal of this class is to create a standard and default list of drinks that come preinstalled on the app.
 
 */
#import "ListOfDrinks.h"

@implementation ListOfDrinks
@synthesize drink_list;

-(id) init
{
    self = [super init];
    
    drink_list = [[NSMutableArray alloc] init];
    return self;
}

//SETTERS
- (id) set_drink_list:(NSMutableArray *)drink_list_value
{
    drink_list = [[NSMutableArray alloc] initWithArray:drink_list_value];
    return self;
}
//GETTERS
- (NSMutableArray*) get_drink_list
{
    return drink_list;
}
//METHODS

/*Adds a drink from the ListOfDrinks. The function takes a Drink* object as an argument*/
- (void) add_drink: (Drink*) drink
{
    [drink_list addObject:drink];
}

/*Removes a drink from the ListOfDrinks. The function takes an index as an argument so as to know which drink to delete from the list.*/
- (void) remove_drink:(int) index
{
    [drink_list removeObjectAtIndex:index];
}

/*This method removes a drink specified by the type passed into the method, instead of the index.*/
- (void) removeDrinkByType:(NSString*) type
{
    bool removed = false;
    for (int i =0; i<[drink_list count]; i++)
    {
        if ([[[drink_list objectAtIndex:i] get_type] isEqualToString:type])
        {
            [drink_list removeObjectAtIndex:i];
            removed = true;
        }
    }
}

/*This method checks the ListOfDrinks to see if a drink already exists with the same name. If so, the function returns true, 
 otherwise it returns false.*/
- (bool) isDrinkWithDuplicateType:(NSString*) type
{
    for (int i =0; i<[drink_list count]; i++)
    {
        if ([[[drink_list objectAtIndex:i] get_type] isEqualToString:type])
        {
            return true;
        }
    }
    return false;
}

/*This method checks the ListOfDrinks to see if an existing drink has the same class(ex. Light)*/
- (bool) isDrinkWithName:(NSString*) name
{
    for (int i =0; i<[drink_list count]; i++)
    {
        if ([[[drink_list objectAtIndex:i] get_name] isEqualToString:name])
        {
            return true;
        }
    }
    return false;
}

/*This method checks every drink in ListOfDrinks to see if it is a mixed drink or not.*/
- (bool) isMixedDrinkThere
{
    for (int i =0; i<[drink_list count]; i++)
    {
        if ([[drink_list objectAtIndex:i] get_mixed_drink_bit])
        {
            return true;
        }
    }
    return false;
}

/*This methods checks every drink in ListOfDrinks to see if it is straight liquor. It returns a bool.*/
- (bool) areShotsThere
{
    for (int i =0; i<[drink_list count]; i++)
    {
        if ((([[drink_list objectAtIndex:i] get_mixed_drink_bit] == false) &&([[[drink_list objectAtIndex:i] get_name] isEqualToString:@"liquor"])))
        {
            return true;
        }
    }
    return false;
}

/*This method is called anytime the user Resets their DrinkList. Also, the app comes preloaded with these drinks*/
-(IBAction)resetDrinkList:(id)sender
{
    // THis resets the drink list variable by variable
    drink_list = [NSMutableArray arrayWithObjects: 
    [[Drink alloc] init:@"liquor" witharg2:@"Vodka" witharg3:40],
    [[Drink alloc] init:@"liquor" witharg2:@"Whiskey" witharg3:40],
    [[Drink alloc] init:@"liquor" witharg2:@"Rum" witharg3:40],
    [[Drink alloc] init:@"liquor" witharg2:@"Tequila" witharg3:40],
    [[Drink alloc] init:@"liquor" witharg2:@"Gin" witharg3:37.5],
    [[Drink alloc] init:@"liquor" witharg2:@"Bourbon" witharg3:50],
    [[Drink alloc] init:@"liquor" witharg2:@"Brandy" witharg3:40],
    [[Drink alloc] init:@"liquor" witharg2:@"Grain Alcohol" witharg3:95],
    [[Drink alloc] init:@"liquor" witharg2:@"Liqueur" witharg3:20],
    
    [[Drink alloc] init:@"beer" witharg2:@"Light" witharg3:4.2],
    [[Drink alloc] init:@"beer" witharg2:@"Regular" witharg3:5.5],
    [[Drink alloc] init:@"beer" witharg2:@"Malt" witharg3:7],
    
    [[Drink alloc] init:@"wine" witharg2:@"Merlot" witharg3:11.5],
    [[Drink alloc] init:@"wine" witharg2:@"Shiraz" witharg3:12],
    [[Drink alloc] init:@"wine" witharg2:@"Cabernet Sauvignon" witharg3:12.5],
    [[Drink alloc] init:@"wine" witharg2:@"Pinot Noir" witharg3:12.5],
    [[Drink alloc] init:@"wine" witharg2:@"Chardonnay" witharg3:11],
    [[Drink alloc] init:@"wine" witharg2:@"Sauvignon Blanc" witharg3:11],
    [[Drink alloc] init:@"wine" witharg2:@"Riesling" witharg3:11],
    [[Drink alloc] init:@"wine" witharg2:@"Zinfandel" witharg3:20],
                  
                  
    [[Drink alloc] init:@"liquor" witharg2:@"Gin and Tonic" witharg3:37.5 witharg4:TRUE],
    [[Drink alloc] init:@"liquor" witharg2:@"Whiskey and Coke" witharg3:40 witharg4:TRUE],
    [[Drink alloc] init:@"liquor" witharg2:@"Screwdriver" witharg3:40 witharg4:TRUE],
    [[Drink alloc] init:@"liquor" witharg2:@"Martini" witharg3:37.5 witharg4:TRUE],
    [[Drink alloc] init:@"liquor" witharg2:@"Mojito" witharg3:40 witharg4:TRUE],
    [[Drink alloc] init:@"liquor" witharg2:@"Margarita" witharg3:40 witharg4:TRUE],
    [[Drink alloc] init:@"liquor" witharg2:@"Long Island" witharg3:40 witharg4:TRUE],
    [[Drink alloc] init:@"liquor" witharg2:@"White Russian" witharg3:40 witharg4:TRUE],

                  
    
    nil];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    // This is how the list of drink objects initializes when loaded from file
    self = [super init];
    
    [self setDrink_list:[[aDecoder decodeObjectForKey:@"drinkListCode"] mutableCopy]];
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    // Saves the object
    [aCoder encodeObject:drink_list forKey:@"drinkListCode"];
}
-(NSString*) archivePath
{
    // Finds the archivePath
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [ directories objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"DrinkList.bin"];
}
-(void) saveData
{
    // Writes to file
    [NSKeyedArchiver archiveRootObject:self toFile: [self archivePath]];
}


@end

