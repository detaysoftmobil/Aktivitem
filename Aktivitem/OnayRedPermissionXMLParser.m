//
//  OnayRedPermissionXMLParser.m
//  Aktivitem
//
//  Created by Detay on 12/19/12.
//
//

#import "OnayRedPermissionXMLParser.h"
#import "UserControl.h"

static OnayRedPermissionXMLParser *myOnayRedPermissionXMLParser;
@implementation OnayRedPermissionXMLParser
{
    NSString *responseMessage;
}

@synthesize errorMessage;


-(NSString*)parseXML:(NSString*)xmlDataStr {
    BOOL success;
    
    responseMessage = [[NSString alloc] init];
    currentString = [NSMutableString string];
    saveString = NO;
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:
                           [xmlDataStr dataUsingEncoding: NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:YES];
    success = [parser parse];
	
    currentString = nil;
    [parser release];
    
    return responseMessage;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"Return"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Message"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (saveString)
        [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Return"]) {
        errorMessage = [[NSString alloc]initWithString:currentString];
    }
    
    if ([elementName isEqualToString:@"Message"])
    {
        responseMessage = [[NSString alloc]initWithString:currentString];
    }
}

#pragma mark -instance
+(OnayRedPermissionXMLParser*)getOnayRedPermissionXMLParser {
    if (!myOnayRedPermissionXMLParser) {
        myOnayRedPermissionXMLParser =[[super allocWithZone:NULL]init];
    }
    return myOnayRedPermissionXMLParser;
}

@end
