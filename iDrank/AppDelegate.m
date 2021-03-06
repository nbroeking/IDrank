//
//  AppDelegate.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/19/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Main_Navigation_View_Controller.h"

@implementation AppDelegate
@synthesize mainNavController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    mainNavController = (Main_Navigation_View_Controller*)self.window.rootViewController;
    // Override polong for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary longerruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // Save what screen we were on.
    [mainNavController save_data];
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [mainNavController save_data];  // Save our data
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background
    // Go to correct interface screen
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // Go to correct interface screen
 
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBacground:.
    [mainNavController save_data];
}

@end
