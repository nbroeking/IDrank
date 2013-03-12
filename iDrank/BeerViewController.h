//
//  BeerViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/24/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink.h"
#import <CoreLocation/CoreLocation.h>

@interface BeerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *Background;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UIButton *twelveButton;
@property (strong, nonatomic) IBOutlet UIButton *twentyFourButton;
@property (strong, nonatomic) IBOutlet UIButton *fortyButton;
@property (strong, nonatomic) IBOutlet UILabel *alcoholContent;
@property (strong, nonatomic) IBOutlet UILabel *alcoholContentLabel;
@property (strong, nonatomic) IBOutlet UISlider *alcoholContentSlider;
@property (strong, nonatomic) Drink *beerDrink;
@property (strong, nonatomic) IBOutlet UIButton *drinkButton;
@property (strong, nonatomic) IBOutlet NSArray *pickerDrinks;
@property (strong, nonatomic) IBOutlet NSArray *pickerAc;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *locationMeasurements;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;


-(IBAction)setOunce:(id) sender;
-(void)updateSlider;
- (IBAction)drink:(id)sender;
- (void)flipButton:(UIButton*)sender;

@end
