//
//  MapDrinkViewController.h
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 12/12/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Drink.h"

@interface MapDrinkViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) CLLocation* drink_location;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property int didViewDidLoad;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) Drink* drinkToShow;
@property (strong, nonatomic) NSString* drink_string;

@end
