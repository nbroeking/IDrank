//
//  HistoryTableViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 12/10/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "DrinkHistoryViewController.h"
#import "HistoryMapViewController.h"

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController
@synthesize index;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd YYYY"];

    self.title = [format stringFromDate: [[[(Main_Navigation_View_Controller*)self.navigationController historyNights]objectAtIndex:index.row]get_start_time]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    Stat *navp=[[(Main_Navigation_View_Controller*)self.navigationController historyNights] objectAtIndex:index.row];
    
    if( ([navp location] == true)&&([[ (Main_Navigation_View_Controller*)self.navigationController person] location] == true))
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 4;
    }
    if(section == 1)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
     Stat *navp=[[(Main_Navigation_View_Controller*)self.navigationController historyNights] objectAtIndex:index.row];
    
    if(indexPath.section == 0)
    {
       
        
        if(indexPath.row == 0)
        {
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *info = [[NSString alloc] initWithFormat:@"%0.3f"@"%@", [navp calculate_highest_BAC], @"%"];
            cell.textLabel.text = @"My highest BAC:";
            cell.detailTextLabel.text = info;
        }
        if(indexPath.row == 1)
        {
            cell.textLabel.text = @"I drank:";
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if( [navp get_tot_num_drinks] != 1)
            {
                NSString *info = [[NSString alloc]initWithFormat:@"%ld drinks", [navp get_tot_num_drinks]];
                cell.detailTextLabel.text = info;
            }
            else
            {
                NSString *info = [[NSString alloc]initWithFormat:@"%ld drink", [navp get_tot_num_drinks]];
             
                cell.detailTextLabel.text = info;
            }
        }
        else if( indexPath.row == 2)
        {
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"Time of First Drink:";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@", [navp start_time_string]];
        }
        else if( indexPath.row == 3)
        {
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"Time of Final Drink:";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@", [navp time_prev_drink_string]];
        }
    }
    // Configure the cell...
    else if( indexPath.section == 1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            cell.textLabel.text = @"My Map:";
            cell.detailTextLabel.text = @"";
        
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if( section == 0)
    {
        return @"How did my night go?";
    }
    else
    {
        return @"Where did I drink?";
    }
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
        // Create a new instance of the appropriate class, insert it longo the array, and add a new row to the table view
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
    if(indexPath.section == 0)
    {
        if(indexPath.row == 1)
        {
            // Removed till later version
            //[self performSegueWithIdentifier:@"goToHistoryDrinks" sender:index];
        }
    }
    else if(indexPath.section == 1)
    {
            [self performSegueWithIdentifier:@"goToHistoryMap" sender:index];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString: @"goToHistoryDrinks"])
    {
         [(DrinkHistoryViewController*)segue.destinationViewController setIndex:(NSIndexPath*)sender];
    }
    else
    {
        [(HistoryMapViewController*)segue.destinationViewController setIndex:(NSIndexPath*)sender];
    }
}
@end
