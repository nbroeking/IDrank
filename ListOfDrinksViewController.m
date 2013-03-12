//
//  ListOfDrinksViewController.m
//  iDrank
//
//  Created by Nick Evans on 11/30/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "ListOfDrinksViewController.h"
#import "Drink.h"

@interface ListOfDrinksViewController ()

@end

@implementation ListOfDrinksViewController
@synthesize liquorDrinkDetailArray, liquorDrinkNameArray, liquorTypeOnlyArray, wineDrinkDetailArray, wineDrinkNameArray, wineTypeOnlyArray, beerDrinkDetailArray, beerDrinkNameArray, beerTypeOnlyArray, addNewUserDrinkViewController;
@synthesize mixedDrinkDetailArray;
@synthesize mixedDrinkNameArray;
@synthesize mixedDrinkTypeOnlyArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self prepareTable];
    [self.tableView reloadData];
}


// This prepares the tableview
-(void)prepareTable
{
    int size = [[[(Main_Navigation_View_Controller*)self.navigationController getDrinkList] get_drink_list] count];
    
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    
    liquorDrinkDetailArray = [[NSMutableArray alloc] init];
    liquorDrinkNameArray = [[NSMutableArray alloc] init];
    liquorTypeOnlyArray = [[NSMutableArray alloc] init];
    wineDrinkNameArray = [[NSMutableArray alloc] init];
    wineDrinkDetailArray = [[NSMutableArray alloc] init];
    wineTypeOnlyArray = [[NSMutableArray alloc] init];
    beerDrinkNameArray = [[NSMutableArray alloc] init];
    beerDrinkDetailArray = [[NSMutableArray alloc] init];
    beerTypeOnlyArray = [[NSMutableArray alloc] init];
    
    mixedDrinkNameArray = [[NSMutableArray alloc] init];
    mixedDrinkDetailArray = [[NSMutableArray alloc] init];
    mixedDrinkTypeOnlyArray = [[NSMutableArray alloc] init];
    
    for( int i = 0; i < size; i ++ )
    {
        
       
        
        NSString* display = [[NSString alloc]initWithFormat:@"%@",[[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_type]];
        
        
        if( [[[[[navP getDrinkList] get_drink_list] objectAtIndex:i ] get_name] isEqualToString:@"beer"])
        {
            NSString* detail = [[NSString alloc]initWithFormat:@"%@""%.1f""%@",@"Alc Content:  ", [[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_ac],@"%"];
            [beerDrinkNameArray addObject:display];
            [beerDrinkDetailArray addObject:detail];
        }
        else if( [[[[[navP getDrinkList] get_drink_list] objectAtIndex:i ] get_name] isEqualToString:@"wine"])
        {
           NSString* detail = [[NSString alloc]initWithFormat:@"%@""%.1f""%@",@"Alc Content:  ", [[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_ac],@"%"];
            [wineDrinkNameArray addObject:display];
            [wineDrinkDetailArray addObject:detail];
        }
        else
        {
            NSString* detail = [[NSString alloc]initWithFormat:@"%@""%.0f""%@",@"Alc Content:  ", [[[[navP getDrinkList]get_drink_list]objectAtIndex:i]get_ac],@"%"];
            
            if ( [[[[navP getDrinkList] get_drink_list] objectAtIndex:i] get_mixed_drink_bit])
            {
                [mixedDrinkNameArray addObject:display];
                [mixedDrinkDetailArray addObject:detail];
            }
            else
            {
                
                [liquorDrinkNameArray addObject:display];
                [liquorDrinkDetailArray addObject:detail];
            }
        }
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
        self.navigationItem.rightBarButtonItem=self.editButtonItem;
    [self prepareTable];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

// Decides how many rows are in each section of the tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( section == 0)
    {
        if (self.editing)
        {
            return [beerDrinkNameArray count]+1;
        }
        
        return [beerDrinkNameArray count];
    }
    else if( section == 1)
    {
        if (self.editing)
        {
            return [wineDrinkNameArray count]+1;
        }
        return [wineDrinkNameArray count];
    }
    else if( section == 2)
    {
        if (self.editing)
        {
            return [liquorDrinkNameArray count]+1;
        }
        return [liquorDrinkNameArray count];
    }
    else
    {
        if( self.editing)
        {
            return [mixedDrinkNameArray count]+1;
        }
        return [mixedDrinkNameArray count];
    }
}

// This gets and creates a cell in the tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    if( indexPath.section == 0)
    {
       if (indexPath.row == [beerDrinkNameArray count])
       {
           cell.textLabel.text = @"Add Beer";
           cell.detailTextLabel.text=@"Add your own beer to the list";
       }
       else{
        
        NSString *drink=[beerDrinkNameArray objectAtIndex:indexPath.row];
        cell.textLabel.text=drink;
    
        NSString *drinkDetail=[beerDrinkDetailArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=drinkDetail;
       }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == [wineDrinkNameArray count])
        {
            cell.textLabel.text = @"Add Wine";
            cell.detailTextLabel.text=@"Add your own wine to the list";
        }
        else{
        
        NSString *drink=[wineDrinkNameArray objectAtIndex:indexPath.row];
        cell.textLabel.text=drink;
        
        NSString *drinkDetail=[wineDrinkDetailArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=drinkDetail;
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == [liquorDrinkNameArray count])
        {
            cell.textLabel.text = @"Add Liquor";
            cell.detailTextLabel.text=@"Add your own drink to the list";
        }
        else{
            

        NSString *drink=[liquorDrinkNameArray objectAtIndex:indexPath.row];
        cell.textLabel.text=drink;
        
        NSString *drinkDetail=[liquorDrinkDetailArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=drinkDetail;
        }
    }
    
    else
    {
        if (indexPath.row == [mixedDrinkNameArray count])
        {
            cell.textLabel.text = @"Add Drink";
            cell.detailTextLabel.text=@"Add your own mixed drink to the list";
        }
        else{
            
            
            NSString *drink=[mixedDrinkNameArray objectAtIndex:indexPath.row];
            cell.textLabel.text=drink;
            
            NSString *drinkDetail=[mixedDrinkDetailArray objectAtIndex:indexPath.row];
            cell.detailTextLabel.text=drinkDetail;
        }

    }
    return cell;
}

// this method sets the title in each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if( section == 0)
    {
        return @"Beer";
    }
    else if( section == 1)
    {
        return @"Wine";
    }
    else if( section == 2)
    {
        return @"Hard Liquor";
    }
    else
    {
        return @"Mixed Drink";
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.section == 0)
        {
                [[navP getDrinkList] removeDrinkByType:[beerDrinkNameArray objectAtIndex:indexPath.row]];
                [beerDrinkNameArray removeObjectAtIndex:indexPath.row];
                [beerDrinkDetailArray removeObjectAtIndex:indexPath.row];
            
        }
        else if (indexPath.section == 1)
        {
                [[navP getDrinkList] removeDrinkByType:[wineDrinkNameArray objectAtIndex:indexPath.row]];
                [wineDrinkNameArray removeObjectAtIndex:indexPath.row];
                [wineDrinkDetailArray removeObjectAtIndex:indexPath.row];
            
        }
        else if (indexPath.section == 2)
        {
                [[navP getDrinkList] removeDrinkByType:[liquorDrinkNameArray objectAtIndex:indexPath.row]];
                [liquorDrinkNameArray removeObjectAtIndex:indexPath.row];
                [liquorDrinkDetailArray removeObjectAtIndex:indexPath.row];
        }
        else
        {
            [[navP getDrinkList] removeDrinkByType:[mixedDrinkNameArray objectAtIndex:indexPath.row]];
            [mixedDrinkNameArray removeObjectAtIndex:indexPath.row];
            [mixedDrinkDetailArray removeObjectAtIndex:indexPath.row];
        }
       
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self performSegueWithIdentifier:@"addDrinkSegue" sender:indexPath];
        
    }
    [navP save_data];
}
// This delegates editing withen the tableview
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section == 0)
   {
        if(indexPath.row == [beerDrinkNameArray count])
        {
            return UITableViewCellEditingStyleInsert;
        }
   }
   
   else if (indexPath.section == 1)
    {
        if(indexPath.row == [wineDrinkNameArray count])
        {
            return UITableViewCellEditingStyleInsert;
        }
    }
    else if (indexPath.section == 2)
    {
        if(indexPath.row == [liquorDrinkNameArray count])
        {
            return UITableViewCellEditingStyleInsert;
        }
        
    }
    else 
    {
        if( indexPath.row == [mixedDrinkNameArray count])
        {
            return UITableViewCellEditingStyleInsert;
        }
    }
    
    return UITableViewCellEditingStyleDelete;
}


#pragma mark - Table view delegate

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
   if(editing) {
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:beerDrinkNameArray.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
       [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:wineDrinkNameArray.count inSection:1]] withRowAnimation:UITableViewRowAnimationLeft];
       [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:liquorDrinkNameArray.count inSection:2]] withRowAnimation:UITableViewRowAnimationLeft];
       [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:mixedDrinkNameArray.count inSection:3]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    } else {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:beerDrinkNameArray.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:wineDrinkNameArray.count inSection:1]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:liquorDrinkNameArray.count inSection:2]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:mixedDrinkNameArray.count inSection:3]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        // place here anything else to do when the done button is clicked
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // This prepares the seque
    NSString* drinkClass;
    NSString* drinkDisplay;
    
    NSIndexPath* indexPath = (NSIndexPath*)sender;
    
    if (indexPath.section == 0)
    {
       drinkClass = @"beer";
       drinkDisplay = @"Add Beer";
    }
    else if (indexPath.section == 1)
    {
        drinkClass = @"wine";
        drinkDisplay = @"Add Wine";
    }
    else if (indexPath.section == 2)
    {
       drinkClass = @"liquor";
        drinkDisplay = @"Add Liquor";
    }
    else 
    {
        drinkClass = @"liquor";
        drinkDisplay = @"Add Mixed Drink";
    }
    
    addNewUserDrinkViewController = (AddNewUserDrinkViewController*)segue.destinationViewController;
    addNewUserDrinkViewController.drinkClass = drinkClass;
    addNewUserDrinkViewController.display = drinkDisplay;
}

-(void)addDrink:(Drink*)drink
{
    
}
@end
