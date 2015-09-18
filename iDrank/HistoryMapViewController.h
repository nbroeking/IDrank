//
//  HistoryMapViewController.h
//  iDrank
//
//  Created by Nick Evans on 12/13/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface HistoryMapViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) NSIndexPath *index;
@property (strong, nonatomic) NSMutableArray *drinkNameArray;
@property long didViewDidLoad;
@property (strong, nonatomic) NSMutableArray* buttons;







-(void) snapToMe: (id)sender;
-(void) snapToDrinks: (id)sender;




-(void)drinkName: (long)i witharg2: (NSMutableArray*)drinkName;

@end
