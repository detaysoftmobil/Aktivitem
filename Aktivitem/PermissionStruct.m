//
//  PermissionStruct.m
//  Aktivitem
//
//  Created by Detay on 11/30/12.
//
//

#import "PermissionStruct.h"

@implementation PermissionStruct
@synthesize
ECount      ,
IzinSaat    ,
Mandt       ,
Pernr       ,
Begda       ,
Endda       ,
Beguz       ,
Enduz       ,
Ename       ,
Iztip       ,
Sure        ,
Iztur       ,
Odurm       ,
Opernr      ,
Oname       ,
Acik1       ,
Acik2       ,
Acik3       ,
Acik4       ,
Acik5       ,
Aciklama    ,
TlpYapan    ,
TlpTrh      ,
Application ,
Rednedeni   ,
OnayDurum   ;

- (id)init
{
    self = [super init];
    if (self) {
        ECount      = @"";
        IzinSaat    = @"";
        Mandt       = @"";
        Pernr       = @"";
        Begda       = @"";
        Endda       = @"";
        Beguz       = @"";
        Enduz       = @"";
        Ename       = @"";
        Iztip       = @"";
        Sure        = @"";
        Iztur       = @"";
        Odurm       = @"";
        Opernr      = @"";
        Oname       = @"";
        Acik1       = @"";
        Acik2       = @"";
        Acik3       = @"";
        Acik4       = @"";
        Acik5       = @"";
        Aciklama    = @"";
        TlpYapan    = @"";
        TlpTrh      = @"";
        Application = @"";
        Rednedeni   = @"";
        OnayDurum   = @"0";
    }
    return self;
}

@end
