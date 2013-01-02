//
//  UserControl.m
//  Aktivitem
//
//  Created by Tahir on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserControl.h"

@implementation UserControl

static NSString *username;
static NSString *password;
static NSString *pernr;

+(NSString*)getUsername{
    return username;
}
+(void)setUsername:(NSString*)_username{
    if (username!=_username) {
        username = nil;
        username = [_username retain];
    }
}
+(NSString*)getPassword{
    return password;
}
+(void)setPassword:(NSString*)_password{
    if (password != _password) {
        password = nil;
        password = [_password retain];
    }
}
+(NSString*)getPernr{
    return pernr;
}
+(void)setPernr:(NSString*)_pernr{
    if (pernr != _pernr) {
        pernr = nil;
        pernr = [_pernr retain];
    }
}

@end
