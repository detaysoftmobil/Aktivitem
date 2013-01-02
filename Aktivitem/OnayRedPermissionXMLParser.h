//
//  OnayRedPermissionXMLParser.h
//  Aktivitem
//
//  Created by Detay on 12/19/12.
//
//

#import <Foundation/Foundation.h>

@interface OnayRedPermissionXMLParser : NSObject<NSXMLParserDelegate>{
    
    NSMutableString *currentString;
    NSString *errorMessage;
    BOOL saveString;
}

@property(nonatomic,retain)NSString *errorMessage;

-(NSString*)parseXML:(NSString*)xmlDataStr;

+(OnayRedPermissionXMLParser*)getOnayRedPermissionXMLParser;
@end
