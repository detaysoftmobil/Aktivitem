//
//  PhoneListCell.h
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneListCell : UITableViewCell

@property(nonatomic,retain)IBOutlet UILabel *name;
@property(nonatomic,retain)IBOutlet UILabel *pernr;
@property(nonatomic,retain)IBOutlet UIImageView *userIcon;

@end
