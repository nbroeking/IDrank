//
//  MapDrinkViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 12/12/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "HistoryDrinkMapViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "Annotation.h"
#import <CoreLocation/CoreLocation.h>

@interface HistoryDrinkMapViewController ()

@end

@implementation HistoryDrinkMapViewController
@synthesize drink_location, mapView, didViewDidLoad, drinkToShow, drink_string, toolBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView.delegate = self;
    didViewDidLoad = 2;
    mapView.mapType = MKMapTypeHybrid;
    mapView.showsUserLocation = YES;
    UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]initWithTitle: @"Toggle Views" style:UIBarButtonItemStyleBordered target: self action:@selector(changeMapType:)];
    UIBarButtonItem *typeButton4 = [[UIBarButtonItem alloc]initWithTitle: @"Your Drink" style:UIBarButtonItemStyleBordered target: self action:@selector(snapToDrink:)];
    UIBarButtonItem *typeButton5 = [[UIBarButtonItem alloc]initWithTitle: @"Find Me!" style:UIBarButtonItemStyleBordered target: self action:@selector(snapToMe:)];
    NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, typeButton4,typeButton5, nil];
    toolBar.items = buttons;
    double lat, longi;
    [self.view addSubview:mapView];
    {
        [self drinkName];
        CLLocation* this_drink_location = [[self drinkToShow]get_drink_location];
        lat = this_drink_location.coordinate.latitude;
        longi = this_drink_location.coordinate.longitude;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, longi);
        NSString* time = [drinkToShow get_time_drank_string];
        Annotation* pin_annotaion = [[Annotation alloc]initWithCoordinates:coordinate :drink_string :time];
        [mapView addAnnotation:pin_annotaion];
    }
    
}


- (void)mapView:(MKMapView *)mapView2 didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(didViewDidLoad == 0)
    {
        NSLog(@"find the pin");
        mapView.showsUserLocation = NO;
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = .005;
        span.longitudeDelta = .005;
        CLLocationCoordinate2D location;
        location.latitude = [drinkToShow get_drink_location].coordinate.latitude;
        location.longitude = [drinkToShow get_drink_location].coordinate.longitude;
        region.span = span;
        region.center = location;
        [mapView setRegion:region animated:YES];
        didViewDidLoad = 100;
        [mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];
        
    }
    else if(didViewDidLoad == 1)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([userLocation coordinate], 600, 600);
        [mapView setRegion:region animated:YES];
        didViewDidLoad = 100;
        
        
    }
    else if(didViewDidLoad == 2)
    {
        mapView.showsUserLocation = NO;
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        CLLocationCoordinate2D location;
        location.latitude = [drinkToShow get_drink_location].coordinate.latitude;
        location.longitude = [drinkToShow get_drink_location].coordinate.longitude;
        region.span = span;
        region.center = location;
        [mapView setRegion:region animated:NO];
        didViewDidLoad = 100;
        [mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];
        
    }
}


- (void) changeMapType: (id)sender
{
    if(mapView.mapType == MKMapTypeSatellite)
        mapView.mapType = MKMapTypeHybrid;
    else if(mapView.mapType == MKMapTypeHybrid)
        mapView.mapType = MKMapTypeStandard;
    else
        mapView.mapType = MKMapTypeSatellite;
}


-(void) snapToMe: (id)sender
{
    if((mapView.centerCoordinate.latitude != mapView.userLocation.coordinate.latitude) && (mapView.centerCoordinate.longitude != mapView.userLocation.coordinate.longitude))
    {
        mapView.showsUserLocation = NO;
        didViewDidLoad = 1;
        mapView.showsUserLocation = YES;
    }
}

-(void) snapToDrink: (id)sender
{
    if((mapView.centerCoordinate.latitude != drinkToShow.drink_location.coordinate.latitude) && (mapView.centerCoordinate.longitude != drinkToShow.drink_location.coordinate.longitude))
    {
        mapView.showsUserLocation = NO;
        didViewDidLoad = 0;
        mapView.showsUserLocation = YES;
    }
}

-(void)drinkName
{
    
    if ([[[self drinkToShow] get_name] isEqualToString: @"beer"])
    {
        if([[[self drinkToShow] get_type] isEqualToString: @"Light"] || [[[self drinkToShow] get_type] isEqualToString: @"Regular"] || [[[self drinkToShow] get_type]isEqualToString: @"Malt"])
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@""%@""%@",[[self drinkToShow] get_size],@"oz",@" ",[[self drinkToShow] get_type], @" ", [[self drinkToShow] get_name]];
            drink_string = display;
        }
        else
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[self drinkToShow] get_size],@"oz",@" ",[[self drinkToShow] get_type]];
            drink_string = display;
            
        }
    }
    
    //If it is Bottle of wine, 'Bottle of' is appended. Otherwise 'Glass of' is appended
    
    else if([[[self drinkToShow] get_name] isEqualToString: @"wine"])
    {
        if([[self drinkToShow] get_size] == 25.36)
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Bottle of ", [[self drinkToShow] get_type]];
            drink_string = display;
            
        }
        else
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Glass of ", [[self drinkToShow] get_type]];
            drink_string = display;
        }
    }
    /*If Liquor is selected, then it is either a Shot, and the word 'Shot' is appended, or it is a mixed drink, and nothing
     is appended. In the case where the user takes more than one shot, then the number of shots is included and 'Shots' is in
     its plural form*/
    else if([[[self drinkToShow] get_name] isEqualToString: @"liquor"])
    {
        if([[self drinkToShow]get_mixed_drink_bit]==FALSE)
        {
            if ([[self drinkToShow] get_size] > 1.5)
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[self drinkToShow]get_size]/1.5,@" ", [[self drinkToShow] get_type], @" Shots"];
                drink_string = display;
                
            }
            else
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", [[self drinkToShow] get_type], @" Shot"];
                drink_string = display;
                
            }
        }
        else if([[self drinkToShow]get_mixed_drink_bit]==TRUE)
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@", [[self drinkToShow] get_type]];
            drink_string = display;
            
        }
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView2 viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    
    MKAnnotationView* annotationView = nil;
	if([annotation isKindOfClass:[Annotation class]])
	{
        
		// determine the type of annotation, and produce the correct type of annotation view for it.
		Annotation* csAnnotation = (Annotation*)annotation;
        
        NSString* identifier = @"Pin";
        MKPinAnnotationView* pin = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(nil == pin)
        {
            
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:csAnnotation reuseIdentifier:identifier];
        }
        
        pin.pinColor = MKPinAnnotationColorRed;
        
        annotationView = pin;
		
		[annotationView setEnabled:YES];
		[annotationView setCanShowCallout:YES];
        [annotationView setSelected:YES animated:YES];
        
	}
	
	return annotationView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)stopUpdatingLocation:(NSString *)state
{
    
}
- (void)displayMap
{
    
}
-(void)reset
{
    
}

@end

