//
//  PhoneInfo.m
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhoneInfo.h"

@implementation PhoneInfo
@synthesize personel,name,lastname,shortCall,email,workTel,privateTel;

static NSMutableArray *_plist;


+(NSMutableArray*)PhoneListArray{
    
    @synchronized(_plist){
        
        if (_plist == nil) {
            _plist = [[NSMutableArray alloc] init];
        }
        return _plist;
    }
    return nil;
}

@end
