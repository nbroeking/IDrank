//
//  Annotation.m
//  iDrank
//
//  Created by Nick Evans on 12/4/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

//Synthesizing variables declared in the .h file
@synthesize title;
@synthesize subtitle;
@synthesize coordinate;

/*
 initWithCoordinates() takes in the location of the drink, the drink name (ex. Whiskey), and the time the drink was drunk.
 The function loads the arguments into the variables synthesized above
 */
- (id) initWithCoordinates:(CLLocationCoordinate2D)location :(NSString *)drink_name :(NSString *)time_drank
{
    self = [super init]; 
    coordinate = location;
    title = drink_name;
    subtitle = time_drank;
    return self;
}

/*
 Getters for the variables synthesized above. These will be used to create the callout for a pin in the mapView. 
 */
-(NSString*)get_title {return title;}
-(NSString*)get_subtitle{return subtitle;}



@end
