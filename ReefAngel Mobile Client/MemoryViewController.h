//
//  MemoryViewController.h
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 10/1/11.
//  Copyright (c) 2011 Wolfador. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XmlParser.h"
#import "Reachability.h"
#import "MemValues.h"
@class MemoryViewController;

@protocol MemoryViewControllerDelegate
- (void)memoryViewControllerDidFinish:(MemoryViewController *)controller;
@end

@interface MemoryViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>{
    XmlParser *xmlParser;
    MEM *memValues;
    IBOutlet UITextField *HeaterOn, *HeaterOff, *FeedTimer, *Overheat, *PWMD, *PWMA, *LCDTimer, *MHOnHour, *MHOnMin, *MHOffHour, *MHOffMin, *StdOnHour, *StdOnMin, *StdOffHour, *StdOffMin, *DP1Hr, *DP1Min, *DP2Hr, *DP2Min, *DP1Int, *DP2Int, *customLoc, *custom, *rfMode, *rfSpeed, *rfDuration;  
    NSString *wifiURL, *enteredUrl, *fullURL, *tempScale;
    IBOutlet UISlider *Actinic, *Daylight;
    NSString *daylightValue, *actinicValue, *heaterOnValue, *heaterOffValue, *feedTimerValue, *overheatValue, *LCDTimerValue, *sendUpdateMem, *MHOnHourValue, *MHOnMinValue, *MHOffHourValue, *MHOffMinValue, *StdOnHourValue, *StdOnMinValue, *StdOffHourValue, *StdOffMinValue, *DP1MinValue, *DP2HrValue, *DP2MinValue, *DP1IntValue, *DP2IntValue, *rfModeValue, *rfSpeedValue, *rfDurationValue;
    IBOutlet UILabel *ForC, *ForC2, *ForC3;
    NSMutableArray *paramArray;
    IBOutlet UIScrollView *scrollView;
}

@property (assign, nonatomic) IBOutlet id <MemoryViewControllerDelegate> delegate;
@property (nonatomic, retain) NSString *wifiURL, *enteredURL, *fullURL, *daylightValue, *actinicValue, *heaterOnValue, *heaterOffValue, *feedTimerValue, *overheatValue, *LCDTimerValue, *sendUpdateMem, *MHOnHourValue, *MHOnMinValue, *MHOffHourValue, *MHOffMinValue, *StdOnHourValue, *StdOnMinValue, *StdOffHourValue, *StdOffMinValue, *tempScale, *DP1HrValue, *DP1MinValue, *DP2HrValue, *DP2MinValue, *DP1IntValue, *DP2IntValue, *rfModeValue, *rfSpeedValue, *rfDurationValue;
@property (nonatomic, retain)  IBOutlet UITextField *HeaterOn, *HeaterOff, *FeedTimer, *Overheat, *PWMD, *PWMA, *LCDTimer, *MHOnHour, *MHOnMin, *MHOffHour, *MHOffMin, *StdOnHour, *StdOnMin, *StdOffHour, *StdOffMin, *DP1Hr, *DP1Min, *DP2Hr, *DP2Min, *DP1Int, *DP2Int, *customLoc, *custom, *rfMode, *rfSpeed, *rfDuration;
@property (nonatomic, retain)  IBOutlet UISlider *Actinic, *Daylight;
@property (nonatomic, retain) IBOutlet UILabel *ForC, *ForC2, *ForC3;
- (IBAction)done;
-(IBAction) save;
-(IBAction) updateTime;
-(void)sendUpdate:(NSString *) controllerUrl;
-(void) loadData;
-(void)UpdateUI:(MEM *)memValues;
-(BOOL)reachable;
-(void)updateValue:(NSString *) controllerUrl;
- (IBAction) sliderValueChanged:(UISlider *)sender;
-(IBAction)slideDoneChanging:(UISlider *)sender;
-(NSString *) formatTemp : (NSNumber *)temp;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@end
