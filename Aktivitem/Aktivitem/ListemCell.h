//
//  ListemCell.h
//  Aktivitem
//
//  Created by Tahir on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListemCell : UITableViewCell

@property(nonatomic,retain)IBOutlet UIImageView *icon;
@property(nonatomic,retain)IBOutlet UILabel *dayLabel;
@property(nonatomic,retain)IBOutlet UILabel *dateLabel;
@property(nonatomic,retain)IBOutlet UILabel *activiythourLabel;
@property(nonatomic,retain)IBOutlet UILabel *invoiceLabel;
@property(nonatomic,retain)IBOutlet UILabel *detailLabel;


@end
