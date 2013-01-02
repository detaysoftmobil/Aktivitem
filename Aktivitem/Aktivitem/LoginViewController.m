//
//  LoginViewController.m
//  Aktivitem
//
//  Created by Tahir on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "Mainclass.h"
#import "FavoriInfo.h"
#import "UserControlXMLParser.h"
#import "UserControl.h"
#import "Activity.h"
#import "CheckConnection.h"
#import "MenuViewController.h"
#import "PhoneListViewController.h"

@interface LoginViewController (){
    
    UIImage *checked;
    UIImage *unchecked;
}

@end

@implementation LoginViewController
@synthesize loginBtn,username_textfield,password_textfield,detaylogo_imageview,checkbox_button,remember_label,indicator;

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
    
    Mainclass *mainclass = [[Mainclass alloc] init];
    self.navigationController.navigationBar.tintColor = [mainclass navigationBarColor:0 R:40 B:66];
    
    [username_textfield setDelegate:self];
    [password_textfield setDelegate:self];
    
    CGRect basketTopFrame2 = detaylogo_imageview.frame;
    basketTopFrame2.origin.y = 15;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.50];
    [UIView setAnimationDelay:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    detaylogo_imageview.frame = basketTopFrame2;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [username_textfield setAlpha:1];
    [password_textfield setAlpha:1];
    [loginBtn setAlpha:1];
    [checkbox_button setAlpha:1];
    [remember_label setAlpha:1];
    [UIView commitAnimations];
    
    checked = [UIImage imageNamed:@"checkbox_full.png"];
    unchecked = [UIImage imageNamed:@"checkbox_empty.png"];
    
    NSString *str = [self getUserPasswordFromPlist];
    
    if (![str isEqualToString:@""]) {
        [checkbox_button setImage:checked forState:UIControlStateNormal];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}
-(NSString*)getUserPasswordFromPlist{

    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *documentsPath = [paths objectAtIndex:0];
   
    NSString *plistPath = 
    [documentsPath stringByAppendingPathComponent:@"userInfo.plist"];
    
  
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) 
    {
     
        plistPath = 
        [[NSBundle mainBundle] pathForResource:@"userInfo" ofType:@"plist"];
    }  
    
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;

    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!temp) 
    {
 
    }
    
    username_textfield.text = [temp objectForKey:@"username"];
    password_textfield.text = [temp objectForKey:@"password"];
    NSString *str = [temp objectForKey:@"username"];
    
    return str;
    
}
-(void)saveUserPassToPlist{
    
 
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths objectAtIndex:0];
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"userInfo.plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:username_textfield.text,password_textfield.text, nil] forKeys:[NSArray arrayWithObjects: @"username", @"password", nil]];
	NSString *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];

	if(plistData) 
	{
        [plistData writeToFile:plistPath atomically:YES];
    }
    else 
	{
       
        [error release];
    }

}
-(void)clearUserPassToPlist{
    
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths objectAtIndex:0];
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"userInfo.plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"", @"", nil] forKeys:[NSArray arrayWithObjects: @"username", @"password", nil]];
	NSString *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
	if(plistData) 
	{
        [plistData writeToFile:plistPath atomically:YES];
    }
    else 
	{
        [error release];
    }
    
}
-(IBAction)remember:(id)sender{

    if ([checkbox_button.imageView.image isEqual:checked]) {
        [checkbox_button setImage:unchecked forState:UIControlStateNormal];
        [self clearUserPassToPlist];
    }
    else {
        [self saveUserPassToPlist];
        [checkbox_button setImage:checked forState:UIControlStateNormal];
    }

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

-(IBAction)login:(id)sender{
    
    
    
    if ([CheckConnection internetConnection]) {
    
    
    [sender resignFirstResponder];
    [UserControl setUsername:username_textfield.text];
    [UserControl setPassword:password_textfield.text];
    
    if ([username_textfield.text isEqualToString:@""] || [password_textfield.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Kullanıcı Adı veya Şifre Giriniz" delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else {
        
        [indicator startAnimating];
        [self clearAllStaticVariables];

        UserControlXMLParser *userControlXMLParser = [[UserControlXMLParser alloc] init];
        NSString *returnMessage = [userControlXMLParser parseXML:username_textfield.text Password:password_textfield.text];
        
        NSLog(@"%@",returnMessage);
        if ([returnMessage isEqualToString:@""]) {
           
            MenuViewController *m = [[MenuViewController alloc] init];
            [self.navigationController pushViewController:m animated:YES];
            [m release];
        }
        else {
            [UserControl setPernr:@""];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:returnMessage delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        [indicator stopAnimating];
    }
    }

}
-(void)clearAllStaticVariables{
    
    [UserControl setPernr:@""];
    [[ActivityInfo activityArray] removeAllObjects];
    [[FavoriInfo favoriArray] removeAllObjects];
    [[FavoriInfo locationArray] removeAllObjects];
    
    
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField returnKeyType] == UIReturnKeyDefault) {
        [textField resignFirstResponder];
    }    
    
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    textField.text = [textField.text uppercaseString];
    [textField resignFirstResponder];
    return YES;
}

@end
