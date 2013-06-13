//
//  PhoneDetailViewController.m
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhoneDetailViewController.h"
#import "PhoneInfo.h"
#import "DetayCell.h"

@interface PhoneDetailViewController ()

@end

@implementation PhoneDetailViewController
@synthesize pernr,name_label;

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
    
    for (int i=0; i < [[PhoneInfo PhoneListArray] count]; i++) {
        phoneInfo = [[PhoneInfo PhoneListArray] objectAtIndex:i];
        if (pernr == [phoneInfo.personel intValue]) {
            break;
        }
        
    }
    name_label.text = [phoneInfo.name stringByAppendingFormat:@" %@",phoneInfo.lastname];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return 4;
}

// - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// // Return the number of sections.
// return 2;
// }


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
	
    DetayCell *cell = (DetayCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		//  cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		NSArray *toplevel = [[NSBundle mainBundle] loadNibNamed:@"DetayCell" owner:nil options:nil];
		
		for( id currentObject in toplevel){
			
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (DetayCell *) currentObject;
				break;
			}
		}
		
		
    }
    cell.icon.image = [UIImage imageNamed:@"phone.png"];
    
    switch (indexPath.row) {
        case 0:
            cell.text.text = phoneInfo.email;
            cell.icon.image = [UIImage imageNamed:@"mail.png"];
            break;
        case 1:
            cell.text.text = phoneInfo.shortCall;
            break;
        case 2:
            [cell.expText setHidden:NO];
            cell.expText.text = @"İş :";
            cell.text.text = phoneInfo.workTel;
            break;
        case 3:
            [cell.expText setHidden:NO];
            cell.expText.text = @"Cep :";
            cell.text.text = phoneInfo.privateTel;
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            [self sendMail];
            break;
        case 1:
            [self makeCall:phoneInfo.shortCall];
            break;
        case 2:
            [self makeCall:phoneInfo.workTel];
            break;
        case 3:
           [self makeCall:phoneInfo.privateTel];
            break;
            
        default:
            break;
    }
}
-(void)sendMail
{
    NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
							[phoneInfo.email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
							[@"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
							[@"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
}
-(void)makeCall:(NSString *)_tel{
     NSString *number = [@"tel://" stringByAppendingString:_tel];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
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


@end
