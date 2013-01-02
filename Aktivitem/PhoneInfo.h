//
//  PhoneInfo.h
//  Aktivitem
//
//  Created by Tahir on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneInfo : NSObject

@property(nonatomic,retain)NSString *personel;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *lastname;
@property(nonatomic,retain)NSString *shortCall;
@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString *workTel;
@property(nonatomic,retain)NSString *privateTel;


+(NSMutableArray*)PhoneListArray;

@end
