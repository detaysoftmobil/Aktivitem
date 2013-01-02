//
//  UserControlXMLParser.h
//  Aktivitem
//
//  Created by Tahir on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserControlXMLParser : NSObject<NSXMLParserDelegate>{
    
    NSMutableString *currentString;
    NSString *errorMessage;
    BOOL saveString;
}

-(NSString*)parseXML:(NSString*)_username Password:(NSString*)_password;

@end
