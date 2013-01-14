//
//  MenuViewController.m
//  Aktivitem
//
//  Created by Tahir on 9/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "PhoneListViewController.h"
#import "MainViewController.h"
#import "PermissionAllListViewController.h"

@interface MenuViewController (){
}
@end

@implementation MenuViewController

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goToApplication:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    
    PhoneListViewController *phoneListViewController;
    MainViewController *mainViewController;
    PermissionAllListViewController *permissionViewController;
    
    [self setTitle:@"Geri"];
    
    switch (button.tag) {
        case 0:
             phoneListViewController = [[PhoneListViewController alloc] init];
            phoneListViewController.isFirstEntered = TRUE;
            [self.navigationController pushViewController:phoneListViewController animated:YES];
            [phoneListViewController release];
            break;
        case 1:
             mainViewController = [[MainViewController alloc] init];
            [self.navigationController pushViewController:mainViewController animated:YES];
            [mainViewController release];
            break;
        case 3:
            permissionViewController = [[PermissionAllListViewController alloc] init];
            [self.navigationController pushViewController:permissionViewController animated:YES];
            [permissionViewController release];
            break;
        default:
            break;
    }
    
}
@end
