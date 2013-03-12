//
//  SettingsTableViewController.m
//  iDrank
//
//  Created by Nicolas Charles Herbert Broeking on 12/3/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "Main_Navigation_View_Controller.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController
@synthesize personalMenu;
@synthesize DrinkMenu;
@synthesize nightMenu;
@synthesize weightField;
@synthesize ageField;
@synthesize genderMenu;
@synthesize otherMenu;
@synthesize doneButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    // THis method initializes the view controller
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = nil;
    personalMenu= [[NSMutableArray alloc] initWithObjects: @"Gender", @"Weight", @"Age", nil];
    genderMenu = [[NSMutableArray alloc] initWithObjects:@"Male", @"Female", nil];
    
    otherMenu = [[NSMutableArray alloc] initWithObjects:@"Weight",@"Age", nil];
    DrinkMenu = [[NSMutableArray alloc] initWithObjects:@"My Drinks", nil];
    nightMenu = [[NSMutableArray alloc] initWithObjects:@"Location", nil];
    
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tapRec setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapRec];
    
    //[self reloadInputViews];
    [self.tableView reloadData];
    //UITapGestureRecognizer *close = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
   // [self.view addGestureRecognizer:close];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    // Everytime the view is shown again reload the data
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loadData:(id)sender
{
    // This method doesnt do anything
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( section == 0)
    {
        return 2;
    }
    else if( section == 1)
    {
        return 2;
    }
    else if( section == 4)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This sets up the individual cell
    static NSString *CellIdentifier;
    if( indexPath.section == 0)
    {
      CellIdentifier = @"textFieldCell";
    }
    else if( indexPath.section == 1)
    {
        CellIdentifier = @"sliderCell";
    }
    else
    {
        CellIdentifier = @"Cell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
    if( indexPath.section == 0)
    {
        cell.detailTextLabel.text = @"";
        cell.textLabel.text = [genderMenu objectAtIndex:indexPath.row];
        if((indexPath.row == 0 ))
        {
            if( [[(Main_Navigation_View_Controller*)self.navigationController person]gender] == 1 )
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        else
        {
            if( [[(Main_Navigation_View_Controller*)self.navigationController person]gender] == 2 )
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    else if( indexPath.section == 1)
    {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = [otherMenu objectAtIndex:indexPath.row];
    
        if( indexPath.row == 0)
        {
                
            weightField = [[UITextField alloc] initWithFrame:CGRectMake(200, 10, 100, 30)];
            weightField.tag = 1;
            weightField.keyboardType = UIKeyboardTypeNumberPad;
            [weightField setDelegate:self];
            [cell addSubview:weightField];
            
            if([[(Main_Navigation_View_Controller*)self.navigationController person] weight] != 0)
            {
                NSString *weight = [[NSString alloc] initWithFormat:@"%d Lbs",[[(Main_Navigation_View_Controller*)self.navigationController person] weight]];
                cell.detailTextLabel.text = weight;
            }
            else
            {
                cell.detailTextLabel.text = @"Lbs";
            }
            
        }
        else if(indexPath.row == 1)
        {
            if( ageField == nil)
            {
                ageField = [[UITextField alloc] initWithFrame:CGRectMake(200, 10, 100, 30)];
                ageField.tag = 2;
                ageField.keyboardType = UIKeyboardTypeNumberPad;
                [ageField setDelegate:self];
                [cell addSubview:ageField];
            }
            if([[(Main_Navigation_View_Controller*)self.navigationController person] age] != 0)
            {
                NSString *age = [[NSString alloc] initWithFormat:@"%d",[[(Main_Navigation_View_Controller*)self.navigationController person] age]];
                cell.detailTextLabel.text = age;
            }
            else
            {
                cell.detailTextLabel.text = @"";
            }
        }
        //----------------------------------------------------------
        else
        {
            cell.detailTextLabel.text = @"";
        }
    }
    //----------------------------------------------------------
    else if( indexPath.section == 2)
    {
        cell.textLabel.text = [nightMenu objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"";
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UISwitch *locatonSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 100, 30)];
        locatonSwitch.tag = 3;
        [locatonSwitch addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
        
        if([[(Main_Navigation_View_Controller*)self.navigationController person] location] == true)
        {
            [locatonSwitch setOn:true];
        }
        else
        {
            [locatonSwitch setOn:FALSE];
        }
        [cell addSubview:locatonSwitch];
    }
    else if( indexPath.section == 3)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = [DrinkMenu objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"";
    }
    else if( indexPath.section == 4)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if( indexPath.row == 1)
        {
            cell.textLabel.text = @"Reset All Settings";
            cell.detailTextLabel.text = @"";
        }
        else if( indexPath.row == 0)
        {
            cell.textLabel.text = @"Reset Drink List";
            cell.detailTextLabel.text = @"";
        }
    }
    else
    {
        cell.accessoryType= UITableViewCellAccessoryNone;
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    // This sets the section titles
    if( section == 0)
    {
        return @"Gender";
    }
    else if( section == 1)
    {
        return @"Personal";
    }
    else if( section == 2)
    {
        return @"Night";
    }
    else if( section == 3)
    {
        return @"Drink";
    }
    else
    {
        return @"Reset";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
    // This sets the footers
    if( section == 0)
    {
        return @"Select your gender";
    }
    else if(section == 1)
    {
        return @"Enter your weight and your age";
    }
    else if( section == 2)
    {
        return @"Turn on if you want to know where you drank.";
    }
    else if( section == 3)
    {
        return @"Add or remove a drink for use in your night.";
    }
    else
    {
        return @"";
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
    // What happens when you select a row
    if((indexPath.section == 0)&&(indexPath.row == 0) )
    {
        [[(Main_Navigation_View_Controller*)self.navigationController person] setGender:1];
        [self.tableView reloadData];
    }
    else if(( indexPath.section == 0)&&(indexPath.row == 1))
    {
        [[(Main_Navigation_View_Controller*)self.navigationController person] setGender:2];
        [self.tableView reloadData];
    }
    else  if((indexPath.section == 1)&(indexPath.row == 0) )
    {
        [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
        [weightField becomeFirstResponder];
    }
    else if(( indexPath.section == 1)&&(indexPath.row == 1))
    {
        [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
        [ageField becomeFirstResponder];
    }
    
    else if (( indexPath.section == 3))
    {
            [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
            [self performSegueWithIdentifier:@"goToDrink" sender:self];
       
    }
    else if((indexPath.section == 4))
    {
        if( indexPath.row ==1)
        {
            [(Main_Navigation_View_Controller*)self.navigationController resetData];
            [self.tableView reloadData];
        }
        else
        {
            [[(Main_Navigation_View_Controller*)self.navigationController drinkList] resetDrinkList:self];
            [self.tableView reloadData];
        }
    }
}

-(void)change: (UITableViewCell*) cell
{
    // changes the cell state
    cell.selected = false;
}
#pragma mark UITextView methods
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [doneButton setAction:@selector(dismissKeyboard)];
    [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
    // sets the textfields to be edited
    if(textField == weightField)
    {
        weightField.placeholder = @"Lbs";
        NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:1];
        [self.tableView cellForRowAtIndexPath:index].detailTextLabel.text = @"";
    }
    else if( textField == ageField)
    {
        textField.placeholder = @"";
        NSIndexPath *index = [NSIndexPath indexPathForItem:1 inSection:1];
        [self.tableView cellForRowAtIndexPath:index].detailTextLabel.text = @"";
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    // CLoses down the textfields and checks for errors
    if([self checkField:textField])
    {
        if( textField == weightField)
        {
            if( [textField.text intValue] > 1000)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You don't weigh that much." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                [[(Main_Navigation_View_Controller*)self.navigationController person] set_weight:[ weightField.text intValue]];
            }
        }
    
        else if ( textField == ageField)
        {
            if( [textField.text intValue] > 100)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You are not that old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                [[(Main_Navigation_View_Controller*)self.navigationController person] setAge:[ ageField.text intValue]];
        
            if( [ageField.text intValue] < 21)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"The age entered indicates that it may be illegal for you to drink in certain areas.  We do not condone underage drinking and take no responsibilty for any crimes you may commit while using this application." delegate:self cancelButtonTitle:@"Agree" otherButtonTitles:nil, nil];
            
                [alert show];
            }
            }
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must enter a valid integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [(Main_Navigation_View_Controller*)self.navigationController save_data];
    textField.placeholder = @"";
    textField.text = @"";
    [self.tableView reloadData];
    
}
-(BOOL)checkField:(UITextField*)textField
{
    int size = [textField.text length];
    for( int i = 0; i < size; i++)
    {
        char a = [textField.text characterAtIndex:i];
        
        if(( a != '1')&&( a != '2')&&(a != '3')&&(a != '4')&&(a != '5')&&(a != '6')&&(a != '7')&&(a != '8')&&(a != '9')&&( a != '0'))
        {
            return false;
        }
    }
return true;
}

-(IBAction)dismissKeyboard
{
    // closes the keyboard
    [ageField resignFirstResponder];
    [weightField resignFirstResponder];
    [(Main_Navigation_View_Controller*)self.navigationController save_data];
}

- (IBAction)flip:(id)sender
{
    // Sets the location bit
    UISwitch *loc = (UISwitch*)sender;
    if( loc.on == true)
    {
        [[(Main_Navigation_View_Controller*)self.navigationController person] setLocation:true];
    }
    else
    {
        [[(Main_Navigation_View_Controller*)self.navigationController person] setLocation:false];
    }
    
    [(Main_Navigation_View_Controller*)self.navigationController save_data];
}

@end
