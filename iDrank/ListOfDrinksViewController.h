//
//  ListOfDrinksViewController.h
//  iDrank
//
//  Created by Nick Evans on 11/30/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewUserDrinkViewController.h"
#import "Main_Navigation_View_Controller.h"

@interface ListOfDrinksViewController : UITableViewController 
@property NSMutableArray *beerDrinkNameArray;
@property NSMutableArray *beerDrinkDetailArray;
@property NSMutableArray *beerTypeOnlyArray;

@property NSMutableArray *wineDrinkNameArray;
@property NSMutableArray *wineDrinkDetailArray;
@property NSMutableArray *wineTypeOnlyArray;

@property NSMutableArray *liquorDrinkNameArray;
@property NSMutableArray *liquorDrinkDetailArray;
@property NSMutableArray *liquorTypeOnlyArray;

@property NSMutableArray *mixedDrinkNameArray;
@property NSMutableArray *mixedDrinkDetailArray;
@property NSMutableArray *mixedDrinkTypeOnlyArray;

@property AddNewUserDrinkViewController* addNewUserDrinkViewController;

-(void)prepareTable;
-(void)addDrink:(Drink*)drink;
@end
