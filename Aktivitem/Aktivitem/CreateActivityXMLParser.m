//
//  CreateActivityXMLParser.m
//  Aktivitem
//
//  Created by Tahir on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateActivityXMLParser.h"
#import "CreateActivityCallXML.h"
@implementation CreateActivityXMLParser{
    
    NSString *responseMessage;
}


-(NSString*)parseXML:(ActivityInfo*)_activity{
    
    CreateActivityCallXML *call = [[CreateActivityCallXML alloc]init];
    NSString *getXml = [[NSString alloc]initWithString:[call callXML:_activity]];
    
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
//    [parser release];
    
    return responseMessage;
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict 
{
    if ([elementName isEqualToString:@"EMessage"])
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
}

@end
