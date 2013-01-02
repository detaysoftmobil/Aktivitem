//
//  PhoneListViewController.h
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneInfo.h"

@interface PhoneListViewController : UIViewController<UITableViewDelegate,UISearchBarDelegate>{
    
    PhoneInfo *row;
    PhoneInfo *searchedrow;
    
    NSMutableArray *searchedData;
    NSMutableArray *templist;
}
@property(nonatomic,retain)IBOutlet UITableView *table;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain)IBOutlet UISearchBar *searchbar;
@property(nonatomic,assign)BOOL isFirstEntered;

@end
