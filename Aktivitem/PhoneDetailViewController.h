//
//  PhoneDetailViewController.h
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneInfo.h"

@interface PhoneDetailViewController : UIViewController<UITableViewDataSource>{
    PhoneInfo *phoneInfo;
}

@property(nonatomic,assign)int pernr;
@property(nonatomic,retain)IBOutlet UILabel *name_label;

@end
