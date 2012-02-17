//
//  MemValues.m
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 10/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MemValues.h"

@implementation MEM
@synthesize M822, M824, M814, M818, M820, M821, M816, M807, M806, M805, M804, M803, M802, M801, M800, M836, M837, M838, M839, M843, M845; 
-(void) dealloc
{
    [M822 release];
     [M824 release];
     [M814 release];
     [M818 release];
     [M820 release];
     [M821 release];
     [M816 release];
    [M800 release];
    [M801 release];
    [M802 release];
    [M803 release];
    [M804 release];
    [M805 release];
    [M806 release];
    [M807 release];
    [M836 release];
    [M837 release];
    [M838 release];
    [M839 release];
    [M843 release];
    [M845 release];
    
    [super dealloc];
}

@end
