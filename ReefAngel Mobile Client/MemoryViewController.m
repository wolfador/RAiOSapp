//
//  MemoryViewController.m
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 10/1/11.
//  Copyright (c) 2011 Wolfador. All rights reserved.
//

#import "MemoryViewController.h"

@implementation MemoryViewController
@synthesize delegate = _delegate;
@synthesize HeaterOn, HeaterOff, FeedTimer, Overheat, PWMD, PWMA, LCDTimer, wifiURL, enteredURL, fullURL, Actinic, Daylight, daylightValue, actinicValue, heaterOnValue, heaterOffValue, feedTimerValue, overheatValue, LCDTimerValue, sendUpdateMem, ForC, ForC2, ForC3, MHOnHour, MHOnMin, MHOffHour, MHOffMin, StdOnHour, StdOnMin, StdOffHour, StdOffMin, scrollView, MHOnHourValue, MHOnMinValue, MHOffHourValue, MHOffMinValue, StdOnHourValue, StdOnMinValue, StdOffHourValue, StdOffMinValue, tempScale, DP1Hr, DP1Min, DP2Hr, DP2Min, DP1Int, DP2Int;
@synthesize DP1HrValue, DP1MinValue, DP2HrValue, DP2MinValue, DP1IntValue, DP2IntValue, custom, customLoc;

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

-(IBAction) textFieldDoneEditing : (id) sender
{
    [sender resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.HeaterOn resignFirstResponder];
    [self.HeaterOff resignFirstResponder];
    [self.FeedTimer resignFirstResponder];
    [self.Overheat resignFirstResponder];
    [self.PWMD resignFirstResponder];
    [self.PWMA resignFirstResponder];
    [self.LCDTimer resignFirstResponder];
	return YES;
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

         [self updateValue:self.sendUpdateMem];
         
    }
    if (sender.tag == 821) {
        self.sendUpdateMem = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.PWMA.tag,self.PWMA.text];
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
    self.tempScale = [restored objectForKey:@"TempScale"];
    
    
    if (self.tempScale == nil) {
        self.tempScale = @"*F";
    }
    if([[restored objectForKey:@"DirectConnect"] isEqualToString: @"OFF"])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Turn on Direct Connect" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    else if ([self reachable]) {
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
-(IBAction)updateTime
{
    //http://CONTROLLER_IP:2000/d0930,0808,11
    /*
     <D>
     <HR>11</HR>
     <MIN>25</MIN>
     <MON>1</MON>
     <DAY>23</DAY>
     <YR>2000</YR>
     </D>
     */
    NSDate* sourceDate = [NSDate date];
    
    NSDateFormatter *dateformat = [[[NSDateFormatter alloc]init]autorelease];
    //[dateformat setDateFormat:@"MM/dd/yyyy h:mm:ss a"];
    [dateformat setDateFormat:@"HHmm,MMdd,yy"];
    NSString *date2 = [dateformat stringFromDate:sourceDate];
    NSString *updateTime = [NSString stringWithFormat:@"%@d%@ ",self.wifiURL,date2];
    [self sendUpdate:updateTime];
    
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
    self.MHOffHourValue = [restored objectForKey:@"MHOffHour"];
    self.MHOffMinValue = [restored objectForKey:@"MHOffMin"];
    self.MHOnHourValue = [restored objectForKey:@"MHOnHour"];
    self.MHOnMinValue = [restored objectForKey:@"MHOnMin"];
    self.StdOffHourValue = [restored objectForKey:@"StdOffHour"];
    self.StdOffMinValue = [restored objectForKey:@"StdOffMin"];
    self.StdOnHourValue = [restored objectForKey:@"StdOnHour"];
    self.StdOnMinValue = [restored objectForKey:@"StdOnMin"];

    self.DP1HrValue = [restored objectForKey:@"DP1Hr"];
    self.DP1MinValue = [restored objectForKey:@"DP1Min"];
    self.DP1IntValue = [restored objectForKey:@"DP1Int"];
    self.DP2HrValue = [restored objectForKey:@"DP2Hr"];
    self.DP2MinValue = [restored objectForKey:@"DP2Min"];
    self.DP2IntValue = [restored objectForKey:@"DP2Int"];
    
    
     if ([self reachable]) {
    if (![self.heaterOnValue isEqualToString:self.HeaterOn.text]) {
      
        NSString *replaceDecimal = [self.HeaterOn.text stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSMutableString *updatedValue = [NSMutableString stringWithString:replaceDecimal];
        if ([replaceDecimal length] <= 2) {
            
            self.HeaterOn.text = [updatedValue stringByAppendingString:@".0"];
            [updatedValue appendString:@"0"];
            
        }
        NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.HeaterOn.tag,updatedValue];
            [self updateValue:updateMemory];
    }
    if (![self.heaterOffValue isEqualToString: self.HeaterOff.text]) {
        NSString *replaceDecimal = [self.HeaterOff.text stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSMutableString *updatedValue = [NSMutableString stringWithString:replaceDecimal];
        if ([replaceDecimal length] <= 2) {
            
            self.HeaterOff.text = [updatedValue stringByAppendingString:@".0"];
            [updatedValue appendString:@"0"];
            
        }
            NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.HeaterOff.tag,updatedValue];
            [self updateValue:updateMemory];
    }

    if (![self.feedTimerValue isEqualToString: self.FeedTimer.text]) {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.FeedTimer.tag,self.FeedTimer.text];
            [self updateValue:updateMemory];
    }
    if (![self.overheatValue isEqualToString:self.Overheat.text]) {
        NSString *replaceDecimal = [self.Overheat.text stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSMutableString *updatedValue = [NSMutableString stringWithString:replaceDecimal];
        if ([replaceDecimal length] <= 3) {

                self.Overheat.text = [updatedValue stringByAppendingString:@".0"];
            [updatedValue appendString:@"0"];
            
        }
            NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.Overheat.tag,updatedValue];
            [self updateValue:updateMemory];
    }
    if (![self.daylightValue isEqualToString:self.PWMD.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.PWMD.tag,self.PWMD.text];
        [self updateValue:updateMemory];
    }
         if (![self.LCDTimerValue isEqualToString:self.LCDTimer.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mi%i,%@ ",self.wifiURL,self.LCDTimer.tag,self.LCDTimer.text];
        [self updateValue:updateMemory];
    }
    if (![self.actinicValue isEqualToString:self.PWMA.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.PWMA.tag,self.PWMA.text];
        [self updateValue:updateMemory];
    }
    if (![self.MHOffHourValue isEqualToString:self.MHOffHour.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.MHOffHour.tag,self.MHOffHour.text];
        [self updateValue:updateMemory];
         }    
    if (![self.MHOffMinValue isEqualToString:self.MHOffMin.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.MHOffMin.tag,self.MHOffMin.text];
        [self updateValue:updateMemory];
         }
    if (![self.MHOnHourValue isEqualToString:self.MHOnHour.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.MHOnHour.tag,self.MHOnHour.text];
        [self updateValue:updateMemory];
         }   
    if (![self.MHOnMinValue isEqualToString:self.MHOnMin.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.MHOnMin.tag,self.MHOnMin.text];
        [self updateValue:updateMemory];
         } 
    if (![self.StdOffHourValue isEqualToString:self.StdOffHour.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.StdOffHour.tag,self.StdOffHour.text];
        [self updateValue:updateMemory];
         }    
    if (![self.StdOffMinValue isEqualToString:self.StdOffMin.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.StdOffMin.tag,self.StdOffMin.text];
        [self updateValue:updateMemory];
         }  
    if (![self.StdOnHourValue isEqualToString:self.StdOnHour.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.StdOnHour.tag,self.StdOnHour.text];
        [self updateValue:updateMemory];
         } 
    if (![self.StdOnMinValue isEqualToString:self.StdOnMin.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.StdOnMin.tag,self.StdOnMin.text];
        [self updateValue:updateMemory];
         }  
    if (![self.DP1HrValue isEqualToString:self.DP1Hr.text]) {
        
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.DP1Hr.tag,self.DP1Hr.text];
        [self updateValue:updateMemory];
        
         }  
    if (![self.DP2HrValue isEqualToString:self.DP2Hr.text]) {
        NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.DP2Hr.tag,self.DP2Hr.text];
        [self updateValue:updateMemory];
        
    }
        if (![self.DP1MinValue isEqualToString:self.DP1Min.text]) {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.DP1Min.tag,self.DP1Min.text];
            [self updateValue:updateMemory];
            
        }  
        if (![self.DP2MinValue isEqualToString:self.DP2Min.text]) {
            NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.DP2Min.tag,self.DP2Min.text];
            [self updateValue:updateMemory];   
            
        }
         if (![self.DP1IntValue isEqualToString:self.DP1Int.text]) {
             NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.DP1Int.tag,self.DP1Int.text];
             [self updateValue:updateMemory];
             
         }  
         if (![self.DP2IntValue isEqualToString:self.DP2Int.text]) {
             NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.DP2Int.tag,self.DP2Int.text];
             [self updateValue:updateMemory];    
             
         }         
         if ([self.custom.text length] > 0 && [self.customLoc.text length] > 0 ) {
             NSString *updateMemory = [NSString stringWithFormat:@"%@mb%i,%@ ",self.wifiURL,self.customLoc.text,self.custom.text];
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
        
        
        [Dictionary setObject: self.HeaterOn.text forKey: @"HeaterOn"];
        [Dictionary setObject: [memValues.M821 stringValue] forKey: @"Actinic"];
        [Dictionary setObject: [memValues.M820 stringValue] forKey: @"Daylight"];
        [Dictionary setObject: self.HeaterOff.text forKey: @"HeaterOff"];
        [Dictionary setObject: [memValues.M814 stringValue] forKey: @"FeedTimer"];
        [Dictionary setObject: [memValues.M816 stringValue] forKey: @"LCDTimer"];
        [Dictionary setObject: self.Overheat.text forKey: @"Overheat"];
        [Dictionary setObject: [memValues.M802 stringValue] forKey:@"MHOffHour"];
        [Dictionary setObject: [memValues.M803 stringValue] forKey:@"MHOffMin"];
        [Dictionary setObject: [memValues.M800 stringValue] forKey:@"MHOnHour"];
        [Dictionary setObject: [memValues.M801 stringValue] forKey:@"MHOnMin"];
        [Dictionary setObject: [memValues.M806 stringValue] forKey:@"StdOffHour"];
        [Dictionary setObject: [memValues.M807 stringValue] forKey:@"StdOffMin"];
        [Dictionary setObject: [memValues.M804 stringValue] forKey:@"StdOnHour"];
        [Dictionary setObject: [memValues.M805 stringValue] forKey:@"StdOnMin"];
        [Dictionary setObject: [memValues.M836 stringValue] forKey:@"DP1Hr"];
        [Dictionary setObject: [memValues.M837 stringValue] forKey:@"DP1Min"];
        [Dictionary setObject: [memValues.M843 stringValue] forKey:@"DP1Int"];
        [Dictionary setObject: [memValues.M838 stringValue] forKey:@"DP2Hr"];
        [Dictionary setObject: [memValues.M839 stringValue] forKey:@"DP2Min"];
        [Dictionary setObject: [memValues.M845 stringValue] forKey:@"DP2Int"];

        [Dictionary writeToFile:path atomically:YES];
        
        self.Actinic.value = [memValues.M821 integerValue];
        self.Daylight.value = [memValues.M820 integerValue];
        self.FeedTimer.text = [memValues.M814 stringValue];
        self.PWMD.text = [memValues.M820 stringValue];
        self.PWMA.text = [memValues.M821 stringValue];
        self.LCDTimer.text = [memValues.M816 stringValue];
        self.MHOffHour.text = [memValues.M802 stringValue];
        self.MHOffMin.text = [memValues.M803 stringValue];
        self.MHOnHour.text = [memValues.M800 stringValue];
        self.MHOnMin.text = [memValues.M801 stringValue];
        self.StdOffHour.text = [memValues.M806 stringValue];
        self.StdOffMin.text = [memValues.M807 stringValue];
        self.StdOnHour.text = [memValues.M804 stringValue];
        self.StdOnMin.text = [memValues.M805 stringValue];
        self.DP1Hr.text = [memValues.M836 stringValue];
        self.DP1Min.text = [memValues.M837 stringValue];
        self.DP1Int.text = [memValues.M843 stringValue];

        self.DP2Hr.text = [memValues.M838 stringValue];
        self.DP2Min.text = [memValues.M839 stringValue];
        self.DP2Int.text = [memValues.M845 stringValue];
        

        memValues = nil;
        [memValues release];
    }
    
}

-(void)formatRA : (MEM *)params
{
    self.HeaterOn.text = [self formatTemp:memValues.M822];
        self.ForC.text = self.tempScale;
        self.ForC2.text = self.tempScale;
        self.ForC3.text = self.tempScale;
    
    self.HeaterOff.text = [self formatTemp:memValues.M824];
    self.Overheat.text = [self formatTemp:memValues.M818];
    
}

-(NSString *) formatTemp : (NSNumber *)temp
{   
    NSString *tempString = [temp stringValue];
    NSString *retString;
    if([tempString length] >= 3)
    {
        retString = [[[tempString substringToIndex:[tempString length]-1] stringByAppendingString:@"."] stringByAppendingString:[tempString substringFromIndex:[tempString length]-1]];          
    }
    else
    {
        retString = [tempString stringByAppendingString:@".0"];
    }
    
    
    return retString;
    
    
}

-(void)updateValue:(NSString *) controllerUrl
{
    NSURL *url = [NSURL URLWithString: controllerUrl];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:url                        
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                              
                                          timeoutInterval:60.0];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    if(!theConnection)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    
}

-(void)sendUpdate:(NSString *) controllerUrl
{
    NSURL *url = [NSURL URLWithString: controllerUrl];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:url                        
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                              
                                          timeoutInterval:60.0];
    
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:theRequest delegate:self];    
    if (!theConnection) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
        
    }

    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{    
    NSString *memData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSRange range = [memData rangeOfString:@">OK</" options:NSCaseInsensitiveSearch];
    if( range.location != NSNotFound ) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Updated" message:@"Mem updated" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    else
    {
    memValues = [[MEM alloc] init] ;
    xmlParser = [[XmlParser alloc] init] ;
    
    
    
    paramArray = [xmlParser fromXml:memData withObject:memValues];
    
    memValues = [paramArray lastObject];
    
    [self formatRA:memValues];
    [self UpdateUI:memValues];
      
        
    }
    [memData release];
}

-(BOOL)reachable
{
    NSString *http = @"http://";
    NSRange range = [self.enteredURL rangeOfString : http];
    if (range.location == NSNotFound) {
        
        NSString *testURL = [NSString stringWithString:self.enteredURL];
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
    else
    {
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
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 1250)];     
    self.scrollView.delegate = self;
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    self.MHOnMin = nil;
    self.MHOnHour = nil;
    self.MHOffMin = nil;
    self.MHOffHour = nil;
    self.StdOnHour = nil;
    self.StdOnMin = nil;
    self.StdOffHour = nil;
    self.StdOffMin = nil;
    self.scrollView = nil;
    self.MHOnMinValue = nil;
    self.MHOnHourValue = nil;
    self.MHOffMinValue = nil;
    self.MHOffHourValue = nil;
    self.StdOnHourValue = nil;
    self.StdOnMinValue = nil;
    self.StdOffHourValue = nil;
    self.StdOffMinValue = nil;
    self.DP1Hr = nil;
    self.DP1Min = nil;
    self.DP2Hr = nil;
    self.DP2Min = nil;
    self.DP1Int = nil;
    self.DP2Int = nil;
    self.DP1HrValue = nil;
    self.DP1MinValue = nil;
    self.DP2HrValue = nil;
    self.DP2MinValue = nil;
    self.DP1IntValue = nil;
    self.DP2IntValue = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
	}
}

-(void) dealloc
{
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
    [MHOnHour release];
    [MHOnMin release];
    [MHOffHour release];
    [MHOffMin release];
    [StdOffHour release];
    [StdOffMin release];
    [StdOnHour release];
    [StdOnMin release];
    [scrollView release];
    [MHOnHourValue release];
    [MHOnMinValue release];
    [MHOffHourValue release];
    [MHOffMinValue release];
    [StdOffHourValue release];
    [StdOffMinValue release];
    [StdOnHourValue release];
    [StdOnMinValue release];
    [DP1Hr release];
    [DP1Min release];
    [DP1Int release];
    [DP2Hr release];
    [DP2Min release];
    [DP2Int release];
    [DP1HrValue release];
    [DP1MinValue release];
    [DP1IntValue release];
    [DP2HrValue release];
    [DP2MinValue release];
    [DP2IntValue release];
    [super dealloc];

}
@end
