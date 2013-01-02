//
//  CreatePermissionXMLParser.h
//  Aktivitem
//
//  Created by Detay on 11/30/12.
//
//

#import <Foundation/Foundation.h>

@interface CreatePermissionXMLParser : NSObject<NSXMLParserDelegate>{
    
    NSMutableString *currentString;
    NSString *errorMessage;
    BOOL saveString;
}

@property(nonatomic,retain)NSString *errorMessage;

-(NSString*)parseXML:(NSString*)xmlDataStr;

+(CreatePermissionXMLParser*)getCreatePermissionXMLParser;
@end
