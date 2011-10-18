//
//  FirstViewController.h
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/17/11 updated by John on 9/29/11.
//  Copyright 2011 Wolfador. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "RA_ParamObject.h"
#import "XmlParser.h"
#import "Reachability.h"

@interface FirstViewController : UIViewController<UIApplicationDelegate, UITabBarDelegate, UIScrollViewDelegate>{

    UILabel *temp1Label, *temp2Label, *temp3Label, *pHLabel, *lastUpdatedLabel, *relay1, *relay2, *relay3, *relay4, *relay5, *relay6, *relay7, *relay8, *box2, *salinityLabel, *salinityValue, *temp2Value, *temp3Value;
    UIButton *b1R1Indicator, *b1R2Indicator, *b1R3Indicator, *b1R4Indicator, *b1R5Indicator, *b1R6Indicator, *b1R7Indicator, *b1R8Indicator, *b2R1Indicator, *b2R2Indicator, *b2R3Indicator, *b2R4Indicator, *b2R5Indicator, *b2R6Indicator, *b2R7Indicator, *b2R8Indicator, *changeWater, *buttonPress;
            
    IBOutlet UISwitch *box1Relay1, *box1Relay2, *box1Relay3, *box1Relay4, *box1Relay5, *box1Relay6, *box1Relay7, *box1Relay8, *box2Relay1, *box2Relay2, *box2Relay3, *box2Relay4, *box2Relay5, *box2Relay6, *box2Relay7, *box2Relay8;
    NSString *fullUrl;
    NSString *wifiUrl, *enteredURL, *tempScale;
    RA *raParam;
    IBOutlet UIScrollView *scrollView;
    NSString *urlLocation;

    ASIHTTPRequest *request;
    NSString *response;
    XmlParser *xmlParser;
     NSMutableArray *paramArray;
    

}

@property (readwrite, copy) NSString *wifiUrl, *enteredURL, *tempScale;
@property (readwrite, copy) NSString *fullUrl;
@property (nonatomic, retain) IBOutlet UILabel *temp1Label, *relay1, *relay2, *relay3, *relay4, *relay5, *relay6, *relay7, *relay8, *relay21, *relay22, *relay23, *relay24, *relay25, *relay26, *relay27, *relay28, *salinityLabel, *salinityValue;
@property (nonatomic, retain) IBOutlet UILabel *temp2Label, *temp2Value;
@property (nonatomic, retain) IBOutlet UILabel *temp3Label, *temp3Value;
@property (nonatomic, retain) IBOutlet UILabel *pHLabel;
@property (nonatomic, retain) IBOutlet UILabel *lastUpdatedLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UISwitch *box1Relay1;
@property (nonatomic, retain) IBOutlet UISwitch *box1Relay2;
@property (nonatomic, retain) IBOutlet UISwitch *box1Relay3;
@property (nonatomic, retain) IBOutlet UISwitch *box1Relay4;
@property (nonatomic, retain) IBOutlet UISwitch *box1Relay5;
@property (nonatomic, retain) IBOutlet UISwitch *box1Relay6;
@property (nonatomic, retain) IBOutlet UISwitch *box1Relay7;
@property (nonatomic, retain) IBOutlet UISwitch *box1Relay8;
@property (nonatomic, retain) IBOutlet UILabel *box2;
@property (nonatomic, retain) IBOutlet UIButton *b2R1Indicator, *changeWater, *buttonPress;
@property (nonatomic, retain) IBOutlet UIButton *b2R2Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b2R3Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b2R4Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b2R5Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b2R6Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b2R7Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b2R8Indicator;
@property (nonatomic, retain) IBOutlet UISwitch *box2Relay1;
@property (nonatomic, retain) IBOutlet UISwitch *box2Relay2;
@property (nonatomic, retain) IBOutlet UISwitch *box2Relay3;
@property (nonatomic, retain) IBOutlet UISwitch *box2Relay4;
@property (nonatomic, retain) IBOutlet UISwitch *box2Relay5;
@property (nonatomic, retain) IBOutlet UISwitch *box2Relay6;
@property (nonatomic, retain) IBOutlet UISwitch *box2Relay7;
@property (nonatomic, retain) IBOutlet UISwitch *box2Relay8;
@property (nonatomic, retain) IBOutlet UIButton *b1R1Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b1R2Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b1R3Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b1R4Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b1R5Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b1R6Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b1R7Indicator;
@property (nonatomic, retain) IBOutlet UIButton *b1R8Indicator;
@property (nonatomic, retain) NSString *response;
@property (nonatomic, retain) ASIHTTPRequest *request;
-(void)formatRA : (RA *) params;
-(NSString *)formatTemp : (NSNumber *) temp;
-(NSString *) formatPh : (NSNumber *) pH;
-(void)updateRelayBoxes : (RA *) ra;
-(NSString *)buildRelayBinary : (NSNumber *)relayByte;
-(NSString *) formatSal : (NSNumber *)sal;
-(void)sendUpdate:(NSString *) controllerUrl;
- (void)request:(ASIHTTPRequest *)request ReceiveData:(NSData *)data;
-(IBAction) waterChange;
-(IBAction) refreshParams;
-(IBAction) toggleRelay:(id)sender;
-(IBAction) pressButton;
-(BOOL) reachable;
-(void)UpdateUI:(RA*)ra;
-(void) loadData;
-(void)SendUpdate:(NSString *)url;
-(void)sendMode:(NSString *) controllerUrl;
@end

