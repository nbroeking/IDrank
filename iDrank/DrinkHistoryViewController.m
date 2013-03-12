//
//  DrinkHistoryViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 11/26/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "DrinkHistoryViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "Stat.h"
#import "HistoryDrinkMapViewController.h"

@interface DrinkHistoryViewController ()

@end

@implementation DrinkHistoryViewController
@synthesize drinkNameArray;
@synthesize drinkDetailArray;
@synthesize index;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*This function formats the drinkDetails display with the time and bac when the drink was drank*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    drinkNameArray = [[NSMutableArray alloc]init];
    drinkDetailArray = [[NSMutableArray alloc]init];
    
    int size = [[[[(Main_Navigation_View_Controller*)self.navigationController historyNights] objectAtIndex:index.row ] get_running_drink_list] count];
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    Stat *nighttemp = [[ navP historyNights] objectAtIndex:index.row];
    
    
    for( int i = 0; i < size; i ++ )
    {
        /*If the drink name is Beer and the Type is either Light, Medium, or Malt, then the word "Beer" is appended to the end of the String.
         Otherwise Beer is not appended, in case in future iterations a user wants to add 'Keystone'. "Keystone" is a standalone name
         and should not have 'Beer' appended*/
        if ([[[[nighttemp get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"beer"])
        {
            if([[[[nighttemp get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Light"] || [[[[nighttemp get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Regular"] || [[[[nighttemp get_running_drink_list] objectAtIndex:i] get_type] isEqualToString: @"Malt"])
            {

                NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@""%@""%@",[[[nighttemp get_running_drink_list]objectAtIndex:i] get_size],@"oz",@" ",[[[nighttemp get_running_drink_list] objectAtIndex:i ] get_type], @" ", [[[nighttemp get_running_drink_list] objectAtIndex:i ] get_name]];
             
                
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];
            }
            else
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[[nighttemp get_running_drink_list]objectAtIndex:i] get_size],@"oz",@" ",[[[nighttemp get_running_drink_list] objectAtIndex:i ] get_type]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];
                
            }
        
        }
        /*If it is Bottle of wine, 'Bottle of' is appended. Otherwise 'Glass of' is appended*/
        else if([[[[nighttemp get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"wine"])
        {
            if([[[nighttemp get_running_drink_list] objectAtIndex:i] get_size] == 25.36)
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Bottle of ", [[[nighttemp get_running_drink_list] objectAtIndex:i] get_type]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];
                
            }
            else
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Glass of ", [[[nighttemp get_running_drink_list] objectAtIndex:i] get_type]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];
                
            }
        }
  
        /*If Liquor is selected, then it is either a Shot, and the word 'Shot' is appended, or it is a mixed drink, and nothing
         is appended. In the case where the user takes more than one shot, then the number of shots is included and 'Shots' is in
         its plural form*/
        else if([[[[nighttemp get_running_drink_list] objectAtIndex:i] get_name] isEqualToString: @"liquor"])
        {
            if([[[nighttemp get_running_drink_list] objectAtIndex:i]get_mixed_drink_bit]==FALSE)
            {
                if ([[[nighttemp get_running_drink_list] objectAtIndex:i] get_size] > 1.5)
                {
                    NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[[nighttemp get_running_drink_list]objectAtIndex:i]get_size]/1.5,@" ", [[[nighttemp get_running_drink_list] objectAtIndex:i] get_type], @" Shots"];
                    [drinkNameArray addObject:display];
                    [self drinkDetail:i witharg2:drinkDetailArray];
                    
                }
                else
                {
                    NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", [[[nighttemp get_running_drink_list] objectAtIndex:i] get_type], @" Shot"];
                    [drinkNameArray addObject:display];
                    [self drinkDetail:i witharg2:drinkDetailArray];
                    
                }
            }
            else if([[[[navP getStat] get_running_drink_list] objectAtIndex:i]get_mixed_drink_bit]==TRUE)
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@", [[[nighttemp get_running_drink_list] objectAtIndex:i] get_type]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];
                
            }
        }
    }
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.edit
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [drinkNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    
    Stat *navp=[[(Main_Navigation_View_Controller*)self.navigationController historyNights] objectAtIndex:index.row];
    
    if(( [navp location] == true)&&( [[(Main_Navigation_View_Controller*)self.navigationController person] location] == true))
    {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSString *drink=[drinkNameArray objectAtIndex:indexPath.row];
    cell.textLabel.text=drink;
    NSString *drinkDetail=[drinkDetailArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=drinkDetail;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    Stat *navPNight = [[(Main_Navigation_View_Controller*)self.navigationController historyNights] objectAtIndex:index.row];
    
    if( ([[navP person] location] == true)&&([navPNight location] == true))
       {
           [self performSegueWithIdentifier:@"goToHistoryDrinkMap" sender:indexPath];
       }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Drink* tempDrink = [[[[(Main_Navigation_View_Controller*)self.navigationController historyNights]objectAtIndex:index.row] get_running_drink_list] objectAtIndex:((NSIndexPath*)sender).row];
    [(HistoryDrinkMapViewController*)segue.destinationViewController setDrinkToShow:tempDrink];
}
- (void) drinkDetail: (int)indext witharg2:(NSMutableArray *)drinkDetail
{
    Stat *night = [[(Main_Navigation_View_Controller*)self.navigationController historyNights] objectAtIndex:index.row];
    
    double temp = [[[night get_bac_array]objectAtIndex:indext] doubleValue];
    NSString *detailDisplay = [[NSString alloc] initWithFormat:@"%@""%@""%@""%@""%.3f""%@",@"Drank at: ",[[[night get_running_drink_list]objectAtIndex:indext] get_time_drank_string], @"   ", @"BAC: ",temp, @"%"];
    
    [drinkDetailArray addObject:detailDisplay];
    
}

@end
