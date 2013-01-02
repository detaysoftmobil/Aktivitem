//
//  PhoneListCallXML.h
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneListCallXML : NSObject

@property(nonatomic, retain) NSMutableData *webData;
@property(assign) BOOL isConnectionFinished;

-(NSString*)callXML;
-(void)getXML;

@end
