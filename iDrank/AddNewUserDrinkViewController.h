//
//  AddNewUserDrinkViewController.h
//  iDrank
//
//  Created by Nick Evans on 12/10/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//


// This is the class responsible for the viewcontroller for the form to add a new drink

#import <UIKit/UIKit.h>
#import "Drink.h"

@interface AddNewUserDrinkViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (strong, nonatomic) NSString* userEnteredName;
@property (strong, nonatomic) NSString* drinkClass;
@property double drinkAC;
@property bool isMixedDrink;
@property (strong, nonatomic) UITextField* nameField;
@property (strong, nonatomic) UISlider* acSlider;
@property (strong, nonatomic) UISwitch* mixedDrinkSwitch;
@property (strong, nonatomic) NSString* display;
@property (strong, nonatomic) Drink* drinkToAdd;



-(void)dismissKeyboard;
-(void)addToList:(Drink*) newDrink;
-(void)sliderChanged;
@end
