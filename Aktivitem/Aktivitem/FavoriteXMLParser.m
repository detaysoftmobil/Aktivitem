//
//  FavoriteXMLParser.m
//  Aktivitem
//
//  Created by Tahir on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteXMLParser.h"
#import "FavoriteCallXML.h"
#import "FavoriInfo.h"


@implementation FavoriteXMLParser


-(NSString*)parseXML:(NSString*)_personelNumber Date:(NSString*)_date{
    
    FavoriteCallXML *call = [[FavoriteCallXML alloc]init];
    NSString *getXml = [[NSString alloc]initWithString:[call callXML:_personelNumber Date:_date]];
    
    BOOL success;

    
    // initialize current string
    currentString = [NSMutableString string];
    [[FavoriInfo favoriArray] removeAllObjects];
    [[FavoriInfo locationArray] removeAllObjects];
    
    // set save string NO
    saveString = NO;
    index = -1;
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[getXml dataUsingEncoding: NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:YES];
    success = [parser parse];
	
    currentString = nil;
//    [parser release];
    
    // Handling if there is no connection
    if ([getXml isEqualToString:@"90"] || [getXml isEqualToString:@""]) {
        error = @"90";
    }
    return error;
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict 
{
    
    if ([elementName isEqualToString:@"EFavorite"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Customer"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Project"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"CustomerName"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"ProjectName"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Locations"])
    {
        [currentString setString:@""];
        saveString = NO;
    }
    else if ([elementName isEqualToString:@"MANDT"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"KUNNR"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"LOCNO"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"ADR01"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"ADR02"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"MTYPE"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"DEFLT"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"CUNAM"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"CDATE"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"CUZET"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"LUNCH"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"DISTN"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"BRDGE"])
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
    
    
    if ([elementName isEqualToString:@"EFavorite"])
    {
        
    }
    else if ([elementName isEqualToString:@"Customer"])
    {
      index ++;
      customer = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Project"])
    {
      project = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"CustomerName"])
    {
      customerName = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"ProjectName"])
    {
       projectName = [[NSString alloc]initWithString:currentString];
        
        FavoriInfo *favoriInfo = [[FavoriInfo alloc] init];
        favoriInfo.customer = customer;
        favoriInfo.project = project;
        favoriInfo.customerName = customerName;
        favoriInfo.projectName = projectName;
        favoriInfo.fid = index;
        [[FavoriInfo favoriArray] addObject:favoriInfo];
//        [favoriInfo release];
        NSLog(@"%d",index);
        
    }
    else if ([elementName isEqualToString:@"Locations"])
    {
        
    }
    else if ([elementName isEqualToString:@"MANDT"])
    {
        mandt = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"KUNNR"])
    {
        kunnr = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"LOCNO"])
    {
        locno = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"ADR01"])
    {
       adr01 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"ADR02"])
    {
       adr02 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"MTYPE"])
    {
       mtype = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"DEFLT"])
    {
       deflt = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"CUNAM"])
    {
       cunam = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"CDATE"])
    {
       cdate = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"CUZET"])
    {
      cuzet = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"LUNCH"])
    {
       lunch = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"DISTN"])
    {
        distn = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"BRDGE"])
    {
        brdge = [[NSString alloc]initWithString:currentString];
        
        LocationInfo *locationInfo = [[LocationInfo alloc] init];
        locationInfo.mandt = mandt;
        locationInfo.kunnr = kunnr;
        locationInfo.locno = locno;
        locationInfo.adr01 = adr01;
        locationInfo.adr02 = adr02;
        locationInfo.mtype = mtype;
        locationInfo.deflt = deflt;
        locationInfo.cunam = cunam;
        locationInfo.cdate = cdate;
        locationInfo.cuzet = cuzet;
        locationInfo.lunch = lunch;
        locationInfo.distn = distn;
        locationInfo.brdge = brdge;
        locationInfo.ID = index;
        [[FavoriInfo locationArray] addObject:locationInfo];
//        [locationInfo release];
        NSLog(@"%d",index);
        
        
    }

    
    
}


@end
