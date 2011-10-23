//
//  FirstViewController.h
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/17/11 updated by John on 9/29/11.
//  Copyright 2011 Wolfador. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "RA_ParamObject.h"
#import "XmlParser.h"
#import "Reachability.h"


@interface FirstViewController : UIViewController<UIApplicationDelegate, UITabBarDelegate, UIScrollViewDelegate>{

    UILabel *temp1Label, *temp2Label, *temp3Label, *pHLabel, *lastUpdatedLabel, *salinityLabel, *salinityValue, *temp2Value, *temp3Value;
    NSString *fullUrl;
    NSString *wifiUrl, *enteredURL, *tempScale;
    RA *raParam;
    NSString *urlLocation;
    NSString *response;
    XmlParser *xmlParser;
    NSMutableArray *paramArray;
   NSString *current_version;  


}

@property (readwrite, copy) NSString *wifiUrl, *enteredURL, *tempScale;
@property (readwrite, copy) NSString *fullUrl, *current_version;
@property (nonatomic, retain) IBOutlet UILabel *temp1Label, *salinityLabel, *salinityValue;
@property (nonatomic, retain) IBOutlet UILabel *temp2Label, *temp2Value;
@property (nonatomic, retain) IBOutlet UILabel *temp3Label, *temp3Value;
@property (nonatomic, retain) IBOutlet UILabel *pHLabel;
@property (nonatomic, retain) IBOutlet UILabel *lastUpdatedLabel;

@property (nonatomic, retain) NSString *response;
-(void)formatRA : (RA *) params;
-(NSString *)formatTemp : (NSNumber *) temp;
-(NSString *) formatPh : (NSNumber *) pH;
-(NSString *) formatSal : (NSNumber *)sal;
-(void)sendUpdate:(NSString *) controllerUrl;
-(IBAction) refreshParams;
-(BOOL) reachable;
-(void)UpdateUI:(RA*)ra;
-(void)ConfigureUI:(NSString*) ver;
-(void) loadData;
-(void)SendUpdate:(NSString *)url;
-(void)sendMode:(NSString *) controllerUrl;
@end

