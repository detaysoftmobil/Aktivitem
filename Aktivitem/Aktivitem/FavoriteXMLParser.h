//
//  FavoriteXMLParser.h
//  Aktivitem
//
//  Created by Tahir on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteXMLParser : NSObject<NSXMLParserDelegate>{
   
   NSString *customer;
   NSString *project;
   NSString *customerName;
   NSString *projectName;
   
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

-(NSString*)parseXML:(NSString*)_personelNumber Date:(NSString*)_date;

@end
