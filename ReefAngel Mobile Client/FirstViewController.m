//
//  FirstViewController.m
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/17/11 updated by John on 9/29/11.
//  Copyright 2011 Wolfador. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController
@synthesize temp1Label, temp2Label, temp3Label, pHLabel;
@synthesize wifiUrl, fullUrl,lastUpdatedLabel, current_version, directConnect;
@synthesize enteredURL, response, tempScale, salinityLabel, salinityValue, temp2Value, temp3Value, temp1Value;
@synthesize AIWvalue, AIBvalue, AIRBvalue, scrollView, AIWLabel, AIBLabel, AIRBLabel, receivedData;

- (void)viewDidLoad
{
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 500)];  
    
    self.scrollView.delegate = self;

        
    [super viewDidLoad];

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
                    
-(void)UpdateUI:(RA*)ra
{

    if(raParam)
    {
        self.temp1Value.text = [raParam.formattedTemp1 stringByAppendingString:self.tempScale];
        
        self.pHLabel.text    = raParam.formattedpH;
        //self.salinityValue.text = [raParam.SAL stringValue];
        self.salinityValue.text = raParam.formattedSal;
        
        raParam = nil;
        [raParam release];
    }

}

-(IBAction)refreshParams
{
    if ([self reachable]) {
        if ([self.directConnect isEqualToString:@"ON"])
        {
            self.fullUrl = [NSString stringWithFormat:@"%@r99",self.wifiUrl];
            [self sendUpdate:self.fullUrl];
        }
        else
        {
         [self sendUpdate:self.wifiUrl];
        }
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }
    else
    {
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
	}
}

-(void) loadData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
	
	NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
    self.directConnect = [restored objectForKey:@"DirectConnect"];
    if (![self.directConnect isEqualToString:@"ON"]) {
        
        self.wifiUrl = [restored objectForKey:@"RaURL"];
        self.enteredURL = @"forum.reefangel.com";

    }
    else
    {
        self.wifiUrl = [restored objectForKey:@"URL"];
        self.enteredURL = [restored objectForKey:@"EnteredURL"];
    }
	   self.tempScale = [restored objectForKey:@"TempScale"];
    self.temp1Label.text = [restored objectForKey:@"Temp1"];
    self.temp2Label.text = [restored objectForKey:@"Temp2"];
    self.temp3Label.text = [restored objectForKey:@"Temp3"];
    
    if ([self.temp1Label.text length] == 0) {
        self.temp1Label.text = @"Water:";
    }
    if ([self.temp2Label.text length] == 0) {
        self.temp2Label.text = @"Room:";
    }
    if ([self.temp3Label.text length] == 0) {
        self.temp3Label.text = @"Lights:";
    }
    
    NSString *colon = @":";
    NSRange range = [self.temp1Label.text rangeOfString : colon];
    if (range.location == NSNotFound) {
        self.temp1Label.text  = [self.temp1Label.text stringByAppendingString:colon];
    }
    NSRange range2 = [self.temp2Label.text rangeOfString : colon];
    if (range2.location == NSNotFound) {
        self.temp2Label.text  = [self.temp2Label.text stringByAppendingString:colon];
    }
    NSRange range3 = [self.temp3Label.text rangeOfString : colon];
    if (range3.location == NSNotFound) {
        self.temp3Label.text  = [self.temp3Label.text stringByAppendingString:colon];
    }
    
    
    if (self.tempScale == nil) {
        self.tempScale = @"*F";
    }
    if ([self reachable] && self.directConnect != NULL) {
        if ([self.directConnect isEqualToString:@"ON"])
        {
        self.fullUrl = [NSString stringWithFormat:@"%@r99",self.wifiUrl];
            [self sendUpdate:self.fullUrl];
        }
        else
        {
            [self sendUpdate:self.wifiUrl];
        }
    }
    
    else if (self.directConnect == NULL && [self.wifiUrl length] == 0)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Settings" message:@"Enter RA URL in settings." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadData];
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
    else
    {
        self.receivedData = [NSMutableData data];
    }
    lastUpdatedLabel.text = @"Updating";
    lastUpdatedLabel.textColor = [UIColor greenColor];
        
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.lastUpdatedLabel.text = @"Updating";
    [self.receivedData appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    xmlParser = [[XmlParser alloc] init] ;
    NSString *received = [[[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding] autorelease];
    self.response = [NSString stringWithString:received];
    
        raParam = [[RA alloc] init] ;
        
        paramArray = [xmlParser fromXml:self.response withObject:raParam];
        
        raParam = [paramArray lastObject];
        
        [self formatRA:raParam];
        [self UpdateUI:raParam];
        if (self.response != NULL) {
            if ([self.directConnect isEqualToString:@"ON"])
            {
            NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
            [formatter setDateFormat:@"MM/dd/yyyy h:mm:ss a"];
            NSDate *date = [NSDate date];
            self.lastUpdatedLabel.text = [formatter stringFromDate:date];
            self.lastUpdatedLabel.textColor = [UIColor greenColor];
            }
        }
        else
        {
            if (self.lastUpdatedLabel.text.length == 0) {
                self.lastUpdatedLabel.text = @"Please Refresh";
            }
            self.lastUpdatedLabel.textColor = [UIColor redColor];
            
        }
}

-(void)formatRA : (RA *)params
{
    
    if (![self.directConnect isEqualToString:@"ON"])
    {
    NSDateFormatter *dateformat = [[[NSDateFormatter alloc]init]autorelease];
    [dateformat setDateFormat:@"MM/dd/yyyy h:mm:ss a"];
    NSDate *date2 = [dateformat dateFromString: params.LOGDATE];
        NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:date2];
        NSDate *localDate = [date2 dateByAddingTimeInterval:timeZoneOffset];
        
    self.lastUpdatedLabel.text = [dateformat stringFromDate:localDate];
    self.lastUpdatedLabel.textColor = [UIColor greenColor];
}
    
    params.formattedTemp1 = [self formatTemp:params.T1];
    //hides T2 if not configured
    if ([params.T2 intValue] == 0) {
        self.temp2Value.text = @"N/A";
    }
    else
    {
        params.formattedTemp2 = [self formatTemp:params.T2];
        self.temp2Value.text = [raParam.formattedTemp2 stringByAppendingString:self.tempScale];
    }
    //hides T3 if not configured
    if ([params.T3 intValue] == 0) {
        self.temp3Value.text = @"N/A";
    }
    else
    {
        params.formattedTemp3 = [self formatTemp:params.T3];
        self.temp3Value.text = [raParam.formattedTemp3 stringByAppendingString:self.tempScale];
    }

    params.formattedpH = [self formatPh:params.PH];
    //hides Sal if not added to ReefAngel Features.
    
    
    if (params.SAL == NULL || [params.SAL intValue] == 0) {
        self.salinityLabel.hidden = YES;
        self.salinityValue.hidden = YES;
    }
    else if([params.SAL intValue] == 60)
    {
        self.salinityLabel.hidden = NO;
        self.salinityValue.hidden = NO;
        params.formattedSal = @"N/A";
    }

    else
    {
        self.salinityLabel.hidden = NO;
        self.salinityValue.hidden = NO;
       params.formattedSal = [self formatSal:params.SAL]; 
    }
    if ([self.directConnect isEqualToString:@"ON"]) {
    if (params.AIB != NULL && params.SAL == NULL) {
        
        //moves labels to compensate for Salinity not being enabled.
        NSString *percent = @"%";
        NSRange range = [self.AIBvalue.text rangeOfString : percent];
        if (range.location == NSNotFound) {
            
        CGRect BValuePosition = self.AIBvalue.frame;
        BValuePosition.origin.y = BValuePosition.origin.y - 45;
        self.AIBvalue.frame = BValuePosition;
        
        CGRect WValuePosition = self.AIWvalue.frame;
        WValuePosition.origin.y = WValuePosition.origin.y - 45;
        self.AIWvalue.frame = WValuePosition;
        
        CGRect RBValuePosition = self.AIRBvalue.frame;
        RBValuePosition.origin.y = RBValuePosition.origin.y - 45;
        self.AIRBvalue.frame = RBValuePosition;
        
        CGRect RBLabelPosition = self.AIRBLabel.frame;
        RBLabelPosition.origin.y = RBLabelPosition.origin.y - 45;
        self.AIRBLabel.frame = RBLabelPosition;
        
        CGRect BLabelPosition = self.AIBLabel.frame;
        BLabelPosition.origin.y = BLabelPosition.origin.y - 45;
        self.AIBLabel.frame = BLabelPosition;
        
        CGRect WLabelPosition = self.AIWLabel.frame;
        WLabelPosition.origin.y = WLabelPosition.origin.y - 45;
        self.AIWLabel.frame = WLabelPosition;
        }
        
        self.AIBvalue.hidden = NO;
        self.AIRBvalue.hidden = NO;
        self.AIWvalue.hidden = NO;
        self.AIBLabel.hidden = NO;
        self.AIRBLabel.hidden = NO;
        self.AIWLabel.hidden = NO;
        self.AIWvalue.text = [[params.AIW stringValue] stringByAppendingString:@"%"];
        self.AIBvalue.text = [[params.AIB stringValue] stringByAppendingString:@"%"];
        self.AIRBvalue.text = [[params.AIRB stringValue] stringByAppendingString:@"%"];
        [self.scrollView setScrollEnabled:YES];
        [self.scrollView setContentSize:CGSizeMake(320, 600)]; 

    }
    else if(params.AIB != NULL && params.SAL != NULL)
    {
        self.AIBvalue.hidden = NO;
        self.AIRBvalue.hidden = NO;
        self.AIWvalue.hidden = NO;
        self.AIBLabel.hidden = NO;
        self.AIRBLabel.hidden = NO;
        self.AIWLabel.hidden = NO;
        self.AIWvalue.text = [[params.AIW stringValue] stringByAppendingString:@"%"];
        self.AIBvalue.text = [[params.AIB stringValue] stringByAppendingString:@"%"];
        self.AIRBvalue.text = [[params.AIRB stringValue] stringByAppendingString:@"%"];
        [self.scrollView setScrollEnabled:YES];
        [self.scrollView setContentSize:CGSizeMake(320, 650)]; 
        
    }
    else
    {
        
        self.AIBvalue.hidden = YES;
        self.AIRBvalue.hidden = YES;
        self.AIWvalue.hidden = YES;
        self.AIBLabel.hidden = YES;
        self.AIRBLabel.hidden = YES;
        self.AIWLabel.hidden = YES; 
        [self.scrollView setScrollEnabled:NO];
    }
    }
    else if ([params.EM intValue] == 4)
    {
        NSString *percent = @"%";
        NSRange range = [self.AIBvalue.text rangeOfString : percent];
        if (range.location == NSNotFound) {
            
            CGRect BValuePosition = self.AIBvalue.frame;
            BValuePosition.origin.y = BValuePosition.origin.y - 45;
            self.AIBvalue.frame = BValuePosition;
            
            CGRect WValuePosition = self.AIWvalue.frame;
            WValuePosition.origin.y = WValuePosition.origin.y - 45;
            self.AIWvalue.frame = WValuePosition;
            
            CGRect RBValuePosition = self.AIRBvalue.frame;
            RBValuePosition.origin.y = RBValuePosition.origin.y - 45;
            self.AIRBvalue.frame = RBValuePosition;
            
            CGRect RBLabelPosition = self.AIRBLabel.frame;
            RBLabelPosition.origin.y = RBLabelPosition.origin.y - 45;
            self.AIRBLabel.frame = RBLabelPosition;
            
            CGRect BLabelPosition = self.AIBLabel.frame;
            BLabelPosition.origin.y = BLabelPosition.origin.y - 45;
            self.AIBLabel.frame = BLabelPosition;
            
            CGRect WLabelPosition = self.AIWLabel.frame;
            WLabelPosition.origin.y = WLabelPosition.origin.y - 45;
            self.AIWLabel.frame = WLabelPosition;
        }
        self.AIBvalue.hidden = NO;
        self.AIRBvalue.hidden = NO;
        self.AIWvalue.hidden = NO;
        self.AIBLabel.hidden = NO;
        self.AIRBLabel.hidden = NO;
        self.AIWLabel.hidden = NO;
        self.AIWvalue.text = [[params.AIW stringValue] stringByAppendingString:@"%"];
        self.AIBvalue.text = [[params.AIB stringValue] stringByAppendingString:@"%"];
        self.AIRBvalue.text = [[params.AIRB stringValue] stringByAppendingString:@"%"];
        [self.scrollView setScrollEnabled:YES];
         [self.scrollView setContentSize:CGSizeMake(320, 650)]; 
    }
    else if([params.EM intValue] == 0)
    {
        self.AIBvalue.hidden = YES;
        self.AIRBvalue.hidden = YES;
        self.AIWvalue.hidden = YES;
        self.AIBLabel.hidden = YES;
        self.AIRBLabel.hidden = YES;
        self.AIWLabel.hidden = YES;
        self.salinityLabel.hidden = YES;
        self.salinityValue.hidden = YES;
    }

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

-(NSString *) formatSal : (NSNumber *)sal
{   
    NSString *tempString = [sal stringValue];
    NSString *retString;
    
    if([tempString length] >= 3)
    {
        
        retString = [[[tempString substringToIndex:[tempString length]-1] stringByAppendingString:@"."] stringByAppendingString:[tempString substringFromIndex:[tempString length]-1]];  
        return retString;
    }
    else if([tempString length] == 1)
    {
        
        retString = [tempString stringByAppendingString:@".00"]; 
        return retString;
    }
    else
    {
        retString = [tempString stringByAppendingString:@".00"];
        return retString;    
    }
}

-(NSString *) formatPh : (NSNumber *)pH
{
    NSString *tempString = [pH stringValue];
    NSString *retString;
    
    if([tempString length] >= 3)
    {
        
        retString = [[[tempString substringToIndex:[tempString length]-2] stringByAppendingString:@"."] stringByAppendingString:[tempString substringFromIndex:[tempString length]-2]];  
        return retString;
    }
    else if([tempString length] == 1)
    {
        
        retString = [tempString stringByAppendingString:@".00"]; 
        return retString;
    }
    else
    {
        retString = [tempString stringByAppendingString:@".00"];
        return retString;    
    }
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    self.temp1Label = nil;
    self.temp2Label = nil;
    self.temp3Label = nil;
    self.pHLabel = nil;
    self.lastUpdatedLabel = nil;
    self.salinityLabel = nil;
    
    }

- (void)viewDidUnload
{
    

    self.temp1Label = nil;
    self.temp2Label = nil;
    self.temp3Label = nil;
    self.pHLabel = nil;
    self.lastUpdatedLabel = nil;
    self.scrollView = nil;
    self.temp1Value = nil;
    self.response = nil;
    self.tempScale = nil;
    self.salinityLabel = nil;
    self.salinityValue = nil;
    self.fullUrl = nil;
    self.wifiUrl = nil;
    self.scrollView = nil;
    self.AIBvalue = nil;
    self.AIWvalue = nil;
    self.AIRBvalue = nil;
    self.AIBLabel = nil;
    self.AIRBLabel = nil;
    self.AIWLabel = nil;
    self.receivedData = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [temp1Label release];
    [temp2Label release];
    [temp3Label release];
    [pHLabel release];
    [lastUpdatedLabel release];
    [response release];
    [tempScale release];
    [paramArray release];
    [salinityLabel release];
    [salinityValue release];
    [fullUrl release];
    [wifiUrl release];
    [temp1Value release];
    [temp2Value release];
    [temp3Value release];
    [AIBvalue release];
    [AIRBvalue release];
    [AIWvalue release];
    [scrollView release];
    [AIBLabel release];
    [AIRBLabel release];
    [AIRBLabel release];
    [receivedData release];
    [raParam release];
    [xmlParser release];
    
    [super dealloc];
    
}

@end
