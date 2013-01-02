//
//  UserControl.h
//  Aktivitem
//
//  Created by Tahir on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserControl : NSObject


+(NSString*)getUsername;
+(void)setUsername:(NSString*)_username;
+(NSString*)getPassword;
+(void)setPassword:(NSString*)_password;
+(NSString*)getPernr;
+(void)setPernr:(NSString*)_pernr;

@end
