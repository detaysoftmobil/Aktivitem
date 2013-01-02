//
//  CreateActivityCallXML.h
//  Aktivitem
//
//  Created by Tahir on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActivityInfo;

@interface CreateActivityCallXML : NSObject

@property(nonatomic, retain) NSMutableData *webData;
@property(assign) BOOL isConnectionFinished;

-(NSString*)callXML:(ActivityInfo*)_activity;
-(void)getXML:(ActivityInfo*)_activity;

@end
