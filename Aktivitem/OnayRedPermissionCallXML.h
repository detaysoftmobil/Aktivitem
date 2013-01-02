//
//  OnayRedPermissionCallXML.h
//  Aktivitem
//
//  Created by Detay on 12/19/12.
//
//

#import <Foundation/Foundation.h>
@class PermissionStruct;

@interface OnayRedPermissionCallXML : NSObject
@property(nonatomic, retain) NSMutableData *webData;
@property(assign) BOOL isConnectionFinished;

-(NSString*)callXML:(PermissionStruct*)_permission;
-(void)getXML:(PermissionStruct*)_permission;
@end
