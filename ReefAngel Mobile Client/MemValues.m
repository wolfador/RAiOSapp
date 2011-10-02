//
//  MemValues.m
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 10/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MemValues.h"

@implementation MEM
@synthesize M822, M824, M814, M818, M820, M821, M816; 
-(void) dealloc
{
    [M822 release];
     [M824 release];
     [M814 release];
     [M818 release];
     [M820 release];
     [M821 release];
     [M816 release];
    [super dealloc];
}

@end
