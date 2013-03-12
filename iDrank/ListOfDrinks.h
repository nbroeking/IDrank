//
//  ListOfDrinks.h
//  iDrank
//
//  Created by Nick Evans on 10/22/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drink.h"

@interface ListOfDrinks : NSObject
@property (strong, nonatomic) NSMutableArray *drink_list;

- (id) set_drink_list: (NSMutableArray*) drink_list_value;

- (NSMutableArray*) get_drink_list;

- (void) add_drink: (Drink*) drink;
- (void) remove_drink: (int) index;
- (void) removeDrinkByType:(NSString*) type;
- (bool) isDrinkWithDuplicateType:(NSString*) type;
- (bool) isDrinkWithName:(NSString*) name;
- (bool) isMixedDrinkThere;
- (bool) areShotsThere;
-(IBAction)resetDrinkList:(id)sender;

-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(NSString*) archivePath;
-(void) saveData;

@end
