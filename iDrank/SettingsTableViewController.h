//
//  SettingsTableViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 12/3/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>

// This is the settings view controller
@interface SettingsTableViewController : UITableViewController < UITextFieldDelegate >
@property (strong, nonatomic) NSMutableArray *personalMenu;
@property (strong, nonatomic) NSMutableArray *genderMenu;
@property (strong, nonatomic) NSMutableArray *otherMenu;

@property (strong, nonatomic) NSMutableArray *DrinkMenu;
@property (strong, nonatomic) NSMutableArray *nightMenu;
@property (strong, nonatomic) UITextField *weightField;
@property (strong, nonatomic) UITextField *ageField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

-(IBAction)loadData:(id)sender;
@end
