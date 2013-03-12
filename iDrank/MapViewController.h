//
//  MapViewController.h
//  iDrank
//
//  Created by Nick Evans on 12/4/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) NSMutableArray *drinkNameArray;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property int didViewDidLoad;



- (void)stopUpdatingLocation:(NSString *)state;
- (void)displayMap;
-(void)reset;
//- (void) changeMapType: (id)sender : (int)bit;

-(void)drinkName: (int)i witharg2: (NSMutableArray*)drinkName;

@end


