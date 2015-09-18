//
//  DrinkHistoryViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 11/26/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkHistoryViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *drinkNameArray;
@property (strong, nonatomic) NSMutableArray *drinkDetailArray;
@property (strong, nonatomic) NSIndexPath *index;

@end

