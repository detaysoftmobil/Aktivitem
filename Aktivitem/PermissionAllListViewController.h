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
    
    IBOutlet UITabBarItem *tb1;
    IBOutlet UITabBarItem *tb2;
    IBOutlet UITabBarItem *tb3;
    IBOutlet UITabBarItem *tb4;
    IBOutlet UIActivityIndicatorView *activtyLoading;
}


@property(nonatomic,retain) IBOutlet UITableView *myTableView;
@property(nonatomic,retain) NSString *permissionCreateStatus;

+(PermissionAllListViewController*)getPermissionAllListViewController;
@end
