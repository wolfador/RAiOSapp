//
//  MemoryViewController.h
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 10/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "XmlParser.h"
#import "Reachability.h"
#import "MemValues.h"
@class MemoryViewController;

@protocol MemoryViewControllerDelegate
- (void)memoryViewControllerDidFinish:(MemoryViewController *)controller;
@end

@interface MemoryViewController : UIViewController{
    ASIHTTPRequest *request;
    NSString *response;
    XmlParser *xmlParser;
    MEM *memValues;
    IBOutlet UITextField *HeaterOn, *HeaterOff, *FeedTimer, *Overheat, *PWMD, *PWMA, *LCDTimer;  
    NSString *wifiURL, *enteredUrl, *fullURL;
    IBOutlet UISlider *Actinic, *Daylight;
    NSString *daylightValue, *actinicValue, *heaterOnValue, *heaterOffValue, *feedTimerValue, *overheatValue, *LCDTimerValue, *sendUpdateMem;
}

@property (assign, nonatomic) IBOutlet id <MemoryViewControllerDelegate> delegate;
@property (nonatomic, retain) NSString *response, *wifiURL, *enteredURL, *fullURL, *daylightValue, *actinicValue, *heaterOnValue, *heaterOffValue, *feedTimerValue, *overheatValue, *LCDTimerValue, *sendUpdateMem;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain)  IBOutlet UITextField *HeaterOn, *HeaterOff, *FeedTimer, *Overheat, *PWMD, *PWMA, *LCDTimer;
@property (nonatomic, retain)  IBOutlet UISlider *Actinic, *Daylight;  
- (IBAction)done;
-(IBAction) save;
-(void)sendUpdate:(NSString *) controllerUrl;
-(void) loadData;
-(void)UpdateUI:(MEM *)memValues;
-(BOOL)reachable;
-(void)updateValue:(NSString *) controllerUrl;
- (IBAction) sliderValueChanged:(UISlider *)sender;
-(IBAction)slideDoneChanging:(UISlider *)sender;
-(NSString *) formatTemp : (NSNumber *)temp;
@end
