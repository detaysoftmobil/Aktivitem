//
//  ActivityXMLParser.h
//  Aktivitem
//
//  Created by Tahir on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityXMLParser : NSObject<NSXMLParserDelegate>{
    
    NSString* Pernr;
    NSString* Begda;
    NSString* Seqno;
    NSString* Kunnr;
    NSString* Prjno;
    NSString* Wrhour;
    NSString* Akhour;
    NSString* Place;
    NSString* Arfno;
    NSString* Txt01;
    NSString* Txt02;
    NSString* Txt03;
    NSString* Txt04;
    NSString* Txt05;
    NSString* Status;
    NSString* Stat2;
    NSString* Stat3;
    NSString* Stat4;
    NSString* Stat5;
    NSString* Locno;
    NSString* CustomerName;
    NSString* ProjectName;
    
    NSString *mandt;
    NSString *kunnr;
    NSString *locno;
    NSString *adr01;
    NSString *adr02;
    NSString *mtype;
    NSString *deflt;
    NSString *cunam;
    NSString *cdate;
    NSString *cuzet;
    NSString *lunch;
    NSString *distn;
    NSString *brdge;
    
    
    NSMutableString *currentString;
    NSString *error;
    BOOL saveString;
    
    int index;
}

-(NSString*)parseXML:(NSString*)_personelNumber HighDate:(NSString*)_hdate LowDate:(NSString*)_ldate;

@end
