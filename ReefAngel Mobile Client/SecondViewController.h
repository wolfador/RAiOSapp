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

@protocol PassURL <NSObject>
-(void) setURL: (NSString *) enteredURL;
@end

@interface SecondViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, MemoryViewControllerDelegate>{
    IBOutlet UIScrollView *scrollView;
    NSMutableString *enteredURL, *updatedURL;
    IBOutlet UITextField *url, *relay1, *relay2, *relay3, *relay4, *relay5, *relay6, *relay7, *relay8, *port;
    IBOutlet UITextField *exprelay1, *exprelay2, *exprelay3, *exprelay4, *exprelay5, *exprelay6, *exprelay7, *exprelay8;
    IBOutlet UILabel *exprelay1Label, *exprelay2Label, *exprelay3Label, *exprelay4Label, *exprelay5Label, *exprelay6Label, *exprelay7Label, *exprelay8Label;
    IBOutlet UISwitch *relayExp;


}

@property (nonatomic, retain) NSMutableString *enteredURL, *updatedURL;
@property (nonatomic, retain) IBOutlet UITextField *url, *relay1, *relay2, *relay3, *relay4, *relay5, *relay6, *relay7, *relay8;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UISwitch *relayExp;
@property (nonatomic, retain) IBOutlet UITextField *exprelay1, *exprelay2, *exprelay3, *exprelay4, *exprelay5, *exprelay6, *exprelay7, *exprelay8, *port;
@property (nonatomic, retain) IBOutlet UILabel *exprelay1Label, *exprelay2Label, *exprelay3Label, *exprelay4Label, *exprelay5Label, *exprelay6Label, *exprelay7Label, *exprelay8Label;
-(IBAction) textFieldDoneEditing : (id) sender;
-(IBAction)saveData;
-(IBAction)hideKeyboard;
-(IBAction)turnOnRelayExp;
-(IBAction)flipMemory;
-(void) loadData;
@end
