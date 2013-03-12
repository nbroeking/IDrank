//
//  ViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/19/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *Start_Button;
@property (strong, nonatomic) IBOutlet UIButton *Settings_button;

@property (strong, nonatomic) IBOutlet UIButton *Credits_Button;
@property (strong, nonatomic) IBOutlet UIButton *Help_buttom;
@property (strong, nonatomic) IBOutlet UIImageView *Background;
@property (strong, nonatomic) UITextView *yolo;

@property (strong, nonatomic) IBOutlet UILabel *Title;

-(void) getInformationFromCurrentNight;


@end
