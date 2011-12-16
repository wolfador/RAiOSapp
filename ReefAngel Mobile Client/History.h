//
//  History.h
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface History : UIViewController {
    NSString *userName, *url, *fullUrl;
}
@property (readwrite, copy) NSString *userName, *url, *fullUrl;
-(BOOL) reachable;
-(void) loadData;
@end
