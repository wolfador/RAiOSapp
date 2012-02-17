//
//  GraphView.h
//  CrazyDog
//
//  Created by John Wiebalk on 2/1/11.
//  Copyright 2011 Wolfador.com. All rights reserved.
//

#import "S7GraphView.h"
#import <UIKit/UIKit.h>
#import <Foundation/NSJSONSerialization.h>
#import "MultiTouchS7GraphView.h"
@class GraphView;

@protocol GraphViewDelegate
- (void)graphViewDidFinish:(GraphView *)controller;
@end

@interface GraphView : UIViewController <S7GraphViewDataSource, UIActionSheetDelegate> {
    MultiTouchS7GraphView *mGraphView;
	int keyIndex;
	int valueCount;
	UINavigationBar *nav;
    NSString *historyData, *dataString, *timeString;
    NSMutableDictionary *historyDict;
    NSArray *fullArray;
    NSMutableArray *timeArray, *valueArray;
    
    NSTimer *timer;
	CGFloat initialDistance;
	CGFloat initialX, initialY;
	CGFloat touchDownX, touchDownY;

}
@property (assign, nonatomic) IBOutlet id <GraphViewDelegate> delegate;
@property (nonatomic, retain) MultiTouchS7GraphView *mGraphView;
@property (nonatomic, retain) NSString *historyData, *dataString, *timeString;
@property (nonatomic, retain) NSMutableDictionary *historyDict;
@property (nonatomic, retain) NSArray *fullArray;
@property (nonatomic, retain) NSMutableArray *timeArray, *valueArray;
-(IBAction) keyButton;
-(IBAction) showActionSheet;


@end
