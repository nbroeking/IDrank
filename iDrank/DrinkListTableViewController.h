//
//  DrinkListTableViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 11/12/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapDrinkViewController.h"

@interface DrinkListTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *drinkNameArray;
@property (strong, nonatomic) NSMutableArray *drinkDetailArray;
@property MapDrinkViewController* mapDrinkViewController;

//METHODS
- (void) drinkDetail:(long)index witharg2: (NSMutableArray*) drinkDetail;
-(void)reset_data:(long)index;

@end
