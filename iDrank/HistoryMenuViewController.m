//
//  HistoryMenuViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 11/11/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "HistoryMenuViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "Stat.h"
#import "HistoryTableViewController.h"

@interface HistoryMenuViewController ()

@end

@implementation HistoryMenuViewController


//@synthesize editing;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.topViewController != self)
    {
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
    
 
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated: YES];
    [self.tableView setEditing:editing animated:YES];
  

    if(editing)
    {
        [self.navigationController setToolbarHidden:NO animated:YES];
        NSMutableArray *buttonsArray = [[NSMutableArray alloc] init];
        UIBarButtonItem *deleteButton=[[UIBarButtonItem alloc] initWithTitle:@"Clear History" style: UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonPressed1)];
        [buttonsArray addObject:deleteButton];
        [self setToolbarItems:buttonsArray animated:YES];
    }
    else
    {
            [self.navigationController setToolbarHidden:YES animated:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [[(Main_Navigation_View_Controller*)self.navigationController historyNights] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd YYYY"];
    
    Stat *tempStat = [[(Main_Navigation_View_Controller*)self.navigationController historyNights] objectAtIndex:indexPath.row];
    
    NSString *dateString = [format stringFromDate: [tempStat get_start_time]];
                            
    cell.textLabel.text=dateString;
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
        [[navP historyNights] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"prev" sender:indexPath];
}

-(void)toolbarButtonPressed1
{
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    [[navP historyNights] removeAllObjects];
    [[self tableView] reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [(HistoryTableViewController*)segue.destinationViewController setIndex:(NSIndexPath*)sender];
}
@end
