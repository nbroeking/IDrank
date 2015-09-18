//
//  disclamerViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 1/22/13.
//  Copyright (c) 2013 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface disclamerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) IBOutlet UIButton *declineButton;

-(IBAction)accept:(id)sender;
-(IBAction)deny:(id)sender;

@end
