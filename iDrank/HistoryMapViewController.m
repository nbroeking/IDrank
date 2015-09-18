//
//  HistoryMapViewController.m
//  iDrank
//
//  Created by Nick Evans on 12/13/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "HistoryMapViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "Annotation.h"

@interface HistoryMapViewController ()

@end

@implementation HistoryMapViewController

@synthesize mapView, toolBar, index, drinkNameArray, didViewDidLoad, buttons;

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
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;

    [super viewDidLoad];
    mapView.delegate = self;
    mapView.mapType = MKMapTypeHybrid;
    didViewDidLoad = 2;
    mapView.showsUserLocation = YES;
    
    if([[navP night]location] == TRUE)
    {
        UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]initWithTitle: @"Toggle Views" style:UIBarButtonItemStyleBordered target: self action:@selector(changeMapType:)];
        UIBarButtonItem *typeButton4 = [[UIBarButtonItem alloc]initWithTitle: @"Find Me!" style:UIBarButtonItemStyleBordered target: self action:@selector(snapToMe:)];
        UIBarButtonItem *typeButton5 = [[UIBarButtonItem alloc]initWithTitle: @"Show Drinks" style:UIBarButtonItemStyleBordered target: self action:@selector(snapToDrinks:)];
        buttons = [[NSMutableArray alloc] initWithObjects:typeButton, typeButton4, typeButton5, nil];
        
    }
    else if([[navP night]location] == FALSE)
    {
        UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]initWithTitle: @"Toggle Views" style:UIBarButtonItemStyleBordered target: self action:@selector(changeMapType:)];
        UIBarButtonItem *typeButton5 = [[UIBarButtonItem alloc]initWithTitle: @"Show Drinks" style:UIBarButtonItemStyleBordered target: self action:@selector(snapToDrinks:)];
        buttons = [[NSMutableArray alloc] initWithObjects:typeButton, typeButton5, nil];
        
    }
    toolBar.items = buttons;
    //[self updateMap:mapView];
    drinkNameArray = [[NSMutableArray alloc]init];
    long size = [[[[navP historyNights]objectAtIndex:index.row] get_running_drink_list] count];
    double lat2, longi2;
    //[self.view addSubview:mapView];
    if([[[navP historyNights] objectAtIndex:index.row]get_tot_num_drinks] > 0)
    {
        for(long i = 0; i < size; i++)
        {
            [self drinkName:i witharg2:drinkNameArray];
            CLLocation* drink_location = [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_drink_location];
            lat2 = drink_location.coordinate.latitude;
            longi2 = drink_location.coordinate.longitude;
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat2, longi2);
            NSString* drink = [[self drinkNameArray]objectAtIndex:i];
            NSString* time = [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_time_drank_string];
            Annotation* pin_annotaion = [[Annotation alloc]initWithCoordinates:coordinate :drink :time];
            [mapView addAnnotation:pin_annotaion];
        }
    }

}

- (void)mapView:(MKMapView *)mapView2 didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(didViewDidLoad == 0)
    {
        Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
        mapView.showsUserLocation = NO;
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.02;
        span.longitudeDelta = 0.02;
        CLLocationCoordinate2D location;
        location.latitude = [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:0] get_drink_location].coordinate.latitude;
        location.longitude = [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:0] get_drink_location].coordinate.longitude;
        region.span = span;
        region.center = location;
        [mapView setRegion:region animated:YES];
        didViewDidLoad = 100;
        [mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];

        
    }
    else if(didViewDidLoad == 1)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([userLocation coordinate], 1600, 1600);
        [mapView setRegion:region animated:YES];
        didViewDidLoad = 100;
    }
    else if(didViewDidLoad == 2)
    {
        Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
        mapView.showsUserLocation = NO;
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.02;
        span.longitudeDelta = 0.02;
        CLLocationCoordinate2D location;
        location.latitude = [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:0] get_drink_location].coordinate.latitude;
         location.longitude = [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:0] get_drink_location].coordinate.longitude;
        region.span = span;
        region.center = location;
        [mapView setRegion:region animated:YES];
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
    mapView.showsUserLocation = NO;
    didViewDidLoad = 1;
    mapView.showsUserLocation = YES;
}

-(void) snapToDrinks: (id)sender
{
    mapView.showsUserLocation = NO;
    didViewDidLoad = 0;
    mapView.showsUserLocation = YES;
}


-(void)drinkName: (long)i witharg2: (NSMutableArray*)drinkName
{
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    if ([[[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"beer"])
    {
        if([[[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Light"] || [[[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Regular"] || [[[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Malt"])
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@""%@""%@",[[[[[navP historyNights] objectAtIndex:index.row]get_running_drink_list]objectAtIndex:i] get_size],@"oz",@" ",[[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i ] get_type], @" ", [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i ] get_name]];
            [drinkNameArray addObject:display];
        }
        else
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[[[[navP historyNights] objectAtIndex:index.row]get_running_drink_list]objectAtIndex:i] get_size],@"oz",@" ",[[[[[navP historyNights]objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i ] get_type]];
            [drinkNameArray addObject:display];
            
        }
    }
    /*If it is Bottle of wine, 'Bottle of' is appended. Otherwise 'Glass of' is appended*/
    else if([[[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"wine"])
    {
        if([[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_size] == 25.36)
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Bottle of ", [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_type]];
            [drinkNameArray addObject:display];
            
        }
        else
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Glass of ", [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_type]];
            [drinkNameArray addObject:display];
        }
    }
    /*If Liquor is selected, then it is either a Shot, and the word 'Shot' is appended, or it is a mixed drink, and nothing
     is appended. In the case where the user takes more than one shot, then the number of shots is included and 'Shots' is in
     its plural form*/
    else if([[[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"liquor"])
    {
        if([[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i]get_mixed_drink_bit]==FALSE)
        {
            if ([[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_size] > 1.5)
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[[[[navP historyNights] objectAtIndex:index.row]get_running_drink_list]objectAtIndex:i]get_size]/1.5,@" ", [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_type], @" Shots"];
                [drinkNameArray addObject:display];
                
            }
            else
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_type], @" Shot"];
                [drinkNameArray addObject:display];
                
            }
        }
        else if([[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i]get_mixed_drink_bit]==TRUE)
        {
            NSString *display = [[NSString alloc] initWithFormat:@"%@", [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_type]];
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

@end
