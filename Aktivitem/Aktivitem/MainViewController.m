//
//  MainViewController.m
//  Aktivitem
//
//  Created by Tahir on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "ListemViewController.h"
#import "Mainclass.h"
#import "Calendar.h"
#import "MaintableCell.h"
#import "ActivityXMLParser.h"
#import "Activity.h"



@interface MainViewController (){
    int rowValue;
    
    Activity *activity;
}

@end

@implementation MainViewController
@synthesize basTarihiTextfield,bitisTarihiTextfield,datePicker;


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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mainclass = [[Mainclass alloc] init];
    calendar = [[Calendar alloc] init];
    
   
    self.navigationController.navigationBar.tintColor = [mainclass navigationBarColor:0 R:40 B:66];

    
    
    list = [[NSMutableArray alloc] init];
    [list addObject:@"Bugün"];
    [list addObject:@"Önceki Gün"];
    [list addObject:@"Bu Hafta"];
    [list addObject:@"Bu Ay"];
    [list addObject:@"Geçen Hafta"];
    [list addObject:@"Geçen Ay"];
    [list addObject:@"Diğer"];
    
    // Select current month
    rowValue = 3;
    
    [basTarihiTextfield setDelegate:self];
    [bitisTarihiTextfield setDelegate:self];
     
    UIBarButtonItem *runButton = [[UIBarButtonItem alloc] initWithTitle:@"Listele" style:UIBarButtonSystemItemAction target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = runButton;
    self.title = @"Aktivitem";
    
    
    // Current month
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"dd-MM-YYYY"];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    range1 = [dateformat stringFromDate:[calendar dayWeekMonth:3]];
    range2 = [calendar getMonthRange:[calendar dayWeekMonth:3]];
    basTarihiTextfield.text = range1;
    bitisTarihiTextfield.text = range2;
     [self.navigationController.navigationBar setHidden:NO];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)refresh{
    
    
    [datePicker setHidden:YES];
    ListemViewController *listemViewController = [[ListemViewController alloc] init];
    [Activity setHighDate:bitisTarihiTextfield.text];
    [Activity setLowDate:basTarihiTextfield.text];
    [self.navigationController pushViewController:listemViewController animated:YES];
    [listemViewController release];
    
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:basTarihiTextfield]) {
        textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        bitisTarihiTextfield.backgroundColor = [UIColor whiteColor];
    }
    if ([textField isEqual:bitisTarihiTextfield]) {
        textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        basTarihiTextfield.backgroundColor = [UIColor whiteColor];
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField returnKeyType] == UIReturnKeyDefault) {
        [textField resignFirstResponder];
    }    
    
    return YES;
}

-(IBAction)datePickerText:(id)sender{

    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
	[dateformat setDateFormat:@"dd-MM-yyyy"];    
  
    
    if (field == bitisTarihiTextfield) {
        bitisTarihiTextfield.text = [NSString stringWithFormat:@"%@",[dateformat stringFromDate:[datePicker date]]];
    }
    else {
        basTarihiTextfield.text = [NSString stringWithFormat:@"%@",[dateformat stringFromDate:[datePicker date]]];
    }
    
    
}
-(IBAction)selectedTextField:(id)sender{
    [sender resignFirstResponder];
    [datePicker setHidden:NO];
    
    field = (UITextField*)sender;
}
-(IBAction)hidePickerDate:(id)sender{
    [datePicker setHidden:YES];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
  	return [list count];
}

// - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// // Return the number of sections.
// return 2;
// }


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
	
	  MaintableCell *cell = (MaintableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		//  cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		NSArray *toplevel = [[NSBundle mainBundle] loadNibNamed:@"MaintableCell" owner:nil options:nil];
		
		for( id currentObject in toplevel){
			
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (MaintableCell *) currentObject;
				break;
			}
		}
		
		
    }
    
    cell.text.text = [list objectAtIndex:indexPath.row];
    
    if (indexPath.row == rowValue) {
         [cell.checked setHidden:NO]; 
    }
    else {
         [cell.checked setHidden:YES]; 
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    [datePicker setHidden:YES];
    rowValue = indexPath.row;
    [tableView reloadData];
    
    NSDate *date;
    range1 = @"";
    range2 = @"";
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"dd-MM-YYYY"];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    [basTarihiTextfield setEnabled:FALSE];
    [bitisTarihiTextfield setEnabled:FALSE];
    
    if (indexPath.row == 0) {
        range1 = [dateformat stringFromDate:[calendar dayWeekMonth:0]];
        range2 = range1;
    }
    else if (indexPath.row == 1) {
        range1 = [dateformat stringFromDate:[calendar dayWeekMonth:1]];
        range2 = range1;
    }
    else if (indexPath.row == 2) {
        range1 = [dateformat stringFromDate:[calendar dayWeekMonth:2]];
        date = [calendar dayWeekMonth:2];
        range2 = [dateformat stringFromDate:[date dateByAddingTimeInterval:60*60*24*6]];
        
    }
    else if (indexPath.row == 3) {
        range1 = [dateformat stringFromDate:[calendar dayWeekMonth:3]];
        range2 = [calendar getMonthRange:[calendar dayWeekMonth:3]];
    }
    else if (indexPath.row == 4) {
        range1 = [dateformat stringFromDate:[calendar dayWeekMonth:4]];
        date = [calendar dayWeekMonth:4];
        range2 = [dateformat stringFromDate:[date dateByAddingTimeInterval:60*60*24*6]];
    }
    else if (indexPath.row == 5) {
        range1 = [dateformat stringFromDate:[calendar dayWeekMonth:5]];
        range2 = [calendar getMonthRange:[calendar dayWeekMonth:5]];
    }
    else {
         
        [basTarihiTextfield setEnabled:TRUE];
        [bitisTarihiTextfield setEnabled:TRUE];
    }
    
    basTarihiTextfield.text = range1;
    bitisTarihiTextfield.text = range2;
    
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
