//
//  Mainclass.m
//  Aktivitem
//
//  Created by Tahir on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mainclass.h"

@implementation Mainclass



-(UIColor*)navigationBarColor:(float)r R:(float)g B:(float)b
{
    
    UIColor *color = [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.0];
    
    return color;
}

@end
