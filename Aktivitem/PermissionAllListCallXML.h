//
//  PermissionAllListCallXML.h
//  Aktivitem
//
//  Created by Detay on 12/3/12.
//
//

#import <Foundation/Foundation.h>
@class PermissionStruct;

@interface PermissionAllListCallXML : NSObject
@property(nonatomic, retain) NSMutableData *webData;
@property(assign) BOOL isConnectionFinished;

-(NSString*)callXML:(PermissionStruct*)_permission;
-(void)getXML:(PermissionStruct*)_permission;
//as
@end
