//
//  FavorilerViewController.m
//  Aktivitem
//
//  Created by Tahir on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavorilerViewController.h"
#import "AktiviteOlusturViewController.h"
#import "FavorilerCell.h"
#import "FavoriteXMLParser.h"
#import "FavoriInfo.h"
#import "UserControl.h"
#import "CheckConnection.h"
@interface FavorilerViewController ()

@end

@implementation FavorilerViewController
@synthesize barBtn,table,activiytView,delegate,searchbar;

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
    [activiytView setHidden:NO];
    [activiytView startAnimating];
    
    row = [[FavoriInfo alloc] init];
    
    searchedData = [[NSMutableArray alloc] init];
   
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    [[FavoriInfo favoriArray] removeAllObjects];
    [[FavoriInfo locationArray] removeAllObjects];
    
   
    
    if ([CheckConnection internetConnection]) {
    // Here is the place where you should call your function.
    FavoriteXMLParser *xml = [[FavoriteXMLParser alloc] init];
    
    Activity *act = [[Activity alloc] init];
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"dd-MM-YYYY"];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    [xml parseXML:[UserControl getPernr] Date:[act trimDate: [dateformat stringFromDate:[NSDate date]]]];
    }
    
     templist = [[NSMutableArray alloc] init];
    [templist addObjectsFromArray:[FavoriInfo favoriArray]];
    
    [activiytView setHidden:YES];
    [activiytView stopAnimating];
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.table reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)backtoAktivitem:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
  	return [[FavoriInfo favoriArray] count];
}

// - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// // Return the number of sections.
// return 2;
// }


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
	
    FavorilerCell *cell = (FavorilerCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		//  cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		NSArray *toplevel = [[NSBundle mainBundle] loadNibNamed:@"FavorilerCell" owner:nil options:nil];
		
		for( id currentObject in toplevel){
			
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (FavorilerCell *) currentObject;
				break;
			}
		}
    }
    
    row = [[FavoriInfo favoriArray] objectAtIndex:indexPath.row];
    
    cell.title.text = row.projectName;
    cell.custname.text = row.customerName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    AktiviteOlusturViewController *locationViewController = [[AktiviteOlusturViewController alloc] init];
    row = [[FavoriInfo favoriArray] objectAtIndex:indexPath.row];
//    NSLog(@"%d",row.customer);

    [self dismissModalViewControllerAnimated:YES];
    [[self delegate] setTextt:row];
    [[self delegate] setIndex:[row.customer intValue]];
    
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
    //    [list removeAllObjects];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchbar.showsCancelButton = NO;
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [searchedData removeAllObjects];
    [[FavoriInfo favoriArray] removeAllObjects];
    
    NSString *trimAlltext = [searchText stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    NSString *search_text = [trimAlltext uppercaseString];
    
    if([search_text isEqualToString:@""] || search_text==nil){
        [[FavoriInfo favoriArray] addObjectsFromArray:templist];
        [self.table reloadData];
        return;
    }
    
    
    for (row in templist) {
        
        NSString *project = [row.customerName uppercaseString];
        NSString *projectText = [row.projectName uppercaseString];

        
        NSRange r_project = [project rangeOfString:search_text];
        NSRange r_projectText = [projectText rangeOfString:search_text];

        
        
        if (r_project.location != NSNotFound || r_projectText.location != NSNotFound) {
            
            if (r_project.location == 0 || r_projectText.location == 0) {
                [searchedData addObject:row];
            }
        }
    }
    
  
    
    [[FavoriInfo favoriArray] addObjectsFromArray:searchedData];
    [self.table reloadData];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    @try {
        [[FavoriInfo favoriArray] removeAllObjects];
        [[FavoriInfo favoriArray] addObjectsFromArray:templist];
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
