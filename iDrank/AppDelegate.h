//
//  AppDelegate.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/19/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Main_Navigation_View_Controller.h"
#import "ViewController.h"


@class Stat;
@class Drink;
@class ListOfDrinks;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Main_Navigation_View_Controller *mainNavController;

@end
