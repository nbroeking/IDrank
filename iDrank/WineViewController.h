//
//  WineViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/24/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink.h"
#import <CoreLocation/CoreLocation.h>

@interface WineViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *Background;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UILabel *alcContentLabel;
@property (strong, nonatomic) IBOutlet UILabel *alcContent;
@property (strong, nonatomic) IBOutlet UIButton *bottleButton;
@property (strong, nonatomic) Drink* wineDrink;
@property (strong, nonatomic) IBOutlet UIButton* glassButton;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UIButton *drinkButton;
@property (strong, nonatomic) IBOutlet NSArray *pickerDrinks;
@property (strong, nonatomic) IBOutlet NSArray *pickerAc;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *locationMeasurements;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;

- (void)flipButton:(UIButton*)sender;
- (IBAction)drink:(id)sender;
- (IBAction)setOunce:(id) sender;
-(IBAction)sliderChanged;

@end
