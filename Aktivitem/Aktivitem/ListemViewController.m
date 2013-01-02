//
//  ListemViewController.m
//  Aktivitem
//
//  Created by Tahir on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListemViewController.h"
#import "AktiviteOlusturViewController.h"
#import "ActivityXMLParser.h"
#import "ListemCell.h"
#import "Calendar.h"
#import "UserControl.h"
#import "CheckConnection.h"

@interface ListemViewController ()

@end

@implementation ListemViewController
@synthesize table,activiytView;

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
    
    self.title = @"Kokpit";
    
    
    [activiytView setHidden:NO];
    [activiytView startAnimating];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Yeni" style:UIBarButtonSystemItemAdd target:self action:@selector(newAcitivity)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [[ActivityInfo activityArray] removeAllObjects];
    [[FavoriInfo locationArray] removeAllObjects];
    
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
    
    [[ActivityInfo activityArray] removeAllObjects];
    [[FavoriInfo locationArray] removeAllObjects];
    
    if ([CheckConnection internetConnection]) {
    Activity *act = [[Activity alloc] init];
    ActivityXMLParser *xml = [[ActivityXMLParser alloc] init];
    [xml parseXML:[UserControl getPernr] HighDate: [act trimDate:[Activity getHighDate]] LowDate: [act trimDate:[Activity getLowDate]]];
    }
        
    [activiytView setHidden:YES];
    [activiytView stopAnimating];
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.table reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)newAcitivity{
    
    AktiviteOlusturViewController *aktiviteOlusturViewController = [[AktiviteOlusturViewController alloc] init];
    aktiviteOlusturViewController.newActivity = YES;
    [self.navigationController pushViewController:aktiviteOlusturViewController animated:YES];
    [aktiviteOlusturViewController release];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//  	return [list count];
    return [[ActivityInfo activityArray] count];
}

// - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// // Return the number of sections.
// return 2;
// }


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
	
    ListemCell *cell = (ListemCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		//  cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		NSArray *toplevel = [[NSBundle mainBundle] loadNibNamed:@"ListemCell" owner:nil options:nil];
		
		for( id currentObject in toplevel){
			
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (ListemCell *) currentObject;
				break;
			}
		}
		
		
    }
    
   
        row = [[ActivityInfo activityArray] objectAtIndex:indexPath.row];
        cell.dateLabel.text = row.Begda;
        cell.activiythourLabel.text = row.Wrhour;
        cell.invoiceLabel.text = row.Akhour;
        cell.detailLabel.text = row.ProjectName;
        cell.dayLabel.text = [[row.Begda componentsSeparatedByString:@"-"] lastObject];
    
    if (![row.Stat2 isEqualToString:@""] || ![row.Stat3 isEqualToString:@""] || ![row.Stat4 isEqualToString:@""] || ![row.Stat5 isEqualToString:@""]) {
        cell.icon.image = [UIImage imageNamed:@"kırmızı.png"];
    }
    else if (![row.Status isEqualToString:@""]) {
        cell.icon.image = [UIImage imageNamed:@"yesil.png"];
    }
    else {
        cell.icon.image = [UIImage imageNamed:@"sari.png"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AktiviteOlusturViewController *aktiviteOlusturViewController = [[AktiviteOlusturViewController alloc] init];
    aktiviteOlusturViewController.activityInfo = [[ActivityInfo activityArray] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:aktiviteOlusturViewController animated:YES];
    [aktiviteOlusturViewController release];
    
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
