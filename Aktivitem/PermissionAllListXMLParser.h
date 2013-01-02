//
//  PermissionAllListXMLParser.h
//  Aktivitem
//
//  Created by Detay on 12/3/12.
//
//

#import <Foundation/Foundation.h>

#import "PermissionStruct.h"

@interface PermissionAllListXMLParser : NSObject<NSXMLParserDelegate>{
    
    NSMutableString *currentString;
    NSString *errorMessage;
    BOOL saveString;
    
}

@property(nonatomic,retain)NSMutableArray *PermissionStructArray;

@property(nonatomic,retain)NSString *errorMessage;

-(void)parseXML:(NSString*)xmlDataStr;

+(PermissionAllListXMLParser*)getPermissionAllListXMLParser;
@end
