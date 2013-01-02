//
//  PhoneListViewController.m
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhoneListViewController.h"
#import "PhoneDetailViewController.h"
#import "PhoneListCell.h"
#import "PhoneListParserXML.h"
#import "PhoneInfo.h"
#import "CheckConnection.h"

@interface PhoneListViewController ()

@end

@implementation PhoneListViewController;
@synthesize table,indicator,searchbar,isFirstEntered;

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
    
    self.title = @"Detay Personel";
    [self.navigationItem.backBarButtonItem setTitle:@"Geri"];
    
    searchedData = [[NSMutableArray alloc] init];
    
    [[PhoneInfo PhoneListArray] removeAllObjects];
     [indicator startAnimating];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![CheckConnection internetConnection]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([CheckConnection internetConnection]) {
       
        if (isFirstEntered) {
         PhoneListParserXML *callXML = [[PhoneListParserXML alloc] init];
         [callXML parseXML];
        
         templist = [[NSMutableArray alloc] init];
         [templist addObjectsFromArray:[PhoneInfo PhoneListArray]];
          isFirstEntered = false;
        }
    }

     [indicator stopAnimating];
    [self.table reloadData];
    NSLog(@"%d",[[PhoneInfo PhoneListArray] count]);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //  	return [list count];
    return [[PhoneInfo PhoneListArray] count];
}

// - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// // Return the number of sections.
// return 2;
// }


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
	
    PhoneListCell *cell = (PhoneListCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		//  cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		NSArray *toplevel = [[NSBundle mainBundle] loadNibNamed:@"PhoneListCell" owner:nil options:nil];
		
		for( id currentObject in toplevel){
			
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (PhoneListCell *) currentObject;
				break;
			}
		}
		
		
    }
    
    row = [[PhoneInfo PhoneListArray] objectAtIndex:indexPath.row];
    cell.name.text = [row.name stringByAppendingFormat:@" %@",row.lastname];
    cell.pernr.text = row.shortCall;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    row = [[PhoneInfo PhoneListArray] objectAtIndex:indexPath.row];
    PhoneDetailViewController *phoneDetailViewController = [[PhoneDetailViewController alloc] init];
    phoneDetailViewController.pernr = [row.personel intValue];
    [self.navigationController pushViewController:phoneDetailViewController animated:YES];
    [phoneDetailViewController release];
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

#pragma mark -
#pragma mark Search Bar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchbar.showsCancelButton = YES;
    searchbar.autocorrectionType = UITextAutocorrectionTypeNo;
    [searchbar setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
    //    [list removeAllObjects];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
     searchbar.showsCancelButton = NO;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [searchedData removeAllObjects];
    [[PhoneInfo PhoneListArray] removeAllObjects];
    
    NSString *trimAlltext = [searchText stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    NSString *search_text = [trimAlltext uppercaseString];
    
    if([search_text isEqualToString:@""] || search_text==nil){
        [[PhoneInfo PhoneListArray] addObjectsFromArray:templist];
        [self.table reloadData];
        return;
    }
    
    for (row in templist) {
        NSString *name = [row.name uppercaseString];
        NSString *lastname = [row.lastname uppercaseString];
        NSString *shortCall = [row.shortCall uppercaseString];
        NSString *workNo = [row.workTel uppercaseString];
        NSString *privateNo = [row.privateTel uppercaseString];
        NSString *nameLastname = [[name stringByAppendingFormat:@" %@",lastname] uppercaseString];
        
        NSRange r_name = [name rangeOfString:search_text];
        NSRange r_lastname = [lastname rangeOfString:search_text];
        NSRange r_shortCall = [shortCall rangeOfString:search_text];
        NSRange r_nameLastname = [nameLastname rangeOfString:search_text];
        NSRange r_workno = [workNo rangeOfString:search_text];
        NSRange r_privateNo = [privateNo rangeOfString:search_text];
        
        if (r_name.location != NSNotFound || r_shortCall.location != NSNotFound || r_lastname.location != NSNotFound || r_nameLastname.location != NSNotFound || r_workno.location != NSNotFound || r_privateNo.location != NSNotFound) {
            
            if (r_name.location == 0 || r_shortCall.location == 0 || r_lastname.location == 0 || r_nameLastname.location == 0 || r_workno.location == 0 || r_privateNo.location == 0) {
                [searchedData addObject:row];
            }
        }
    }
    
    
    [[PhoneInfo PhoneListArray] addObjectsFromArray:searchedData];
    [self.table reloadData];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    @try {
        [[PhoneInfo PhoneListArray] removeAllObjects];
        [[PhoneInfo PhoneListArray] addObjectsFromArray:templist];
        [self.table reloadData];
    }
    @catch (NSException *exception) {
        
    }
    
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}



@end
