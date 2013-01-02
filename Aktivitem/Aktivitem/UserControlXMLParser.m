//
//  UserControlXMLParser.m
//  Aktivitem
//
//  Created by Tahir on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserControlXMLParser.h"
#import "UserControlCallXML.h"
#import "UserControl.h"

@implementation UserControlXMLParser{
    NSString *responseMessage;
}

-(NSString*)parseXML:(NSString*)_username Password:(NSString*)_password{
    
    UserControlCallXML *call = [[UserControlCallXML alloc]init];
    NSString *getXml = [[NSString alloc]initWithString:[call callXML:_username Password:_password]];
    
    
    BOOL success;
    
    responseMessage = [[NSString alloc] init];
    // initialize current string
    currentString = [NSMutableString string];
    
    // set save string NO
    saveString = NO;
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[getXml dataUsingEncoding: NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:YES];
    success = [parser parse];
	
    currentString = nil;
    [parser release];
    
    if ([getXml isEqualToString:@"AuthEr"]) {
        responseMessage = @"Kullanıcı Adı veya Şifre Hatalı!";
    }
    
    return responseMessage;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict 
{
    if ([elementName isEqualToString:@"EMessage"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"EPernr"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (saveString) [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
    if ([elementName isEqualToString:@"EMessage"])
    {
        responseMessage = [[NSString alloc]initWithString:currentString];
        
    }
    else if ([elementName isEqualToString:@"EPernr"])
    {
        [UserControl setPernr:[[NSString alloc]initWithString:currentString]];
    }
}


@end
