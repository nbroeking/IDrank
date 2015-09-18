//
//  StatTableViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 12/6/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "StatTableViewController.h"
#import "Main_Navigation_View_Controller.h"

@interface StatTableViewController ()

@end

@implementation StatTableViewController
@synthesize statName;
@synthesize buttonName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*This method displays the Stat page*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Sets the title arrays
    statName = [[NSMutableArray alloc] initWithObjects:@"My BAC:", @"I drank:", @"Time of First Drink:", @"Time of Last Drink:", nil];
    buttonName = [[NSMutableArray alloc] initWithObjects:@"My Map", nil];

}

/*This method is called when the user navigates back to the stat page from a map*/
-(void)viewDidAppear:(BOOL)animated
{
    // Resets the table view
    if([[(Main_Navigation_View_Controller*)self.navigationController getStat] get_tot_num_drinks] > 0)
        [[(Main_Navigation_View_Controller*)self.navigationController getStat] recalculate_bac];
    [self.tableView reloadData];
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
    
    // returns the number of sections in tableview
    if( [[(Main_Navigation_View_Controller*)self.navigationController night] location] == true)
    {
        return 2;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    // Returns the number of rows in table view
    if(section == 0)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This method initializes each indivdual cell in the table view
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Main_Navigation_View_Controller *navCont = (Main_Navigation_View_Controller*)self.navigationController;
    
    if( indexPath.section == 0)
    {
        
        cell.textLabel.text = [statName objectAtIndex:indexPath.row];
        
        if( indexPath.row == 1)
        {
            if([[navCont night]get_tot_num_drinks] == 1)
                cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%ld %@", [[navCont night] tot_num_drinks], @"Drink"];
            else
                cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%ld %@", [[navCont night] tot_num_drinks], @"Drinks"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if( indexPath.row == 2)
        {
                   [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@", [[navCont night] start_time_string]];
        }
        else if( indexPath.row == 3)
        {
                   [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@", [[navCont night] time_prev_drink_string]];
        }
        else if( indexPath.row == 0)
        {
                   [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%0.3f", [[navCont night] get_bac]];
        }
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.textLabel.text = [buttonName objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"";
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Sets the titles for each section in the table view
    if( section == 0)
    {
        return @"How is my night going?";
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
// What happens when a row is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0)
    {
        if(indexPath.row == 1)
        {
            [self performSegueWithIdentifier:@"goToDrinks" sender:self];
        }
    }
    
    else if( indexPath.section == 1)
    {
        [self performSegueWithIdentifier:@"goToMap" sender:self];
    }
}

@end
