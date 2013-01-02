//
//  CreatePermissionCallXML.h
//  Aktivitem
//
//  Created by Detay on 11/30/12.
//
//

#import <Foundation/Foundation.h>
@class PermissionStruct;

@interface CreatePermissionCallXML : NSObject

@property(nonatomic, retain) NSMutableData *webData;
@property(assign) BOOL isConnectionFinished;

-(NSString*)callXML:(PermissionStruct*)_permission;
-(void)getXML:(PermissionStruct*)_permission;

@end
