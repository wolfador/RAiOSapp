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

@interface History : UIViewController <GraphViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    NSString *userName, *url, *selected;
    IBOutlet UIPickerView *probeList;
    NSArray *probes, *days;
    UIButton *graphBtn;
    GraphView *graphcontroller;
    NSString *response, *basicURL;
    NSMutableData *receivedData;
    NSString *daysToGraph, *t1, *t2, *t3;
}
@property (readwrite, copy) NSString *userName, *url, *selected, *response, *basicURL, *daysToGraph, *t1, *t2, *t3;
@property (readwrite, copy) NSArray *probes, *days;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) IBOutlet UIPickerView *probeList;
-(BOOL) reachable;
-(void) loadData;
-(IBAction)graph;
-(void)download:(NSString *) controllerUrl;

@end
