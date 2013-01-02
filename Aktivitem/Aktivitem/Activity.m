//
//  Activity.m
//  Aktivitem
//
//  Created by Tahir on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Activity.h"
#import "CreateActivityXMLParser.h"


@implementation Activity

static NSString *_highdate;
static NSString *_lowdate;

+(NSString*)getHighDate{
    return _highdate;
}
+(void)setHighDate:(NSString*)_highDate{
    if (_highdate != _highDate) {
        _highdate = nil;
        _highdate = [_highDate retain];
    }
}

+(NSString*)getLowDate{
    return _lowdate;
}
+(void)setLowDate:(NSString*)_lowDate{
    if (_lowdate != _lowDate) {
        _lowdate = nil;
        _lowdate = [_lowDate retain];
    }
}



-(NSString*)trimDate:(NSString*)_date{
    
    NSString *trimmedDate = @"";
    if ([_date isEqualToString:@""]) {
        return @"";
    }
    trimmedDate = [[_date componentsSeparatedByString:@"-"] lastObject];
    trimmedDate = [trimmedDate stringByAppendingString:[_date substringWithRange:NSMakeRange(3, 2)]];
    trimmedDate = [trimmedDate stringByAppendingString:[_date substringWithRange:NSMakeRange(0, 2)]];
    
    return trimmedDate;
}

-(NSString*)createActiviyt:(ActivityInfo*)_activityInfo{
    
    
    CreateActivityXMLParser *createActivityXMLParser = [[CreateActivityXMLParser alloc] init];
    
    NSString *errorMessage = [[NSString alloc] initWithString:[createActivityXMLParser parseXML:_activityInfo]];
    
   
    NSString *returnMessage = @"E";
    
    if (![errorMessage isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMessage delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
    }
    else {
       returnMessage = @"O";
    
    }
    return returnMessage;
}
-(NSString*)updateActiviyt:(ActivityInfo*)_activityInfo{
    

    
    CreateActivityXMLParser *createActivityXMLParser = [[CreateActivityXMLParser alloc] init];
    NSString *errorMessage = [[NSString alloc] initWithString:[createActivityXMLParser parseXML:_activityInfo]];

     NSString *returnMessage = @"E";
    if (![errorMessage isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMessage delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
    }
    else {
       returnMessage = @"O";
        
    }
    return returnMessage;
}
-(NSString*)deleteActiviyt:(ActivityInfo*)_activityInfo{
    
    CreateActivityXMLParser *createActivityXMLParser = [[[CreateActivityXMLParser alloc] init] autorelease];
    NSString *errorMessage = [[NSString alloc] initWithString:[createActivityXMLParser parseXML:_activityInfo]];
   
    
    NSString *returnMessage = @"E";
    
    if (![errorMessage isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMessage delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
    }
    else {
        return @"O";
    }
    
    
    return returnMessage;
}

@end


@implementation ActivityInfo
@synthesize Pernr,Begda,Seqno,Kunnr,Prjno,Wrhour,Akhour,Place,Arfno,Txt01,Txt02,Txt03,Txt04,Txt05,Status,Stat2,Stat3,Stat4,Stat5,Locno,CustomerName,ProjectName,aid;


static NSMutableArray *_activy;

- (id)init
{
    self = [super init];
    if (self) {
       Pernr = @"";
    }
    return self;
}


+(NSMutableArray*)activityArray{
    
    @synchronized(_activy){
        
        if (_activy == nil) {
            _activy = [[NSMutableArray alloc] init];
        }
        
        return _activy;
    }
    
    return nil;
    
}

@end


