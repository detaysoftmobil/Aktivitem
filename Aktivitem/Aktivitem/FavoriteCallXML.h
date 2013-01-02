//
//  FavoriteCallXML.h
//  Aktivitem
//
//  Created by Tahir on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteCallXML : NSObject{
    
    
    
}
@property(nonatomic, retain) NSMutableData *webData;
@property(assign) BOOL isConnectionFinished;


-(NSString*)callXML:(NSString*)_personelNumber Date:(NSString*)_date;
-(void)getXML:(NSString*)_personelNumber Date:(NSString*)_date;

@end
