//
//  SecondViewController.h
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/17/11 updated by John on 9/29/11.
//  Copyright 2011 Wolfador. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ReefAngel_Mobile_ClientAppDelegate.h"
#import "MemoryViewController.h"
#import "XmlParser.h"
#import "Reachability.h"
#import "RA_ParamObject.h"

@interface SecondViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, MemoryViewControllerDelegate>{
    IBOutlet UIScrollView *scrollView;
    NSMutableString *enteredURL, *updatedURL;
    IBOutlet UITextField *url, *relay1, *relay2, *relay3, *relay4, *relay5, *relay6, *relay7, *relay8, *port, *temp1, *temp2, *temp3;
    IBOutlet UITextField *exprelay1, *exprelay2, *exprelay3, *exprelay4, *exprelay5, *exprelay6, *exprelay7, *exprelay8, *userName;
    IBOutlet UILabel *exprelay1Label, *exprelay2Label, *exprelay3Label, *exprelay4Label, *exprelay5Label, *exprelay6Label, *exprelay7Label, *exprelay8Label, *relay1Label, *relay2Label, *relay3Label, *relay4Label, *relay5Label, *relay6Label, *relay7Label, *relay8Label, *temp1Label, *temp2Label, *temp3Label;
    IBOutlet UISwitch *relayExp;
    MemoryViewController *memcontroller;
    IBOutlet UISegmentedControl *tempScale;
    IBOutlet UIButton *loadNames, *hideNames, *showNames;
    NSString *bannerUrl, *response;
    XmlParser *xmlParser;
    RA *webBanner;
    NSMutableArray *paramArray;
    NSMutableData *receivedData;


}

@property (nonatomic, retain) NSMutableString *enteredURL, *updatedURL;
@property (nonatomic, retain) IBOutlet UIButton *loadNames, *hideNames, *showNames;
@property (nonatomic, retain) NSString *bannerUrl, *response;
@property (nonatomic, retain) IBOutlet UITextField *url, *relay1, *relay2, *relay3, *relay4, *relay5, *relay6, *relay7, *relay8, *userName;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UISwitch *relayExp;
@property (nonatomic, retain) IBOutlet UISegmentedControl *tempScale;
@property (nonatomic, retain) IBOutlet UITextField *exprelay1, *exprelay2, *exprelay3, *exprelay4, *exprelay5, *exprelay6, *exprelay7, *exprelay8, *port, *temp1, *temp2, *temp3;
@property (nonatomic, retain) IBOutlet UILabel *exprelay1Label, *exprelay2Label, *exprelay3Label, *exprelay4Label, *exprelay5Label, *exprelay6Label, *exprelay7Label, *exprelay8Label, *relay1Label, *relay2Label, *relay3Label, *relay4Label, *relay5Label, *relay6Label, *relay7Label, *relay8Label, *temp1Label, *temp2Label, *temp3Label;
-(IBAction) textFieldDoneEditing : (id) sender;
-(IBAction) saveData;
-(IBAction) hideKeyboard;
-(IBAction) turnOnRelayExp;
-(IBAction) flipMemory;
-(IBAction) loadPortNames;
-(void) loadData;
-(void) getPorts:(NSString *) controllerUrl;
-(void) updatePorts:(RA *) banner;
-(BOOL) reachable;
@end
