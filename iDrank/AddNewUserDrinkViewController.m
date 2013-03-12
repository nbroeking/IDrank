//
//  AddNewUserDrinkViewController.m
//  iDrank
//
//  Created by Nick Evans on 12/10/12.
//  Copyright (c) 2012 MANNW. All rights reserved.
//

#import "AddNewUserDrinkViewController.h"
#import "Main_Navigation_View_Controller.h"
#import "ListOfDrinksViewController.h"

@interface AddNewUserDrinkViewController ()

@end

@implementation AddNewUserDrinkViewController
@synthesize drinkAC, isMixedDrink, userEnteredName, drinkClass, nameField, acSlider, mixedDrinkSwitch, display, drinkToAdd;
@synthesize doneButton;

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
    self.navigationItem.rightBarButtonItem = nil;
    [self setTitle:display];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:(@selector(dismissKeyboard))];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)dismissKeyboard
{// Makes the keyboard go away
    [nameField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addToList:(Drink*) newDrink
{// Adds a drink to the list
    Main_Navigation_View_Controller* navP = (Main_Navigation_View_Controller*)self.navigationController;
    [[navP getDrinkList] add_drink:newDrink];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0){return 2;}
    else {return 1;}
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    // Gets called before the textfield closes
    [theTextField resignFirstResponder];
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    // This method creates each individual cell for the table view
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            nameField = [[UITextField alloc] initWithFrame:CGRectMake(180, 10, 120, 30)];
            nameField.tag = 1;
            nameField.keyboardType = UIKeyboardTypeAlphabet;
            nameField.returnKeyType = UIReturnKeyDone;
            [nameField setDelegate:self];
            [cell addSubview:nameField];
            cell.textLabel.text = @"Drink Name:";
        }
        if (indexPath.row == 1)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            acSlider = [[UISlider alloc] initWithFrame:CGRectMake(180, 10, 120, 30)];
            acSlider.tag = 1;
            [cell addSubview:acSlider];
            
            
              [acSlider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
            
            if( [drinkClass isEqualToString:@"liquor"])
            {
                [acSlider setMinimumValue:0];
                [acSlider setMaximumValue:100];
                [acSlider setValue:20];
                cell.textLabel.text = [[NSString alloc] initWithFormat:@"AC: %d Proof: %d", (int)acSlider.value, (int)acSlider.value*2 ];
            }
            else
            {
                if( [drinkClass isEqualToString:@"beer"])
                {
                    [acSlider setMinimumValue:0];
                    [acSlider setMaximumValue:15];
                    [acSlider setValue:4.2];
                }
                else if( [drinkClass isEqualToString:@"wine"])
                {
                    [acSlider setMinimumValue:0];
                    [acSlider setMaximumValue:16];
                    [acSlider setValue:11.5];
                }
                cell.textLabel.text = [[NSString alloc] initWithFormat:@" ALC. Content: %.1f", acSlider.value];
            }
            
        }
    }
    if (indexPath.section == 1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         cell.textLabel.text = @"Add to Drink List";
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // This method sets the header
    if( section == 0)
    {
        return @"Drink Information";
    }
    else
    {
        return @"";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    // This method sets the footers for the entire app
    if( section == 0)
    {
        return @"For drink name please name your drink. For example Nic's Firebomb. Then set the alcohol content.";
    }
    else
    {
        return @"Press to create your drink.";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This method decides what to do when a cell is selected
    if(indexPath.section == 0)
    {
        if( indexPath.row == 0)
        {
            [nameField becomeFirstResponder];
        }
    }
    
    if (indexPath.section == 1)
    {
        if ([nameField.text length] > 0)
        {
            drinkAC = [self.acSlider value];
            drinkToAdd = [[Drink alloc] init:drinkClass witharg2:nameField.text witharg3:drinkAC];
            if ([self.display isEqualToString:@"Add Mixed Drink"])
            {
                [drinkToAdd setMixed_drink_bit:true];
            }
            
            [self addToList:drinkToAdd];
            [self.navigationController popViewControllerAnimated:TRUE];
            [(ListOfDrinksViewController*)self.navigationController.topViewController addDrink:drinkToAdd];
            [(Main_Navigation_View_Controller*)self.navigationController save_data];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"You did not add a drink." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

            [self.navigationController popViewControllerAnimated:TRUE];
        }
    }
}

// Gets called when the slider changes to a new value
-(void)sliderChanged
{
    NSIndexPath *index = [NSIndexPath indexPathForItem:1 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
    
    if( [drinkClass isEqualToString:@"liquor"] )
    {
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"AC: %d Proof: %d", (int)acSlider.value, (int)acSlider.value*2 ];
    }
    else
    {
        cell.textLabel.text = [[NSString alloc] initWithFormat:@" ALC. Content: %.1f", acSlider.value];
    }
}

// Checks the textField to see if the text is an integer
-(BOOL)checkField:(UITextField*)textField
{
    int size = [textField.text length];
    
    if (size > 18)
    {
        return false;
    }
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [doneButton setAction:@selector(dismissKeyboard)];
    [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
    if( ![self checkField:textField])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must enter a shorter name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        nameField.text = @"";
        
    }
    
        cell.textLabel.text = @"Drink Name:";
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}
@end
