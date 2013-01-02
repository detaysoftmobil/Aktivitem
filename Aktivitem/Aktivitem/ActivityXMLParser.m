//
//  ActivityXMLParser.m
//  Aktivitem
//
//  Created by Tahir on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityXMLParser.h"
#import "ActivityCallXML.h"
#import "Activity.h"
#import "FavoriInfo.h"

@implementation ActivityXMLParser

-(NSString*)parseXML:(NSString*)_personelNumber HighDate:(NSString*)_hdate LowDate:(NSString*)_ldate{
    
    ActivityCallXML *call = [[ActivityCallXML alloc]init];
    NSString *getXml = [[NSString alloc]initWithString:[call callXML:_personelNumber HighDate:_hdate LowDate:_ldate]];
    
    BOOL success;
    
    
    // initialize current string
    currentString = [NSMutableString string];
//    [[ActivityInfo activityArray] removeAllObjects];
//     [[FavoriInfo locationArray] removeAllObjects];
    
    // set save string NO
    saveString = NO;
    index = -1;
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[getXml dataUsingEncoding: NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:YES];
    success = [parser parse];
	
    currentString = nil;
    [parser release];

    
    
    return error;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict 
{
    
    if ([elementName isEqualToString:@"TActivity"])
    {
        [currentString setString:@""];
        saveString = NO;
    }
    else if ([elementName isEqualToString:@"Pernr"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Begda"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Seqno"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Kunnr"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Prjno"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Wrhour"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Akhour"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Place"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Arfno"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Txt01"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Txt02"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Txt03"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Txt04"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Txt05"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Status"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Stat2"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Stat3"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Stat4"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Stat5"])
    {
        [currentString setString:@""];
        saveString = YES;
    }
    else if ([elementName isEqualToString:@"Locno"])
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
    if ([elementName isEqualToString:@"TActivity"])
    {
     
    }
    else if ([elementName isEqualToString:@"Pernr"])
    {
      index++;
      Pernr = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Begda"])
    {
       Begda = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Seqno"])
    {
     Seqno = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Kunnr"])
    {
     Kunnr = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Prjno"])
    {
       Prjno = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Wrhour"])
    {
     Wrhour = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Akhour"])
    {
       Akhour = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Place"])
    {
      Place = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Arfno"])
    {
      Arfno = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Txt01"])
    {
       Txt01 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Txt02"])
    {
       Txt02 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Txt03"])
    {
       Txt03 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Txt04"])
    {
       Txt04 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Txt05"])
    {
      Txt05 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Status"])
    {
      Status = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Stat2"])
    {
      Stat2 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Stat3"])
    {
       Stat3 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Stat4"])
    {
       Stat4 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Stat5"])
    {
       Stat5 = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"Locno"])
    {
      Locno = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"CustomerName"])
    {
      CustomerName = [[NSString alloc]initWithString:currentString];
    }
    else if ([elementName isEqualToString:@"ProjectName"])
    {
       ProjectName = [[NSString alloc]initWithString:currentString];
       NSRange range;
        
        ActivityInfo *activityInfo = [[ActivityInfo alloc] init];
        activityInfo.Pernr = Pernr;
        activityInfo.Begda = Begda;
        activityInfo.Seqno = Seqno;
        activityInfo.Kunnr = Kunnr;
        activityInfo.Prjno = Prjno;
        
        range = [Wrhour rangeOfString: @"."];
        Wrhour = [Wrhour substringToIndex:range.location];
        
        activityInfo.Wrhour = Wrhour;
        activityInfo.Akhour = Akhour;
        activityInfo.Place = Place;
        activityInfo.Arfno = Arfno;
        activityInfo.Locno = Locno;
        
        Txt01 = [Txt01 stringByAppendingString:Txt02];
        Txt01 = [Txt01 stringByAppendingString:Txt03];
        Txt01 = [Txt01 stringByAppendingString:Txt04];
        Txt01 = [Txt01 stringByAppendingString:Txt05];
        activityInfo.Txt01 = Txt01;
        
        activityInfo.Status = Status;
        activityInfo.Stat2 = Stat2;
        activityInfo.Stat3 = Stat3;
        activityInfo.Stat4 = Stat4;
        activityInfo.Stat5 = Stat5;
        activityInfo.ProjectName = ProjectName;
        activityInfo.CustomerName = CustomerName;
        activityInfo.aid = index;
        
        [[ActivityInfo activityArray] addObject:activityInfo];
        [activityInfo release];
        
        
        
        
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
        [locationInfo release];
        
        
    }
}


@end
