//
//  FavoriInfo.m
//  Aktivitem
//
//  Created by Tahir on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriInfo.h"

@implementation FavoriInfo
@synthesize customer,project,customerName,projectName,fid;

static NSMutableArray* _favori = nil;
static NSMutableArray* _location = nil;


+(NSMutableArray*)favoriArray{
    
    @synchronized(_favori){
        
        if (_favori == nil) {
            _favori = [[NSMutableArray alloc] init];
        }
        
        return _favori;
    }
    return nil;
}
+(NSMutableArray*)locationArray{
    
    @synchronized(_location){
        
        if (_location == nil) {
            _location = [[NSMutableArray alloc] init];
        }
        return _location;
    }

    return nil;
}





@end

@implementation LocationInfo
@synthesize mandt,kunnr,locno,adr01,adr02,mtype,deflt,cunam,cdate,cuzet,lunch,distn,brdge,ID;
 
@end
