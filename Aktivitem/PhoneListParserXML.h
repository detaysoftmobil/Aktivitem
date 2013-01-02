//
//  PhoneListParserXML.h
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneListParserXML : NSObject <NSXMLParserDelegate>{
    
    
    NSString *personel;
    NSString *name;
    NSString *lastname;
    NSString *shortCall;
    NSString *email;
    NSString *workTel;
    NSString *privateTel;
    
    
    NSMutableString *currentString;
    BOOL saveString;
}
-(NSString*)parseXML;

@end
