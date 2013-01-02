//
//  CheckConnection.h
//  Aktivitem
//
//  Created by Tahir on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface CheckConnection : NSObject{

}

+(BOOL) internetConnection;
+(void) updateInterfaceWithReachability: (Reachability*) curReach;

@end
