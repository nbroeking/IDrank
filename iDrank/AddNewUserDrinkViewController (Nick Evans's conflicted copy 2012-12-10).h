//
//  AddNewUserDrinkViewController.h
//  iDrank
//
//  Created by Nick Evans on 12/10/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewUserDrinkViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSString* userEnteredName;
@property (strong, nonatomic) NSString* drinkClass;
@property double drinkAC;
@property BOOL isMixedDrinkBit;



@end
