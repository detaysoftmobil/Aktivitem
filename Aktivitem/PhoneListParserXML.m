//
//  PhoneListParserXML.m
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhoneListParserXML.h"
#import "PhoneListCallXML.h"
#import "PhoneInfo.h"

@implementation PhoneListParserXML{
    NSString *responseMessage;
}


-(NSString*)parseXML{
    
    PhoneListCallXML *call = [[PhoneListCallXML alloc]init];
    NSString *getXml = [[NSString alloc]initWithString:[call callXML]];
    
    
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
  
    return responseMessage;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict 
{
    if ([elementName isEqualToString:@"Personel"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Adi"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Soyadi"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Kisakod"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Email"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"TelSirket"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"TelOzel"])
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
    if ([elementName isEqualToString:@"Personel"])
    {
        personel = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Adi"])
    {
        name = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Soyadi"])
    {
      lastname = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Kisakod"])
    {
      shortCall = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Email"])
    {
        email = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"TelSirket"])
    {
        workTel = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"TelOzel"])
    {
       privateTel = [[NSString alloc]initWithString:currentString];
        
        PhoneInfo *phoneInfo = [[PhoneInfo alloc] init];
        phoneInfo.personel   = personel;
        phoneInfo.name       = name;
        phoneInfo.lastname   = lastname;
        phoneInfo.shortCall  = shortCall;
        phoneInfo.email      = email;
        phoneInfo.workTel    = workTel;
        phoneInfo.privateTel = privateTel;
        [[PhoneInfo PhoneListArray] addObject:phoneInfo];
        [phoneInfo release];
    }
}


@end
