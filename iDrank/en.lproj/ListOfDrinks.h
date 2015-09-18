//
//  ListOfDrinks.h
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drink.h"

@class Drink;
@interface ListOfDrinks : NSObject
{
    Drink *drink;
}
@property (nonatomic, retain) Drink *drink;
@property (strong, nonatomic) NSMutableArray *drink_list;

- (id) init;
- (id) set_drink_list: (NSMutableArray*) drink_list_value;
- (NSMutableArray*) get_drink_list;
- (void) add_drink: (Drink*) drink;
- (void) remove_drink: (int) index;
- (Drink*) search_drinks: (NSString*) drink_name;


@end
