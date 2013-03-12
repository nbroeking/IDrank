//
//  Annotation.h
//  iDrank
//
//  Created by Nick Evans on 12/4/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

// Creating the title, subtitle, and the coordinate of the annotation going on the map 
@property (retain, nonatomic)NSString* title;
@property (retain, nonatomic)NSString* subtitle;
@property (readonly, nonatomic)CLLocationCoordinate2D coordinate;

// Init and getters for the properties
- (id)initWithCoordinates: (CLLocationCoordinate2D)location : (NSString*)drink_name : (NSString*)time_drank;
- (NSString*)get_title;
- (NSString*)get_subtitle;

@end