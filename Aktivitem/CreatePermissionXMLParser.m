//
//  CreatePermissionXMLParser.m
//  Aktivitem
//
//  Created by Detay on 11/30/12.
//
//

#import "CreatePermissionXMLParser.h"
#import "UserControl.h"

static CreatePermissionXMLParser *myCreatePermissionXMLParser;

@implementation CreatePermissionXMLParser
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
    else if ([elementName isEqualToString:@"faultstring"])
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
    
    if ([elementName isEqualToString:@"faultstring"])
    {
        responseMessage = [[NSString alloc]initWithString:currentString];
    }
}

#pragma mark -instance
+(CreatePermissionXMLParser*)getCreatePermissionXMLParser {
    if (!myCreatePermissionXMLParser) {
        myCreatePermissionXMLParser =[[super allocWithZone:NULL]init];
    }
    return myCreatePermissionXMLParser;
}

@end
