//
//  MainViewController.h
//  Aktivitem
//
//  Created by Tahir on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaintableCell.h"

@class Mainclass;
@class Calendar;

@interface MainViewController : UIViewController<UITableViewDelegate,UITextFieldDelegate>{
    Mainclass *mainclass;
    Calendar *calendar;

    NSMutableArray *list;
    NSString *range1;
    NSString *range2;
    UITextField *field;
}
@property(nonatomic,retain)IBOutlet UITextField *basTarihiTextfield;
@property(nonatomic,retain)IBOutlet UITextField *bitisTarihiTextfield;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;

-(IBAction)datePickerText:(id)sender;
@end
