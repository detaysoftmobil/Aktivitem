//
//  CheckConnection.m
//  Aktivitem
//
//  Created by Tahir on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckConnection.h"
#import "Reachability.h"

@implementation CheckConnection{
    
}

Reachability *hostReach;
Reachability* internetReach;
Reachability* wifiReach;
BOOL iconnectionRequired;
BOOL wconnectionRequired;
NSString *connectionwarning;

+(BOOL) internetConnection {
    
    iconnectionRequired = YES;
    wconnectionRequired = YES;
    
    hostReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	[hostReach startNotifier];
    
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability:internetReach];
    
    wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
	[wifiReach startNotifier];
	[self updateInterfaceWithReachability:wifiReach];
	
    if(iconnectionRequired &&
       wconnectionRequired )
    { 
        connectionwarning =  @"Bağlantı hatası. Lütfen network ayarlarinızı kontrol ediniz.";
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"" message:connectionwarning delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        return false;
    }  
    
    return TRUE;
}

+(void) updateInterfaceWithReachability: (Reachability*) curReach
{
    
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    iconnectionRequired = [curReach connectionRequired];
    
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            iconnectionRequired= NO;
            break;
            
        }
        case ReachableViaWiFi:
        {  
            wconnectionRequired= NO; 
            break;
        } 
            
        default:break;
    }
    
    
    
}

@end
