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

@synthesize mapView, toolBar, index, drinkNameArray, didViewDidLoad;

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
    NSLog(@"viewDidLoad");
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    [super viewDidLoad];
    mapView.mapType = MKMapTypeHybrid;
    UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]initWithTitle: @"Toggle Views" style:UIBarButtonItemStyleBordered target: self action:@selector(changeMapType:)];
    UIBarButtonItem *typeButton4 = [[UIBarButtonItem alloc]initWithTitle: @"Find Me!" style:UIBarButtonItemStyleBordered target: self action:@selector(snapToMe:)];
    NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, typeButton4, nil];
    toolBar.items = buttons;
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    drinkNameArray = [[NSMutableArray alloc]init];
    int size = [[[[navP historyNights]objectAtIndex:index.row] get_running_drink_list] count];
    double lat, longi;
    [self.view addSubview:mapView];
    NSLog(@"FUCK YOU");
    if([[[navP historyNights] objectAtIndex:index.row]get_tot_num_drinks] > 0)
    {
        for(int i = 0; i < size; i++)
        {
            [self drinkName:i witharg2:drinkNameArray];
            CLLocation* drink_location = [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_drink_location];
            lat = drink_location.coordinate.latitude;
            longi = drink_location.coordinate.longitude;
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, longi);
            NSString* drink = [[self drinkNameArray]objectAtIndex:i];
            NSString* time = [[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_time_drank_string];
            Annotation* pin_annotaion = [[Annotation alloc]initWithCoordinates:coordinate :drink :time];
            [mapView addAnnotation:pin_annotaion];
        }
    }

}

- (void)mapView:(MKMapView *)mapView2 didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(didViewDidLoad != 1)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([userLocation coordinate], 200, 200);
        [mapView setRegion:region animated:YES];
        didViewDidLoad = 1;
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
    didViewDidLoad = 0;
    mapView.showsUserLocation = YES;
}

-(void)drinkName: (int)i witharg2: (NSMutableArray*)drinkName
{
    NSLog(@"here6");
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    if ([[[[[[navP historyNights] objectAtIndex:index.row] get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"beer"])
    {
        
        NSLog(@"We entered the beer conditional");
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
    NSLog(@"here7");
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView2 viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSLog(@"here10");
    
	MKAnnotationView* annotationView = nil;
    NSLog(@"here101");
    
    
	if([annotation isKindOfClass:[Annotation class]])
	{
        NSLog(@"here102");
        
		// determine the type of annotation, and produce the correct type of annotation view for it.
		Annotation* csAnnotation = (Annotation*)annotation;
        NSLog(@"here103");
        
        NSString* identifier = @"Pin";
        MKPinAnnotationView* pin = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        NSLog(@"here104");
        
        if(nil == pin)
        {    NSLog(@"here105");
            
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:csAnnotation reuseIdentifier:identifier];
        }
        
        pin.pinColor = MKPinAnnotationColorRed;
        NSLog(@"here106");
        
        annotationView = pin;
		
		[annotationView setEnabled:YES];
		[annotationView setCanShowCallout:YES];
        
        NSLog(@"here107");
        
	}
	
	return annotationView;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
