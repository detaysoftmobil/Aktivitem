//
//  Calendar.h
//  Aktivitem
//
//  Created by Tahir on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject


-(NSDate*)dayWeekMonth:(NSInteger)choice;
-(NSString*)getMonthRange:(NSDate *)curDate;


@end
