//
//  HardLiquorViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 10/24/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink.h"
#import "Main_Navigation_View_Controller.h"

@interface HardLiquorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *drinkButton;
@property (strong, nonatomic) IBOutlet UILabel *proofLabel;
@property (strong, nonatomic) IBOutlet UILabel *proof;
@property (strong, nonatomic) IBOutlet UILabel *abvLabel;
@property (strong, nonatomic) IBOutlet UILabel *abv;
@property (strong, nonatomic) IBOutlet UISlider *pslider;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UIButton *shotButton;
@property (strong, nonatomic) IBOutlet UIButton *mixedDrinkButton;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UILabel *shotsLabel;
@property (strong, nonatomic) IBOutlet UILabel *shots;
@property (strong, nonatomic) IBOutlet NSArray *pickerDrinks;
@property (strong, nonatomic) IBOutlet NSArray *pickerAc;
@property (strong, nonatomic) Drink *liqourDrink;
@property (strong, nonatomic) IBOutlet UIImageView *liquorImage;
@property (strong, nonatomic) NSMutableArray* mixedDrinkArray1;
@property (strong, nonatomic)NSMutableArray* mixedDrinkArray2;
@property (strong, nonatomic)NSMutableArray* shotDrinkArray1;
@property (strong, nonatomic)NSMutableArray* shotDrinkArray2;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *locationMeasurements;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;
@property int shotCount;
@property (strong, nonatomic) IBOutlet UIView *pickerView;

- (IBAction)step:(id)sender;
- (IBAction)changePickerShot:(id)sender;
- (IBAction)changePickerMixed:(id)sender;

- (IBAction)drink:(id)sender;
-(IBAction)setOz:(id)sender;
@end
