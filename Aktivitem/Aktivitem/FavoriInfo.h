//
//  FavoriInfo.h
//  Aktivitem
//
//  Created by Tahir on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriInfo : NSObject



@property(nonatomic,retain)NSString *customer;
@property(nonatomic,retain)NSString *project;
@property(nonatomic,retain)NSString *customerName;
@property(nonatomic,retain)NSString *projectName;
@property(nonatomic,assign)int fid;

+(NSMutableArray*)favoriArray;
+(NSMutableArray*)locationArray;




@end


@interface LocationInfo : NSObject

@property(nonatomic,retain)NSString *mandt;
@property(nonatomic,retain)NSString *kunnr;
@property(nonatomic,retain)NSString *locno;
@property(nonatomic,retain)NSString *adr01;
@property(nonatomic,retain)NSString *adr02;
@property(nonatomic,retain)NSString *mtype;
@property(nonatomic,retain)NSString *deflt;
@property(nonatomic,retain)NSString *cunam;
@property(nonatomic,retain)NSString *cdate;
@property(nonatomic,retain)NSString *cuzet;
@property(nonatomic,retain)NSString *lunch;
@property(nonatomic,retain)NSString *distn;
@property(nonatomic,retain)NSString *brdge;
@property(nonatomic,assign)int ID;
@end
