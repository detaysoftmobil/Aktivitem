//
//  ActivityCallXML.h
//  Aktivitem
//
//  Created by Tahir on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityCallXML : NSObject


@property(nonatomic, retain) NSMutableData *webData;
@property(assign) BOOL isConnectionFinished;

-(NSString*)callXML:(NSString*)_personelNumber HighDate:(NSString*)_hdate LowDate:(NSString*)_ldate;
-(void)getXML:(NSString*)_personelNumber HighDate:(NSString*)_hdate LowDate:(NSString*)_ldate;

@end
