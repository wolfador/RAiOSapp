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
@synthesize wifiUrl,fullUrl,lastUpdatedLabel, current_version;
@synthesize enteredURL, response, tempScale, salinityLabel, salinityValue, temp2Value, temp3Value, temp1Value;


- (void)viewDidLoad
{
        
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
        self.salinityValue.text = raParam.formattedSal;
        

        
        raParam = nil;
        [raParam release];
    }

}

-(void)SendUpdate:(NSString *)url
{
    [self sendUpdate:url];

    [self UpdateUI:raParam];
}

-(IBAction)refreshParams
{
    if ([self reachable]) {
        self.fullUrl = [NSString stringWithFormat:@"%@r99",self.wifiUrl];
        [self SendUpdate:self.fullUrl];
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
	self.wifiUrl = [restored objectForKey:@"URL"];
    self.enteredURL = [restored objectForKey:@"EnteredURL"];
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
    
    if ([self reachable]) {
        self.fullUrl = [NSString stringWithFormat:@"%@r99",self.wifiUrl];
            NSString *version = [NSString stringWithFormat:@"%@v",self.wifiUrl];
        [self SendUpdate:version];
            //[self SendUpdate:self.fullUrl];
    }
    else if ([self.enteredURL length] == 0)
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
    lastUpdatedLabel.text = @"Updating";
    lastUpdatedLabel.textColor = [UIColor greenColor];
        
}
/*
-(void)sendMode:(NSString *) controllerUrl
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
*/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    xmlParser = [[XmlParser alloc] init] ;
    NSString *receivedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.response = [NSString stringWithString:receivedData];
    [receivedData release];
    

    NSRange range2 = [self.response rangeOfString:@"</V>" options:NSCaseInsensitiveSearch];
    if(range2.location != NSNotFound )
    {
        //removes <V> and </V>
            NSString *newStr = [self.response stringByReplacingOccurrencesOfString:@"<V>" withString:@""];
            NSString *version = [newStr stringByReplacingOccurrencesOfString:@"</V>" withString:@""];
            self.current_version = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        [self ConfigureUI:self.current_version];
        
        self.fullUrl = [NSString stringWithFormat:@"%@r99",self.wifiUrl];
        [self SendUpdate:self.fullUrl];

    }
    else
    {
        raParam = [[RA alloc] init] ;
        
    paramArray = [xmlParser fromXml:self.response withObject:raParam];
    
    raParam = [paramArray lastObject];
    
    [self formatRA:raParam];
    [self UpdateUI:raParam];
    if (self.response != NULL) {
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateFormat:@"MMM dd yyyy : hh:mm:ss a"];
        NSDate *date = [NSDate date];
        self.lastUpdatedLabel.text = [formatter stringFromDate:date];
        self.lastUpdatedLabel.textColor = [UIColor greenColor];
    }
    else
    {
        if (self.lastUpdatedLabel.text.length == 0) {
            self.lastUpdatedLabel.text = @"Please Refresh";
        }
        self.lastUpdatedLabel.textColor = [UIColor redColor];
        
    }
    [self UpdateUI:raParam];
    
    [raParam release];
    
    }
    [xmlParser release];
    
}

-(void)ConfigureUI:(NSString*) ver
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *version = [f numberFromString:ver];
    [f release];
    if ([version intValue] <= 8518) {
        
    
    }
    else
    {
        
    }

}

-(void)formatRA : (RA *)params
{
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
    if (params.SAL == NULL) {
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
        
        retString = [[[tempString substringToIndex:[tempString length]-3] stringByAppendingString:@"."] stringByAppendingString:[tempString substringFromIndex:[tempString length]-3]];  
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
    //self.scrollView = nil;
    self.temp1Value = nil;
    self.response = nil;
    self.tempScale = nil;
    self.salinityLabel = nil;
    self.salinityValue = nil;
    self.fullUrl = nil;
    self.wifiUrl = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [temp1Label release];
    [temp2Label release];
    [temp3Label release];
    [pHLabel release];
    [lastUpdatedLabel release];
    //[scrollView release];
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
    [super dealloc];
    
}

@end
