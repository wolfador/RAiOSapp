//
//  History.h
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "GraphView.h"

@interface History : UIViewController <GraphViewDelegate>{
    NSString *userName, *url, *fullUrl, *selected;
    IBOutlet UIPickerView *probeList;
    NSArray *probes;
    UIButton *graphBtn;
    GraphView *graphcontroller;
    NSString *response, *basicURL;
    NSMutableData *receivedData;
}
@property (readwrite, copy) NSString *userName, *url, *fullUrl, *selected, *response, *basicURL;
@property (readwrite, copy) NSArray *probes;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) IBOutlet UIPickerView *probeList;
-(BOOL) reachable;
-(void) loadData;
-(IBAction)graph;
-(void)download:(NSString *) controllerUrl;

@end
