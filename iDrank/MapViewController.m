//
//  MapViewController.m
//  iDrank
//
//  Created by Nick Evans on 12/4/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "MapViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "Annotation.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView;
@synthesize drinkNameArray;
@synthesize toolBar;
@synthesize didViewDidLoad;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*This view controller displays the map the user clicks on to view all of his/her drinks for the night. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView.delegate = self;
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    mapView.mapType = MKMapTypeHybrid;
    UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]initWithTitle: @"Toggle Views" style:UIBarButtonItemStyleBordered target: self action:@selector(changeMapType:)];
    UIBarButtonItem *typeButton4 = [[UIBarButtonItem alloc]initWithTitle: @"Find Me!" style:UIBarButtonItemStyleBordered target: self action:@selector(snapToMe:)];
    NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, typeButton4, nil];
    toolBar.items = buttons;
    mapView.showsUserLocation = YES;

    drinkNameArray = [[NSMutableArray alloc]init];
    int size = [[[navP getStat]get_running_drink_list] count];
    double lat, longi;
    [self.view addSubview:mapView];
    if([[navP getStat]get_tot_num_drinks] > 0)
    {
        for(int i = 0; i < size; i++)
        {
            [self drinkName:i witharg2:drinkNameArray];
            CLLocation* drink_location = [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_drink_location];
            lat = drink_location.coordinate.latitude;
            longi = drink_location.coordinate.longitude;
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, longi);
            NSString* drink = [[self drinkNameArray]objectAtIndex:i];
            NSString* time = [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_time_drank_string];
            Annotation* pin_annotaion = [[Annotation alloc]initWithCoordinates:coordinate :drink :time];
            [mapView addAnnotation:pin_annotaion];
        }
    }
}

/*this method gets called to snap to pin and user locations*/
- (void)mapView:(MKMapView *)mapView2 didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(didViewDidLoad != 1)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([userLocation coordinate], 200, 200);
        [mapView setRegion:region animated:YES];
        didViewDidLoad = 1;
    }
    
}

/*This method is called when the user selects the Toggle Map button. It toggles the map between the different map views*/
- (void) changeMapType: (id)sender
{
    if(mapView.mapType == MKMapTypeSatellite)
        mapView.mapType = MKMapTypeHybrid;
    else if(mapView.mapType == MKMapTypeHybrid)
        mapView.mapType = MKMapTypeStandard;
        else
            mapView.mapType = MKMapTypeSatellite;
}

/*This method gets called when the user selects the Find Me! button*/
-(void) snapToMe: (id)sender
{
    mapView.showsUserLocation = NO;
    didViewDidLoad = 0;
    mapView.showsUserLocation = YES;
}

/*This method basically creates the callout text for the pin annotation on the map based on what the user drank . */
-(void)drinkName: (int)i witharg2: (NSMutableArray*)drinkName
{
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    if ([[[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"beer"])
    {
        if([[[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Light"] || [[[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Regular"] || [[[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Malt"])
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@""%@""%@",[[[[navP getStat]get_running_drink_list]objectAtIndex:i] get_size],@"oz",@" ",[[[[navP getStat] get_running_drink_list] objectAtIndex:i ] get_type], @" ", [[[[navP getStat] get_running_drink_list] objectAtIndex:i ] get_name]];
            [drinkNameArray addObject:display];
        }
        else
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[[[navP getStat]get_running_drink_list]objectAtIndex:i] get_size],@"oz",@" ",[[[[navP getStat] get_running_drink_list] objectAtIndex:i ] get_type]];
            [drinkNameArray addObject:display];
            
        }
    }
    /*If it is Bottle of wine, 'Bottle of' is appended. Otherwise 'Glass of' is appended*/
    else if([[[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"wine"])
    {
        if([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_size] == 25.36)
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Bottle of ", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type]];
            [drinkNameArray addObject:display];
            
        }
        else
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Glass of ", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type]];
            [drinkNameArray addObject:display];
        }
    }
    /*If Liquor is selected, then it is either a Shot, and the word 'Shot' is appended, or it is a mixed drink, and nothing
     is appended. In the case where the user takes more than one shot, then the number of shots is included and 'Shots' is in
     its plural form*/
    else if([[[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"liquor"])
    {
        if([[[[navP getStat] get_running_drink_list] objectAtIndex:i]get_mixed_drink_bit]==FALSE)
        {
            if ([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_size] > 1.5)
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[[[navP getStat]get_running_drink_list]objectAtIndex:i]get_size]/1.5,@" ", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type], @" Shots"];
                [drinkNameArray addObject:display];
                
            }
            else
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type], @" Shot"];
                [drinkNameArray addObject:display];
                
            }
        }
        else if([[[[navP getStat] get_running_drink_list] objectAtIndex:i]get_mixed_drink_bit]==TRUE)
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type]];
            [drinkNameArray addObject:display];
            
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
