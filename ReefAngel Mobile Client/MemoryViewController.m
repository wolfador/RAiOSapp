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
@synthesize HeaterOn, HeaterOff, FeedTimer, Overheat, PWMD, PWMA, LCDTimer, wifiURL, enteredURL, fullURL, Actinic, Daylight; 
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
        [self sendUpdate:fullURL];
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Memdata.plist"];
	
	NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
	NSString *Heaton = [restored objectForKey:@"HeaterOn"];
    NSString *Heatoff = [restored objectForKey:@"HeaterOff"];
    NSString *ActinicLED = [restored objectForKey:@"Actinic"];
    NSString *DayLight = [restored objectForKey:@"DayLight"];
     NSString *FeedTime = [restored objectForKey:@"FeedTimer"];
     NSString *LCDTime = [restored objectForKey:@"LCDTimer"];
    NSString *Overhot = [restored objectForKey:@"Overheat"];
     if ([self reachable]) {
    if ([Heaton isEqualToString:HeaterOn.text]) {
        NSLog(@"HeaterOn equal");
                    
        }
    else
    {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,HeaterOn.tag,HeaterOn.text];
            NSLog(@"%@", updateMemory);
            [self updateValue:updateMemory];


    }
    if ([Heatoff isEqualToString: HeaterOff.text]) {
               NSLog(@"Heatoff equal");  
    }
    else
    {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,HeaterOff.tag,HeaterOff.text];
            NSLog(@"%@", updateMemory);
            [self updateValue:updateMemory];
    }

    if ([FeedTime isEqualToString: FeedTimer.text]) {
   NSLog(@"FeedTime equal"); 
        
    }
    else
    {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,FeedTimer.tag,FeedTimer.text];
            NSLog(@"%@", updateMemory);
            [self updateValue:updateMemory];
    }
    if ([Overhot isEqualToString:Overheat.text]) {
        NSLog(@"Overhot equal"); 
           }
    else
    {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,Overheat.tag,Overheat.text];
            NSLog(@"%@", updateMemory);
            [self updateValue:updateMemory];
    }
    if ([DayLight isEqualToString:PWMD.text]) {
    NSLog(@"DayLight equal"); 
}
    else
    {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,PWMD.tag,PWMD.text];
        NSLog(@"%@", updateMemory);
        [self updateValue:updateMemory];

    }
if ([LCDTime isEqualToString:LCDTimer.text]) {
NSLog(@"LCDTime equal"); 
}
    else
    {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,LCDTimer.tag,LCDTimer.text];
        NSLog(@"%@", updateMemory);
        [self updateValue:updateMemory];
    }
    if ([ActinicLED isEqualToString:PWMA.text]) {
        NSLog(@"ActinicLED equal"); 
    }
    else
    {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,PWMA.tag,PWMA.text];
        NSLog(@"%@", updateMemory);
        [self updateValue:updateMemory];
    }
 
   // [self sendUpdate:fullURL]; updating values before parser is finished with new data. :(
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
        
        HeaterOn.text = [memValues.M822 stringValue];
        Actinic.value = [memValues.M821 integerValue];
        Daylight.value = [memValues.M820 integerValue];
        HeaterOff.text = [memValues.M824 stringValue];
        FeedTimer.text = [memValues.M814 stringValue];
        Overheat.text = [memValues.M818 stringValue];
        PWMD.text = [memValues.M820 stringValue];
        PWMA.text = [memValues.M821 stringValue];
        LCDTimer.text = [memValues.M816 stringValue];

        

        memValues = nil;
        [memValues release];
    }
    
}

-(void)updateValue:(NSString *) controllerUrl
{
    //[self.request clearDelegatesAndCancel];

    NSURL *url = [NSURL URLWithString: controllerUrl];
    ASIHTTPRequest *pushUpdate = [ASIHTTPRequest requestWithURL:url]; 
  //  [pushUpdate setDelegate:self];
    
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
    NSLog(@"%@", self.response);
    
    paramArray = [xmlParser fromXml:self.response withObject:memValues];
     NSLog(@"%@", paramArray);
    memValues = [paramArray lastObject];
    NSLog(@"%@", memValues);
    
    //[self formatRA:mem];
   // [self updateRelayBoxes:mem];
    [self UpdateUI:memValues];
   
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error;
    //NSLog(@"%@", error);
    if(error)
    {
      //  lastUpdatedLabel.text = @"Error";
       // lastUpdatedLabel.textColor = [UIColor redColor];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
