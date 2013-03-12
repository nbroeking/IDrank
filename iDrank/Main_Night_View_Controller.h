//
//  Main_Night_View_Controller.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/21/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Main_Night_View_Controller : UIViewController

// This is the view for the main night page
@property (strong, nonatomic) IBOutlet UIImageView *background_image;
@property (strong, nonatomic) IBOutlet UIButton *Stat_button;
@property (strong, nonatomic) IBOutlet UIButton *End_my_night_button;
@property (strong, nonatomic) IBOutlet UIButton *beerButton;
@property (strong, nonatomic) IBOutlet UIButton *hardLiquorButton;
@property (strong, nonatomic) IBOutlet UIButton *wineButton;



-(IBAction)endNight:(id)sender;



@end
