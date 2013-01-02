//
//  Activity.h
//  Aktivitem
//
//  Created by Tahir on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActivityInfo;


@interface Activity : NSObject

-(NSString*)trimDate:(NSString*)_date;

-(NSString*)createActiviyt:(ActivityInfo*)_activityInfo;
-(NSString*)updateActiviyt:(ActivityInfo*)_activityInfo;
-(NSString*)deleteActiviyt:(ActivityInfo*)_activityInfo;

+(NSString*)getHighDate;
+(void)setHighDate:(NSString*)_highDate;
+(NSString*)getLowDate;
+(void)setLowDate:(NSString*)_lowDate;
@end


@interface ActivityInfo : NSObject


@property(nonatomic,retain)NSString* Pernr;
@property(nonatomic,retain)NSString* Begda;
@property(nonatomic,retain)NSString* Seqno;
@property(nonatomic,retain)NSString* Kunnr;
@property(nonatomic,retain)NSString* Prjno;
@property(nonatomic,retain)NSString* Wrhour;
@property(nonatomic,retain)NSString* Akhour;
@property(nonatomic,retain)NSString* Place;
@property(nonatomic,retain)NSString* Arfno;
@property(nonatomic,retain)NSString* Txt01;
@property(nonatomic,retain)NSString* Txt02;
@property(nonatomic,retain)NSString* Txt03;
@property(nonatomic,retain)NSString* Txt04;
@property(nonatomic,retain)NSString* Txt05;
@property(nonatomic,retain)NSString* Status;
@property(nonatomic,retain)NSString* Stat2;
@property(nonatomic,retain)NSString* Stat3;
@property(nonatomic,retain)NSString* Stat4;
@property(nonatomic,retain)NSString* Stat5;
@property(nonatomic,retain)NSString* Locno;
@property(nonatomic,retain)NSString* CustomerName;
@property(nonatomic,retain)NSString* ProjectName;
@property(nonatomic,assign)int aid;

+(NSMutableArray*)activityArray;

@end


