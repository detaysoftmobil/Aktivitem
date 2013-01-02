//
//  LoginViewController.h
//  Aktivitem
//
//  Created by Tahir on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>


@property(nonatomic,retain)IBOutlet UIButton *loginBtn;
@property(nonatomic,retain)IBOutlet UITextField *username_textfield;
@property(nonatomic,retain)IBOutlet UITextField *password_textfield;
@property(nonatomic,retain)IBOutlet UIImageView *detaylogo_imageview;
@property(nonatomic,retain)IBOutlet UIButton *checkbox_button;
@property(nonatomic,retain)IBOutlet UILabel *remember_label;

@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *indicator;

-(IBAction)login:(id)sender;
-(IBAction)remember:(id)sender;

@end
