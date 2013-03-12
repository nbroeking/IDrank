//
//  DrinkListTableViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 11/12/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "DrinkListTableViewController.h"
#import "Main_Navigation_View_Controller.h"

@interface DrinkListTableViewController ()

@end

@implementation DrinkListTableViewController
@synthesize drinkNameArray;
@synthesize drinkDetailArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*This function formats the drinkDetails display with the time and bac when the drink was drank*/
- (void) drinkDetail: (int)index witharg2:(NSMutableArray *)drinkDetail
{
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    double temp = [[[[navP getStat]get_bac_array]objectAtIndex:index] doubleValue];
    NSString *detailDisplay = [[NSString alloc] initWithFormat:@"%@""%@""%.3f""%@",[[[[navP getStat]get_running_drink_list]objectAtIndex:index] get_time_drank_string], @"   ", temp, @"%"];
    [drinkDetailArray addObject:detailDisplay];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    drinkNameArray = [[NSMutableArray alloc]init];
    drinkDetailArray = [[NSMutableArray alloc]init];
    int size = [[[(Main_Navigation_View_Controller*)self.navigationController getStat] get_running_drink_list] count];
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    for( int i = 0; i < size; i ++ )
    {
        /*If the drink name is Beer and the Type is either Light, Medium, or Malt, then the word "Beer" is appended to the end of the String. 
         Otherwise Beer is not appended, in case in future iterations a user wants to add 'Keystone'. "Keystone" is a standalone name
         and should not have 'Beer' appended*/
        if([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_name] == @"beer")
        {
            if([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type] == @"Light" || [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type] == @"Regular" || [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type] == @"Malt")
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@""%@""%@",[[[[navP getStat]get_running_drink_list]objectAtIndex:i] get_size],@"oz",@" ",[[[[navP getStat] get_running_drink_list] objectAtIndex:i ] get_type], @" ", [[[[navP getStat] get_running_drink_list] objectAtIndex:i ] get_name]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];
            }
            else
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[[[navP getStat]get_running_drink_list]objectAtIndex:i] get_size],@"oz",@" ",[[[[navP getStat] get_running_drink_list] objectAtIndex:i ] get_type]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];

            }
        }
        /*If it is Bottle of wine, 'Bottle of' is appended. Otherwise 'Glass of' is appended*/
        else if([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_name] == @"wine")
        {
            if([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_size] == 25.36)
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Bottle of ", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];

            }
            else
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", @"Glass of ", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];

            }
        }
        /*If Liquor is selected, then it is either a Shot, and the word 'Shot' is appended, or it is a mixed drink, and nothing
         is appended. In the case where the user takes more than one shot, then the number of shots is included and 'Shots' is in 
         its plural form*/
        else if([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_name] == @"liquor")
        {
            if([[[[navP getStat] get_running_drink_list] objectAtIndex:i]get_mixed_drink_bit]==FALSE)
            {
                if ([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_size] > 1.5)
                {
                    NSString *display = [[NSString alloc] initWithFormat:@"%.f""%@""%@""%@",[[[[navP getStat]get_running_drink_list]objectAtIndex:i]get_size]/1.5,@" ", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type], @" Shots"];
                    [drinkNameArray addObject:display];
                    [self drinkDetail:i witharg2:drinkDetailArray];

                }
                else
                {
                    NSString *display = [[NSString alloc] initWithFormat:@"%@""%@", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type], @" Shot"];
                    [drinkNameArray addObject:display];
                    [self drinkDetail:i witharg2:drinkDetailArray];

                }
            }
            else if([[[[navP getStat] get_running_drink_list] objectAtIndex:i]get_mixed_drink_bit]==TRUE)
            {
                NSString *display = [[NSString alloc] initWithFormat:@"%@", [[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_type]];
                [drinkNameArray addObject:display];
                [self drinkDetail:i witharg2:drinkDetailArray];

            }
        }
    }
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
    
    NSString *drink=[drinkNameArray objectAtIndex:indexPath.row];
    cell.textLabel.text=drink;
    
    NSString *drinkDetail=[drinkDetailArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=drinkDetail;

    return cell;
}


/*// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Return NO if you do not want the specified item to be editable.
    return YES;
}*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //remember to fix time and total BAC
        //change total number of drinks
        Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
        
        int numDrinkEntries = [[[navP getStat]get_running_drink_list] count];
        if (indexPath.row == numDrinkEntries - 1)
        {
            //This can probably be a seperate function
            double size = [[[[navP getStat]get_running_drink_list]objectAtIndex:indexPath.row]get_size];
            double ac = [[[[navP getStat]get_running_drink_list]objectAtIndex:indexPath.row]get_ac];
            double alc_oz = [[navP getStat]get_total_num_alc_oz];
            double this_alc_oz = size * (ac/100);
            alc_oz = alc_oz - this_alc_oz;
            [[navP getStat]set_num_alc_oz:alc_oz];
            
            NSDate* new_date = [[[[navP getStat]get_running_drink_list]objectAtIndex:indexPath.row -1]get_time_drank];
            [[navP getStat]set_time_prev_drink:new_date];
            
            NSString* new_time = [[[[navP getStat]get_running_drink_list]objectAtIndex:indexPath.row-1]get_time_drank_string];
            [[navP getStat]set_time_prev_drink_string:new_time];
            
            
            if([[[[navP getStat]get_running_drink_list]objectAtIndex:indexPath.row]get_name] == @"wine")
            {
               //if([[[[navP getStat] get_running_drink_list] objectAtIndex:i] get_size] == 25.36)
               {
                   //int temp
                   //[[navP getStat]set_tot_num_drinks:<#(int)#>]
               }
            }
        }
        
        
        
       [[[navP getStat]get_bac_array]removeObjectAtIndex:indexPath.row];
        [[[navP getStat]get_running_drink_list]removeObjectAtIndex:indexPath.row];
        [drinkDetailArray removeObjectAtIndex:indexPath.row];
        [drinkNameArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        

    }
}


@end
