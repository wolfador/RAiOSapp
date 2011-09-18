//
//  SecondViewController.h
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ReefAngel_Mobile_ClientAppDelegate.h"

@protocol PassURL <NSObject>
-(void) setURL: (NSString *) enteredURL;
@end
@interface SecondViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>{
    IBOutlet UIScrollView *scrollView;
    NSArray *settingsGeneralRows;
    NSArray *settingsBox1Relays;
    NSArray *settingsBox1Vals;
    NSArray *settingsTempLabels;
    NSArray *settingsTempVals;
    NSArray *settingsSectionHeaders;
    NSString *enteredURL;
    IBOutlet UITextField *url;
    IBOutlet UIButton *save;
    ReefAngel_Mobile_ClientAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSString *enteredURL;
@property (nonatomic, retain)IBOutlet UITextField *url;
@property (nonatomic, retain) IBOutlet UIButton *save;
@property (nonatomic, retain) ReefAngel_Mobile_ClientAppDelegate *appDelegate;
-(IBAction) textFieldDoneEditing : (id) sender;
-(IBAction)saveData;
-(IBAction)hideKeyboard;
-(void) loadData;
@end
