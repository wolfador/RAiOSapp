//
//  WebBanner.m
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WebBanner.h"

@implementation BANNER
@synthesize T1N, T2N, T3N, R1N, R2N, R3N, R4N, R5N, R6N, R7N, R8N, R11N, R12N, R13N, R14N, R15N, R16N, R17N, R18N;
-(void) dealloc
{
    [T1N release];
    [T2N release];
    [T3N release];
    [R1N release];
    [R2N release];
    [R3N release];
    [R4N release];
    [R5N release];
    [R6N release];
    [R7N release];
    [R8N release];
    [R11N release];
    [R12N release];
    [R13N release];
    [R14N release];
    [R15N release];
    [R16N release];
    [R17N release];
    [R18N release];
    
    [super dealloc];
}
@end
