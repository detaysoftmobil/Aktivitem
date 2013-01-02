//
//  ListemViewController.h
//  Aktivitem
//
//  Created by Tahir on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface ListemViewController : UIViewController{
    
    NSMutableArray *list;
    ActivityInfo *row;
}
@property(nonatomic,retain)IBOutlet UITableView *table;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *activiytView;
@end
