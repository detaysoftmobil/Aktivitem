//
//  PermissionAllListViewController.h
//  Aktivitem
//
//  Created by Detay on 11/28/12.
//
//

#import <UIKit/UIKit.h>

@interface PermissionAllListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITabBarDelegate>
{
    IBOutlet UITableView *myTableView;
    IBOutlet UITabBar *myTabbar;
    
    IBOutlet UIActivityIndicatorView *activtyLoading;
}

@property(nonatomic,retain) NSString *permissionCreateStatus;

+(PermissionAllListViewController*)getPermissionAllListViewController;
@end
