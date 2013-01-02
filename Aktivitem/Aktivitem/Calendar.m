//
//  Calendar.m
//  Aktivitem
//
//  Created by Tahir on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar


-(NSDate*)dayWeekMonth:(NSInteger)choice
{
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
    
    [components setHour:-0];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; 
    
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *yesterday = [cal dateByAddingComponents:components toDate: today options:0];
    
    components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
    
    [components setDay:([components day] - ([components weekday] - 3))]; 
    NSDate *thisWeek  = [cal dateFromComponents:components];
    
    [components setDay:([components day] - 7)];
    NSDate *lastWeek  = [cal dateFromComponents:components];
    
    [components setDay:([components day] - ([components day] - 2))]; 
    NSDate *thisMonth = [cal dateFromComponents:components];
    
    [components setMonth:([components month] - 1)]; 
    NSDate *lastMonth = [cal dateFromComponents:components];
    
    
   
    
    switch (choice) {
        case 0:// Today
            return today;
            break;
        case 1:// Yesterday
            return yesterday;
            break;
        case 2:// Current Week
            return thisWeek;
            break;
        case 3:// Current Month
            return thisMonth;
            break;
        case 4:// Last Week
            return lastWeek;
            break;
        case 5:// Last Month
            return lastMonth;
            break;
            
        default:
            break;
    }
    return today;
}

-(NSString*)getMonthRange:(NSDate *)date
{
//      NSDate *curDate = [NSDate date];
      NSCalendar *currentCalendar = [NSCalendar currentCalendar];
      NSRange daysRange = [currentCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
      
      unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit|NSSecondCalendarUnit;
   	NSDateComponents *comps = [currentCalendar components:unitFlags fromDate:date];
      
   	int year = [comps year];
   	int month = [comps month];
    
    
    NSString *strMonth = [NSString stringWithFormat:@"%d",month];;
    for (int i = 0; i <= 9; i++) {
        if (month == i) {
            strMonth = [NSString stringWithFormat:@"0%d",month];
            break;
        }
    }
    
    
//    NSLog(@"%@",[NSString stringWithFormat:@"1.%d.%d",month,year]);
//    NSLog(@"%@",[NSString stringWithFormat:@"%d.%d.%d",daysRange.length,month,year]);
   
    return [NSString stringWithFormat:@"%d-%@-%d",daysRange.length,strMonth,year];
}


@end
