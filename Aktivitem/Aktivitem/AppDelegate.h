//
//  AppDelegate.h
//  Aktivitem
//
//  Created by Tahir on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *viewController;

@end
