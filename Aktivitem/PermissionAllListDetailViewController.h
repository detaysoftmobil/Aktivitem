//
//  PermissionAllListDetailViewController.h
//  Aktivitem
//
//  Created by Detay on 12/3/12.
//
//

#import <UIKit/UIKit.h>
#import "PermissionStruct.h"

@interface PermissionAllListDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UITextField *txtPermissionType;
    IBOutlet UITextField *txtPermissionStyle;
    IBOutlet UITextField *txtBegdaDate;
    IBOutlet UITextField *txtEnddaDate;
    IBOutlet UITextField *txtResultDate;
    IBOutlet UITextView *textViewAciklama;
    
    
}

@property(nonatomic,retain) PermissionStruct *selectedPermission;

@property(assign)BOOL ustBirimKontrol;

@property(nonatomic,retain)IBOutlet UIButton *btnOnayla;
@property(nonatomic,retain)IBOutlet UIButton *btnRed;

-(IBAction)btnOnayla:(id)sender;
-(IBAction)btnRed:(id)sender;

@end
