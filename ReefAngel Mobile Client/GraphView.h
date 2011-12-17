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
@class GraphView;

@protocol GraphViewDelegate
- (void)graphViewDidFinish:(GraphView *)controller;
@end

@interface GraphView : UIViewController <S7GraphViewDataSource, UIActionSheetDelegate> {
	S7GraphView *graphView;
	int keyIndex;
	int valueCount;
	UINavigationBar *nav;
    NSString *historyData;
    NSMutableDictionary *historyDict;
    NSArray *fullArray;

}
@property (assign, nonatomic) IBOutlet id <GraphViewDelegate> delegate;
@property (nonatomic, retain) S7GraphView *graphView;
@property (nonatomic, retain) NSString *historyData;
@property (nonatomic, retain) NSMutableDictionary *historyDict;
@property (nonatomic, retain) NSArray *fullArray;
-(IBAction) keyButton;
-(IBAction) showActionSheet;
@end
