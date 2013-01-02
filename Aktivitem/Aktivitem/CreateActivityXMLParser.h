//
//  CreateActivityXMLParser.h
//  Aktivitem
//
//  Created by Tahir on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActivityInfo;

@interface CreateActivityXMLParser : NSObject<NSXMLParserDelegate>{
    
    NSMutableString *currentString;
    NSString *errorMessage;
    BOOL saveString;
    
}

-(NSString*)parseXML:(ActivityInfo*)_activity;

@end
