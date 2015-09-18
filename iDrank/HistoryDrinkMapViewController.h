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

@interface HistoryDrinkMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) CLLocation* drink_location;
@property long didViewDidLoad;
@property (strong, nonatomic) Drink* drinkToShow;
@property (strong, nonatomic) NSString* drink_string;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

@end
