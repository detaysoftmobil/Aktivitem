//
//  UserControlCallXML.h
//  Aktivitem
//
//  Created by Tahir on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserControlCallXML : NSObject

@property(nonatomic, retain) NSMutableData *webData;
@property(assign) BOOL isConnectionFinished;

-(NSString*)callXML:(NSString*)_username Password:(NSString*)_password;
-(void)getXML:(NSString*)_username Password:(NSString*)_password;

@end
