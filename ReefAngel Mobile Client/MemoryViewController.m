//
//  MemoryViewController.m
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 10/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MemoryViewController.h"

@implementation MemoryViewController
@synthesize delegate = _delegate, request, response;
@synthesize HeaterOn, HeaterOff, FeedTimer, Overheat, PWMD, PWMA, LCDTimer, wifiURL, enteredURL, fullURL, Actinic, Daylight, daylightValue, actinicValue, heaterOnValue, heaterOffValue, feedTimerValue, overheatValue, LCDTimerValue, sendUpdateMem;
- (IBAction)done
{
    [self.delegate memoryViewControllerDidFinish:self];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction) textFieldDoneEditing : (id) sender{
    [sender resignFirstResponder];
}
-(IBAction)hideKeyboard
{
    [self.HeaterOn resignFirstResponder];
    [self.HeaterOff resignFirstResponder];
    [self.FeedTimer resignFirstResponder];
    [self.Overheat resignFirstResponder];
    [self.PWMD resignFirstResponder];
    [self.PWMA resignFirstResponder];
    [self.LCDTimer resignFirstResponder];
}
- (IBAction) sliderValueChanged:(UISlider *)sender
{
    if(sender.tag == 820)
    {
        self.PWMD.text = [NSString stringWithFormat:@"%.0f", [self.Daylight value]];
    }
    if (sender.tag == 821) {
        self.PWMA.text = [NSString stringWithFormat:@"%.0f", [self.Actinic value]];
      
        }
}
-(IBAction)slideDoneChanging:(UISlider *)sender
{
    if(sender.tag == 820)
    {
         self.sendUpdateMem = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.PWMD.tag,self.PWMD.text];
         NSLog(@"%@", self.sendUpdateMem);
         [self updateValue:self.sendUpdateMem];
         
    }
    if (sender.tag == 821) {
        self.sendUpdateMem = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.PWMA.tag,self.PWMA.text];
         NSLog(@"%@", self.sendUpdateMem);
         [self updateValue:self.sendUpdateMem];
                 
    }
}
-(void) loadData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
	
	NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
	self.wifiURL = [restored objectForKey:@"URL"];
    self.enteredURL = [restored objectForKey:@"EnteredURL"];
    
    if ([self reachable]) {
        self.fullURL = [NSString stringWithFormat:@"%@ma ",self.wifiURL];
        [self sendUpdate:self.fullURL];
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }

}
-(IBAction) save
{
    [self hideKeyboard];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Memdata.plist"];
	
	NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
	self.heaterOnValue = [restored objectForKey:@"HeaterOn"];
   self.heaterOffValue = [restored objectForKey:@"HeaterOff"];
    self.actinicValue = [restored objectForKey:@"Actinic"];
    self.daylightValue = [restored objectForKey:@"Daylight"];
     self.feedTimerValue = [restored objectForKey:@"FeedTimer"];
     self.LCDTimerValue = [restored objectForKey:@"LCDTimer"];
    self.overheatValue = [restored objectForKey:@"Overheat"];
    
     if ([self reachable]) {
    if ([self.heaterOnValue isEqualToString:self.HeaterOn.text]) {
        }
    else
    {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.HeaterOn.tag,self.HeaterOn.text];
            [self updateValue:updateMemory];
    }
    if ([self.heaterOffValue isEqualToString: self.HeaterOff.text]) {
    }
    else
    {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.HeaterOff.tag,self.HeaterOff.text];
            [self updateValue:updateMemory];
    }

    if ([self.feedTimerValue isEqualToString: self.FeedTimer.text]) {
    }
    else
    {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.FeedTimer.tag,self.FeedTimer.text];
            [self updateValue:updateMemory];
    }
    if ([self.overheatValue isEqualToString:self.Overheat.text]) {
           }
    else
    {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.Overheat.tag,self.Overheat.text];
            [self updateValue:updateMemory];
    }
    if ([self.daylightValue isEqualToString:self.PWMD.text]) {
}
    else
    {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.PWMD.tag,self.PWMD.text];
        [self updateValue:updateMemory];

    }
         if ([self.LCDTimerValue isEqualToString:self.LCDTimer.text]) {
}
    else
    {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.LCDTimer.tag,self.LCDTimer.text];
        [self updateValue:updateMemory];
    }
    if ([self.actinicValue isEqualToString:self.PWMA.text]) {
    }
    else
    {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.PWMA.tag,self.PWMA.text];
        [self updateValue:updateMemory];
    }
     }
    
    
}
-(void)UpdateUI:(MEM*)mem
{
    if(memValues)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Memdata.plist"];
        
		NSMutableDictionary *Dictionary = [NSMutableDictionary dictionary];
		NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
		[Dictionary addEntriesFromDictionary:restored];
        
        [Dictionary setObject: [memValues.M822 stringValue] forKey: @"HeaterOn"];
        [Dictionary setObject: [memValues.M821 stringValue] forKey: @"Actinic"];
        [Dictionary setObject: [memValues.M820 stringValue] forKey: @"Daylight"];
        [Dictionary setObject: [memValues.M824 stringValue] forKey: @"HeaterOff"];
        [Dictionary setObject: [memValues.M814 stringValue] forKey: @"FeedTimer"];
        [Dictionary setObject: [memValues.M816 stringValue] forKey: @"LCDTimer"];
        [Dictionary setObject: [memValues.M818 stringValue] forKey: @"Overheat"];
        [Dictionary writeToFile:path atomically:YES];
        
        self.HeaterOn.text = [memValues.M822 stringValue];
        self.Actinic.value = [memValues.M821 integerValue];
        self.Daylight.value = [memValues.M820 integerValue];
        self.HeaterOff.text = [memValues.M824 stringValue];
        self.FeedTimer.text = [memValues.M814 stringValue];
        self.Overheat.text = [memValues.M818 stringValue];
        self.PWMD.text = [memValues.M820 stringValue];
        self.PWMA.text = [memValues.M821 stringValue];
        self.LCDTimer.text = [memValues.M816 stringValue];

        

        memValues = nil;
        [memValues release];
    }
    
}

-(void)updateValue:(NSString *) controllerUrl
{
    //[self.request clearDelegatesAndCancel];

    NSURL *url = [NSURL URLWithString: controllerUrl];
    ASIHTTPRequest *pushUpdate = [ASIHTTPRequest requestWithURL:url]; 
    [pushUpdate setShouldPresentAuthenticationDialog: YES];
    
    [pushUpdate startAsynchronous];
    NSLog(@"updating");
    
    
    
}
-(void)sendUpdate:(NSString *) controllerUrl
{
    //[self.request clearDelegatesAndCancel];
    
    
    NSURL *url = [NSURL URLWithString: controllerUrl];
    self.request = [ASIHTTPRequest requestWithURL:url]; 
    [self.request setDelegate:self];
    [self.request setDidReceiveDataSelector:@selector(request:didReceiveData:)];
    
    [self.request setShouldPresentAuthenticationDialog: YES];
    
    [self.request startAsynchronous];

    
}

- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    NSMutableArray *paramArray;
    memValues = [[MEM alloc] init] ;
    xmlParser = [[XmlParser alloc] init] ;
    self.response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    paramArray = [xmlParser fromXml:self.response withObject:memValues];

    memValues = [paramArray lastObject];

    [self UpdateUI:memValues];
   
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error;
    if(error)
    {
     
    }
    
}

-(BOOL)reachable{
    if ([self.enteredURL length] > 0) {
        
        NSString *testURL = [self.enteredURL substringFromIndex:7];
        Reachability *r = [Reachability reachabilityWithHostName:testURL];
        NetworkStatus internetStatus = [r currentReachabilityStatus];
        if(internetStatus == NotReachable) {
            return NO;
        }
        else
        {
            return YES;
        }
        
    }
    return NO;
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.request = nil;
    self.response = nil;
    self.HeaterOn = nil;
    self.HeaterOff = nil;
    self.FeedTimer = nil;
    self.Overheat = nil;
    self.PWMD = nil;
    self.PWMA = nil;
    self.LCDTimer = nil;
    self.wifiURL = nil;
    self.enteredURL = nil;
    self.fullURL = nil;
    self.Actinic = nil;
    self.Daylight = nil;
    self.daylightValue = nil;
    self.actinicValue = nil;
    self.heaterOnValue = nil;
    self.heaterOffValue = nil;
    self.feedTimerValue = nil;
    self.overheatValue = nil;
    self.LCDTimerValue = nil;
    self.sendUpdateMem = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void) dealloc
{
    [request release];
    [response release];
    [HeaterOn release];
    [HeaterOff release];
    [FeedTimer release];
    [Overheat release];
    [PWMD release];
    [PWMA release];
    [LCDTimer release];
    [wifiURL release];
    [enteredURL release];
    [fullURL release];
    [Actinic release];
    [Daylight release];
    [daylightValue release];
    [actinicValue release];
    [heaterOnValue release];
    [heaterOffValue release];
    [feedTimerValue release];
    [overheatValue release];
    [LCDTimerValue release];
    [sendUpdateMem release];
    [super dealloc];

}
@end
