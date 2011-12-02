//
//  SecondViewController.m
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/17/11 updated by John on 9/29/11.
//  Copyright 2011 Wolfador. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController


@synthesize enteredURL, scrollView, url, port, updatedURL, temp1, temp2, temp3, response;
@synthesize relayExp, relay1, relay2, relay3, relay4, relay5, relay6, relay7, relay8;
@synthesize exprelay1, exprelay2, exprelay3, exprelay4, exprelay5, exprelay6, exprelay7, exprelay8, userName;
@synthesize exprelay1Label, exprelay2Label, exprelay3Label, exprelay4Label, exprelay5Label, exprelay6Label, exprelay7Label, exprelay8Label, tempScale, loadNames, bannerUrl, hideNames, showNames, receivedData, raURL;
@synthesize  relay1Label, relay2Label, relay3Label, relay4Label, relay5Label, relay6Label, relay7Label, relay8Label, temp1Label, temp2Label, temp3Label, directConnect;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
    
    [super viewDidLoad];   
    [self loadData];
    [self.scrollView setScrollEnabled:YES];
    if(self.relayExp.on)    
    {
        [self.scrollView setContentSize:CGSizeMake(320, 1200)];
    }
    else
    {
      [self.scrollView setContentSize:CGSizeMake(320, 430)];  
    }
    
    self.scrollView.delegate = self;
}

-(BOOL)reachable
{

    
        NSString *testURL = @"forum.reefangel.com";
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.url resignFirstResponder];
    [self.temp1 resignFirstResponder];
    [self.temp2 resignFirstResponder];
    [self.temp3 resignFirstResponder];
    [self.relay1 resignFirstResponder];
    [self.relay2 resignFirstResponder];
    [self.relay3 resignFirstResponder];
    [self.relay4 resignFirstResponder];
    [self.relay5 resignFirstResponder];
    [self.relay6 resignFirstResponder];
    [self.relay7 resignFirstResponder];
    [self.relay8 resignFirstResponder];
    [self.port resignFirstResponder];
    [self.userName resignFirstResponder];
    if(relayExp.on)    
    {
        [self.exprelay1 resignFirstResponder];
        [self.exprelay2 resignFirstResponder];
        [self.exprelay3 resignFirstResponder];
        [self.exprelay4 resignFirstResponder];
        [self.exprelay5 resignFirstResponder];
        [self.exprelay6 resignFirstResponder];
        [self.exprelay7 resignFirstResponder];
        [self.exprelay8 resignFirstResponder];
    }
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)activeScrollView 
{
    
    [self hideKeyboard];
    
}

-(IBAction) textFieldDoneEditing : (id) sender
{
    [sender resignFirstResponder];
    }

-(IBAction) hideKeyboard
{
    
    [self.url resignFirstResponder];
    [self.port resignFirstResponder];
    [self.temp1 resignFirstResponder];
    [self.temp2 resignFirstResponder];
    [self.temp3 resignFirstResponder];
    [self.relay1 resignFirstResponder];
    [self.relay2 resignFirstResponder];
    [self.relay3 resignFirstResponder];
    [self.relay4 resignFirstResponder];
    [self.relay5 resignFirstResponder];
    [self.relay6 resignFirstResponder];
    [self.relay7 resignFirstResponder];
    [self.relay8 resignFirstResponder];
    [self.userName resignFirstResponder];
    if(relayExp.on)    
    {
        [self.exprelay1 resignFirstResponder];
        [self.exprelay2 resignFirstResponder];
        [self.exprelay3 resignFirstResponder];
        [self.exprelay4 resignFirstResponder];
        [self.exprelay5 resignFirstResponder];
        [self.exprelay6 resignFirstResponder];
        [self.exprelay7 resignFirstResponder];
        [self.exprelay8 resignFirstResponder];
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

- (IBAction)flipMemory
{    
    memcontroller = [[MemoryViewController alloc] initWithNibName:@"MemoryViewController" bundle:nil] ;
    memcontroller.delegate = self;
    memcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:memcontroller animated:YES];
}

- (void)memoryViewControllerDidFinish:(MemoryViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction) saveData
{
    [self hideKeyboard];
    if ([self.url.text length] == 0 && self.directConnect.on) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Enter a URL" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    else
    {

        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
        
		NSMutableDictionary *Dictionary = [NSMutableDictionary dictionary];
		NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
		[Dictionary addEntriesFromDictionary:restored];
       self.enteredURL = [NSMutableString stringWithString:self.url.text];
        NSString *http = @"http://";
        NSRange range = [self.url.text rangeOfString : http];
        if (range.location == NSNotFound) {
            self.updatedURL = [NSMutableString stringWithFormat:@"%@%@",http,self.enteredURL];
        }
        else
        {
            self.updatedURL = [NSMutableString stringWithString:self.enteredURL];
        }
        
            BOOL portColon;
            
            portColon = [self.updatedURL hasSuffix:@":"];
            
            if (!portColon)
            {
                [self.updatedURL appendString:@":"];
            }
            [self.updatedURL appendString:self.port.text];
            BOOL endingSlash;
            
            endingSlash = [self.updatedURL hasSuffix:@"/"];
            
            if (!endingSlash)
            {
                [self.updatedURL appendString:@"/"];
            }
            

		[Dictionary setObject: self.enteredURL forKey: @"EnteredURL"];
        [Dictionary setObject: self.updatedURL forKey: @"URL"];
        [Dictionary setObject: self.port.text forKey: @"Port"];
        [Dictionary setObject: self.relay1.text forKey: @"Relay1"];
        [Dictionary setObject: self.relay2.text forKey: @"Relay2"];
        [Dictionary setObject: self.relay3.text forKey: @"Relay3"];
        [Dictionary setObject: self.relay4.text forKey: @"Relay4"];
        [Dictionary setObject: self.relay5.text forKey: @"Relay5"];
        [Dictionary setObject: self.relay6.text forKey: @"Relay6"];
        [Dictionary setObject: self.relay7.text forKey: @"Relay7"];
        [Dictionary setObject: self.relay8.text forKey: @"Relay8"];
        [Dictionary setObject: self.temp1.text forKey: @"Temp1"];
        [Dictionary setObject: self.temp2.text forKey: @"Temp2"];
        [Dictionary setObject: self.temp3.text forKey: @"Temp3"];
        [Dictionary setObject: self.userName.text forKey: @"UserName"];
        if ([self.userName.text length] > 0 && !self.directConnect.on) {
            NSString *forumURL = [NSString stringWithString:@"http://forum.reefangel.com/status/params.aspx?id="];
            self.raURL = [forumURL stringByAppendingString:self.userName.text];
        [Dictionary setObject: self.raURL forKey: @"RaURL"];
            [Dictionary setObject: @"OFF" forKey: @"DirectConnect"];
                                  
        }
        if (self.directConnect.on) {
            [Dictionary setObject: @"ON" forKey: @"DirectConnect"];
        }
        if (self.tempScale.selectedSegmentIndex == 0) {
            [Dictionary setObject: @"*F" forKey: @"TempScale"];
        }
        else if (self.tempScale.selectedSegmentIndex == 1) {
            [Dictionary setObject: @"*C" forKey: @"TempScale"];
        }
		
        if(relayExp.on)    
        {
            [Dictionary setObject: @"ON" forKey: @"ExpansionON"];
            [Dictionary setObject: self.exprelay1.text forKey: @"ExpRelay1"];
            [Dictionary setObject: self.exprelay2.text forKey: @"ExpRelay2"];
            [Dictionary setObject: self.exprelay3.text forKey: @"ExpRelay3"];
            [Dictionary setObject: self.exprelay4.text forKey: @"ExpRelay4"];
            [Dictionary setObject: self.exprelay5.text forKey: @"ExpRelay5"];
            [Dictionary setObject: self.exprelay6.text forKey: @"ExpRelay6"];
            [Dictionary setObject: self.exprelay7.text forKey: @"ExpRelay7"];
            [Dictionary setObject: self.exprelay8.text forKey: @"ExpRelay8"];
        }
        else
        {
          [Dictionary setObject: @"OFF" forKey: @"ExpansionON"];  
        }
        [Dictionary writeToFile:path atomically:YES];
    }    
}

-(void) loadData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
	
	NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
	self.url.text = [restored objectForKey:@"EnteredURL"];
    self.port.text = [restored objectForKey:@"Port"];
    self.relay1.text = [restored objectForKey:@"Relay1"];
    self.relay2.text = [restored objectForKey:@"Relay2"];
    self.relay3.text = [restored objectForKey:@"Relay3"];
    self.relay4.text = [restored objectForKey:@"Relay4"];
    self.relay5.text = [restored objectForKey:@"Relay5"];
    self.relay6.text = [restored objectForKey:@"Relay6"];
    self.relay7.text = [restored objectForKey:@"Relay7"];
    self.relay8.text = [restored objectForKey:@"Relay8"];
    self.temp1.text = [restored objectForKey:@"Temp1"];
    self.temp2.text = [restored objectForKey:@"Temp2"];
    self.temp3.text = [restored objectForKey:@"Temp3"];
    self.userName.text = [restored objectForKey:@"UserName"];
    if ([self.userName.text length] == 0) {
        self.userName.text = @"";
    }
    if ([self.temp1.text length] == 0) {
        self.temp1.text = @"Water";
    }
    if ([self.temp2.text length] == 0) {
        self.temp2.text = @"Room";
    }
    if ([self.temp3.text length] == 0) {
        self.temp3.text = @"Lights";
    }
    if([[restored objectForKey:@"DirectConnect"] isEqualToString: @"ON"])
    {
        [self.directConnect setOn:YES];
    }
    else
    {
        [self.directConnect setOn:NO];
    }
    if([[restored objectForKey:@"ExpansionON"] isEqualToString: @"ON"])
    {
        [self.relayExp setOn:YES];
        [self turnOnRelayExp];
        self.exprelay1.text = [restored objectForKey:@"ExpRelay1"];
        self.exprelay2.text = [restored objectForKey:@"ExpRelay2"];
        self.exprelay3.text = [restored objectForKey:@"ExpRelay3"];
        self.exprelay4.text = [restored objectForKey:@"ExpRelay4"];
        self.exprelay5.text = [restored objectForKey:@"ExpRelay5"];
        self.exprelay6.text = [restored objectForKey:@"ExpRelay6"];
        self.exprelay7.text = [restored objectForKey:@"ExpRelay7"];
        self.exprelay8.text = [restored objectForKey:@"ExpRelay8"];
    }

}

-(IBAction)turnOnRelayExp
{
    if(self.relayExp.on)    
    {
        //Loads saved names for exp module
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
        
        NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
        
        self.exprelay1.text = [restored objectForKey:@"ExpRelay1"];
        self.exprelay2.text = [restored objectForKey:@"ExpRelay2"];
        self.exprelay3.text = [restored objectForKey:@"ExpRelay3"];
        self.exprelay4.text = [restored objectForKey:@"ExpRelay4"];
        self.exprelay5.text = [restored objectForKey:@"ExpRelay5"];
        self.exprelay6.text = [restored objectForKey:@"ExpRelay6"];
        self.exprelay7.text = [restored objectForKey:@"ExpRelay7"];
        self.exprelay8.text = [restored objectForKey:@"ExpRelay8"];
        if (self.loadNames.hidden == YES) {
            [self.scrollView setContentSize:CGSizeMake(320, 1100)];
            
            
            self.exprelay1Label.hidden = NO;
            self.exprelay2Label.hidden = NO;
            self.exprelay3Label.hidden = NO;
            self.exprelay4Label.hidden = NO;
            self.exprelay5Label.hidden = NO;
            self.exprelay6Label.hidden = NO;
            self.exprelay7Label.hidden = NO;
            self.exprelay8Label.hidden = NO;
            self.exprelay1.hidden = NO;
            self.exprelay2.hidden = NO;
            self.exprelay3.hidden = NO;
            self.exprelay4.hidden = NO;
            self.exprelay5.hidden = NO;
            self.exprelay6.hidden = NO;
            self.exprelay7.hidden = NO;
            self.exprelay8.hidden = NO;
        }

         
}
else
{
    
        [self.scrollView setContentSize:CGSizeMake(320, 800)];
        self.exprelay1Label.hidden = YES;
        self.exprelay2Label.hidden = YES;
        self.exprelay3Label.hidden = YES;
        self.exprelay4Label.hidden = YES;
        self.exprelay5Label.hidden = YES;
        self.exprelay6Label.hidden = YES;
        self.exprelay7Label.hidden = YES;
        self.exprelay8Label.hidden = YES;
        self.exprelay1.hidden = YES;
        self.exprelay2.hidden = YES;
        self.exprelay3.hidden = YES;
        self.exprelay4.hidden = YES;
        self.exprelay5.hidden = YES;
        self.exprelay6.hidden = YES;
        self.exprelay7.hidden = YES;
        self.exprelay8.hidden = YES;
     
}

}

-(IBAction)loadPortNames
{
    if ([self.userName.text length] == 0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Enter UserName" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    else
    {
        if([self reachable])
           {
        self.bannerUrl = [@"http://forum.reefangel.com/status/labels.aspx?id=" stringByAppendingString:self.userName.text];
        [self getPorts:self.bannerUrl];
           }
    }
}

-(IBAction)viewNames:(UIButton *)sender
{
    
     UIButton *but = (UIButton*)sender;
    
    //NSLog(@"%@", but.tag);
    if (but.tag == 1) {
        [self.scrollView setContentSize:CGSizeMake(320, 800)];
        self.hideNames.hidden = NO;
        self.showNames.hidden = YES;
        self.relay1.hidden = NO;
        self.relay2.hidden = NO;
        self.relay3.hidden = NO;
        self.relay4.hidden = NO;
        self.relay5.hidden = NO;
        self.relay6.hidden = NO;
        self.relay7.hidden = NO;
        self.relay8.hidden = NO;
        self.temp1.hidden = NO;
        self.temp2.hidden = NO;
        self.temp3.hidden = NO;
        self.relay1Label.hidden = NO;
        self.relay2Label.hidden = NO;
        self.relay3Label.hidden = NO;
        self.relay4Label.hidden = NO;
        self.relay5Label.hidden = NO;
        self.relay6Label.hidden = NO;
        self.relay7Label.hidden = NO;
        self.relay8Label.hidden = NO;
        self.temp1Label.hidden = NO;
        self.temp2Label.hidden = NO;
        self.temp3Label.hidden = NO;
        if (self.relayExp.on) {
            [self.scrollView setContentSize:CGSizeMake(320, 1100)];
            self.exprelay1Label.hidden = NO;
            self.exprelay2Label.hidden = NO;
            self.exprelay3Label.hidden = NO;
            self.exprelay4Label.hidden = NO;
            self.exprelay5Label.hidden = NO;
            self.exprelay6Label.hidden = NO;
            self.exprelay7Label.hidden = NO;
            self.exprelay8Label.hidden = NO;
            self.exprelay1.hidden = NO;
            self.exprelay2.hidden = NO;
            self.exprelay3.hidden = NO;
            self.exprelay4.hidden = NO;
            self.exprelay5.hidden = NO;
            self.exprelay6.hidden = NO;
            self.exprelay7.hidden = NO;
            self.exprelay8.hidden = NO;
        }
    }
    if (but.tag == 2) {
        [self.scrollView setContentSize:CGSizeMake(320, 430)];
        self.hideNames.hidden = YES;
        self.showNames.hidden = NO;
        self.relay1.hidden = YES;
        self.relay2.hidden = YES;
        self.relay3.hidden = YES;
        self.relay4.hidden = YES;
        self.relay5.hidden = YES;
        self.relay6.hidden = YES;
        self.relay7.hidden = YES;
        self.relay8.hidden = YES;
        self.relay1Label.hidden = YES;
        self.relay2Label.hidden = YES;
        self.relay3Label.hidden = YES;
        self.relay4Label.hidden = YES;
        self.relay5Label.hidden = YES;
        self.relay6Label.hidden = YES;
        self.relay7Label.hidden = YES;
        self.relay8Label.hidden = YES;
        self.temp1.hidden = YES;
        self.temp2.hidden = YES;
        self.temp3.hidden = YES;
        self.temp1Label.hidden = YES;
        self.temp2Label.hidden = YES;
        self.temp3Label.hidden = YES;
        if (self.relayExp.on) {
            self.exprelay1Label.hidden = YES;
            self.exprelay2Label.hidden = YES;
            self.exprelay3Label.hidden = YES;
            self.exprelay4Label.hidden = YES;
            self.exprelay5Label.hidden = YES;
            self.exprelay6Label.hidden = YES;
            self.exprelay7Label.hidden = YES;
            self.exprelay8Label.hidden = YES;
            self.exprelay1.hidden = YES;
            self.exprelay2.hidden = YES;
            self.exprelay3.hidden = YES;
            self.exprelay4.hidden = YES;
            self.exprelay5.hidden = YES;
            self.exprelay6.hidden = YES;
            self.exprelay7.hidden = YES;
            self.exprelay8.hidden = YES;
        }
    }
}

-(void)getPorts:(NSString *) controllerUrl
{
    
    NSURL *bannerurl = [NSURL URLWithString: controllerUrl];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:bannerurl                        
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

}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData: data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    xmlParser = [[XmlParser alloc] init] ;
    NSString *received = [[[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding] autorelease];
    self.response = [NSString stringWithString:received];
    
    NSRange range2 = [self.response rangeOfString:@"</RA>" options:NSCaseInsensitiveSearch];
    if(range2.location == NSNotFound )
    {
        [self getPorts:self.bannerUrl];
        
    }
    else
    {
        
        webBanner = [[RA alloc] init];
        paramArray = [xmlParser fromXml:self.response withObject:webBanner];
        webBanner = [paramArray lastObject];
        
        if (webBanner != Nil) {
            [self updatePorts:webBanner];
            [self saveData];
        }
    }
    

}

-(void) updatePorts:(RA *)banner
{
    self.temp1.text = banner.T1N;
    self.temp2.text = banner.T2N;
    self.temp3.text = banner.T3N;
    self.relay1.text = banner.R1N;
    self.relay2.text = banner.R2N;
    self.relay3.text = banner.R3N;
    self.relay4.text = banner.R4N;
    self.relay5.text = banner.R5N;
    self.relay6.text = banner.R6N;
    self.relay7.text = banner.R7N;
    self.relay8.text = banner.R8N;

    if (![banner.R11N isEqualToString: @"Relay 11"] && banner.R1 > 0) {
        [self.relayExp setOn:YES];
        
        self.exprelay1.text = banner.R11N;
        self.exprelay2.text = banner.R12N;
        self.exprelay3.text = banner.R13N;
        self.exprelay4.text = banner.R14N;
        self.exprelay5.text = banner.R15N;
        self.exprelay6.text = banner.R16N;
        self.exprelay7.text = banner.R17N;
        self.exprelay8.text = banner.R18N;
        self.exprelay1Label.hidden = NO;
        self.exprelay2Label.hidden = NO;
        self.exprelay3Label.hidden = NO;
        self.exprelay4Label.hidden = NO;
        self.exprelay5Label.hidden = NO;
        self.exprelay6Label.hidden = NO;
        self.exprelay7Label.hidden = NO;
        self.exprelay8Label.hidden = NO;
        self.exprelay1.hidden = NO;
        self.exprelay2.hidden = NO;
        self.exprelay3.hidden = NO;
        self.exprelay4.hidden = NO;
        self.exprelay5.hidden = NO;
        self.exprelay6.hidden = NO;
        self.exprelay7.hidden = NO;
        self.exprelay8.hidden = NO;
        [self saveData];
        [self turnOnRelayExp];
    }
    else
    {
        //turns relayexp off if not found in banner, may not use as some people may not have it in banner but want the exp on
        //[self.relayExp setOn:NO];
        [self saveData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    self.exprelay1Label = nil;
    self.exprelay2Label = nil;
    self.exprelay3Label = nil;
    self.exprelay4Label = nil;
    self.exprelay5Label = nil;
    self.exprelay6Label = nil;
    self.exprelay7Label = nil;
    self.exprelay8Label = nil;
    self.exprelay1 = nil;
    self.exprelay2 = nil;
    self.exprelay3 = nil;
    self.exprelay4 = nil;
    self.exprelay5 = nil;
    self.exprelay6 = nil;
    self.exprelay7 = nil;
    self.exprelay8 = nil;
    self.relay1 = nil;
    self.relay2 = nil;
    self.relay3 = nil;
    self.relay4 = nil;
    self.relay5 = nil;
    self.relay6 = nil;
    self.relay7 = nil;
    self.relay8 = nil;
    self.relay1Label = nil;
    self.relay2Label = nil;
    self.relay3Label = nil;
    self.relay4Label = nil;
    self.relay5Label = nil;
    self.relay6Label = nil;
    self.relay7Label = nil;
    self.relay8Label = nil;

}

- (void)viewDidUnload
{
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.exprelay1Label = nil;
    self.exprelay2Label = nil;
    self.exprelay3Label = nil;
    self.exprelay4Label = nil;
    self.exprelay5Label = nil;
    self.exprelay6Label = nil;
    self.exprelay7Label = nil;
    self.exprelay8Label = nil;
    self.exprelay1 = nil;
    self.exprelay2 = nil;
    self.exprelay3 = nil;
    self.exprelay4 = nil;
    self.exprelay5 = nil;
    self.exprelay6 = nil;
    self.exprelay7 = nil;
    self.exprelay8 = nil;
    self.scrollView = nil;
    self.relay1 = nil;
    self.relay2 = nil;
    self.relay3 = nil;
    self.relay4 = nil;
    self.relay5 = nil;
    self.relay6 = nil;
    self.relay7 = nil;
    self.relay8 = nil;
    self.url = nil;
    self.enteredURL = nil;
    self.temp1 = nil;
    self.temp2 = nil;
    self.temp3 = nil;
    self.bannerUrl = nil;
    self.loadNames = nil;
    self.response = nil;
    self.showNames = nil;
    self.hideNames = nil;
    self.relay1Label = nil;
    self.relay2Label = nil;
    self.relay3Label = nil;
    self.relay4Label = nil;
    self.relay5Label = nil;
    self.relay6Label = nil;
    self.relay7Label = nil;
    self.relay8Label = nil;
    self.temp1Label = nil;
    self.temp2Label = nil;
    self.temp3Label = nil;
    self.receivedData = nil;
    self.raURL = nil;
     [super viewDidUnload];

}

- (void)dealloc
{
   
    [exprelay1Label release];
    [exprelay2Label release];
    [exprelay3Label release];
    [exprelay4Label release];
    [exprelay5Label release];
    [exprelay6Label release];
    [exprelay7Label release];
    [exprelay8Label release];
    [exprelay1 release];
    [exprelay2 release];
    [exprelay3 release];
    [exprelay4 release];
    [exprelay5 release];
    [exprelay6 release];
    [exprelay7 release];
    [exprelay8 release];
    [scrollView release];
    [relay1 release];
    [relay2 release];
    [relay3 release];
    [relay4 release];
    [relay5 release];
    [relay6 release];
    [relay7 release];
    [relay8 release];
    [url release];
    [enteredURL release];
    [memcontroller release];
    [temp1 release];
    [temp2 release];
    [temp3 release];
    [bannerUrl release];
    [loadNames release];
    [response release];
    [hideNames release];
    [showNames release];
    [temp1Label release];
    [temp2Label release];
    [temp3Label release];
    [relay1Label release];
    [relay2Label release];
    [relay3Label release];
    [relay4Label release];
    [relay5Label release];
    [relay6Label release];
    [relay7Label release];
    [relay8Label release];
    [receivedData release];
    [raURL release];
    
     [super dealloc];
}

@end
