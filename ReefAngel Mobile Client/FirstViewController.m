//
//  FirstViewController.m
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/17/11 updated by John on 9/29/11.
//  Copyright 2011 Wolfador. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController
@synthesize temp1Label, temp2Label, temp3Label, pHLabel, scrollView, relay1, relay2, relay3, relay4, relay5, relay6, relay7, relay8, relay21, relay22, relay23, relay24, relay25, relay26, relay27, relay28;
@synthesize box1Relay1, box1Relay2, box1Relay3, box1Relay4, box1Relay5, box1Relay6, box1Relay7, box1Relay8;
@synthesize b1R1Indicator, b1R2Indicator, b1R3Indicator,  b1R4Indicator, b1R5Indicator, b1R6Indicator, b1R7Indicator, b1R8Indicator;

@synthesize b2R1Indicator, b2R2Indicator, b2R3Indicator,  b2R4Indicator, b2R5Indicator, b2R6Indicator, b2R7Indicator, b2R8Indicator;
@synthesize box2Relay1, box2Relay2, box2Relay3, box2Relay4, box2Relay5, box2Relay6, box2Relay7, box2Relay8;

@synthesize wifiUrl,fullUrl,lastUpdatedLabel;
@synthesize box2;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
        
    [super viewDidLoad];
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 515)];     
    self.scrollView.delegate = self;
    
}
                    
-(void)UpdateUI:(RA*)ra
{
    if(raParam)
    {
        
        temp1Label.text = raParam.formattedTemp1;
        temp2Label.text = raParam.formattedTemp2;
        temp3Label.text = raParam.formattedTemp3;
        pHLabel.text    = raParam.formattedpH;
        
        
        
        if(!raParam.isRelay1OFFMask && !raParam.isRelay1ONMask)
        {box1Relay1.on = raParam.isRelay1Active;b1R1Indicator.hidden = YES;}
        else
        {box1Relay1.on = raParam.isRelay1ONMask;b1R1Indicator.hidden = NO;}
        if(!raParam.isRelay2OFFMask && !raParam.isRelay2ONMask)
        {box1Relay2.on = raParam.isRelay2Active;b1R2Indicator.hidden = YES;}
        else
        {box1Relay2.on = raParam.isRelay2ONMask;b1R2Indicator.hidden= NO;}
        if(!raParam.isRelay3OFFMask && !raParam.isRelay3ONMask)
        {box1Relay3.on = raParam.isRelay3Active;b1R3Indicator.hidden = YES;}
        else
        {box1Relay3.on = raParam.isRelay3ONMask;b1R3Indicator.hidden = NO;}
        if(!raParam.isRelay4OFFMask && !raParam.isRelay4ONMask)
        {box1Relay4.on = raParam.isRelay4Active;b1R4Indicator.hidden = YES;}
        else
        {box1Relay4.on = raParam.isRelay4ONMask;b1R4Indicator.hidden = NO;}
        if(!raParam.isRelay5OFFMask && !raParam.isRelay5ONMask)
        {box1Relay5.on = raParam.isRelay5Active;b1R5Indicator.hidden = YES;}
        else
        {box1Relay5.on = raParam.isRelay5ONMask;b1R5Indicator.hidden = NO;}
        if(!raParam.isRelay6OFFMask && !raParam.isRelay6ONMask)
        {box1Relay6.on = raParam.isRelay6Active;b1R6Indicator.hidden = YES;}
        else
        {box1Relay6.on = raParam.isRelay6ONMask;b1R6Indicator.hidden = NO;}
        if(!raParam.isRelay7OFFMask && !raParam.isRelay7ONMask)
        {box1Relay7.on = raParam.isRelay7Active;b1R7Indicator.hidden = YES;}
        else
        {box1Relay7.on = raParam.isRelay7ONMask;b1R7Indicator.hidden = NO;}
        if(!raParam.isRelay8OFFMask && !raParam.isRelay8ONMask)
        {box1Relay8.on = raParam.isRelay8Active;b1R8Indicator.hidden = YES;}
        else
        {box1Relay8.on = raParam.isRelay8ONMask;b1R8Indicator.hidden = NO;}
        
        if(self.box2.hidden == NO)
        {
         if(!raParam.isRelay01OFFMask && !raParam.isRelay01ONMask)
         {box2Relay1.on = raParam.isRelay01Active;b2R1Indicator.hidden = YES;}
         else
         {box2Relay1.on = raParam.isRelay01ONMask;b2R1Indicator.hidden = NO;}
         if(!raParam.isRelay02OFFMask && !raParam.isRelay02ONMask)
         {box2Relay2.on = raParam.isRelay02Active;b2R2Indicator.hidden = YES;}
         else
         {box2Relay2.on = raParam.isRelay2ONMask;b2R2Indicator.hidden= NO;}
         if(!raParam.isRelay03OFFMask && !raParam.isRelay03ONMask)
         {box2Relay3.on = raParam.isRelay03Active;b2R3Indicator.hidden = YES;}
         else
         {box2Relay3.on = raParam.isRelay03ONMask;b2R3Indicator.hidden = NO;}
         if(!raParam.isRelay04OFFMask && !raParam.isRelay04ONMask)
         {box2Relay4.on = raParam.isRelay04Active;b2R4Indicator.hidden = YES;}
         else
         {box2Relay4.on = raParam.isRelay04ONMask;b2R4Indicator.hidden = NO;}
         if(!raParam.isRelay05OFFMask && !raParam.isRelay05ONMask)
         {box2Relay5.on = raParam.isRelay05Active;b2R5Indicator.hidden = YES;}
         else
         {box2Relay5.on = raParam.isRelay05ONMask;b2R5Indicator.hidden = NO;}
         if(!raParam.isRelay06OFFMask && !raParam.isRelay06ONMask)
         {box2Relay6.on = raParam.isRelay06Active;b2R6Indicator.hidden = YES;}
         else
         {box2Relay6.on = raParam.isRelay06ONMask;b2R6Indicator.hidden = NO;}
         if(!raParam.isRelay07OFFMask && !raParam.isRelay07ONMask)
         {box2Relay7.on = raParam.isRelay07Active;b2R7Indicator.hidden = YES;}
         else
         {box2Relay7.on = raParam.isRelay07ONMask;b2R7Indicator.hidden = NO;}
         if(!raParam.isRelay08OFFMask && !raParam.isRelay08ONMask)
         {box2Relay8.on = raParam.isRelay08Active;b2R8Indicator.hidden = YES;}
         else
         {box2Relay8.on = raParam.isRelay08ONMask;b2R8Indicator.hidden = NO;}
        }
        
        raParam = nil;
        [raParam release];
    }

}
-(void)SendRequest:(NSString *)url
{
    
    controller = [[[RA_WifiController alloc]init] autorelease];
    raParam = [controller sendRequest:url];
    [self UpdateUI:raParam];
    NSLog(@"%@", raParam);
    if (raParam != NULL) {
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateFormat:@"MMM dd yyyy : hh:mm:ss a"];
        NSDate *date = [NSDate date];
        lastUpdatedLabel.text = [formatter stringFromDate:date];
    }
    else
    {
        if (lastUpdatedLabel.text.length == 0) {
            lastUpdatedLabel.text = @"No Data";
        }
        lastUpdatedLabel.textColor = [UIColor redColor];;
    }
    
}

-(IBAction)refreshParams
{
    
    self.fullUrl = [NSString stringWithFormat:@"%@r99 ",self.wifiUrl];
    if ([self.wifiUrl length] > 0) {
        [self SendRequest:fullUrl];
    }
    [TestFlight passCheckpoint:@"Data Refreshed"];

    
}
-(IBAction) toggleRelay:(UISwitch*)sender
{
    if([sender class] == [UISwitch class])
    {
        UISwitch *swit = (UISwitch*)sender;        
        self.fullUrl = [NSString stringWithFormat:@"%@r%@%@",self.wifiUrl,[NSString stringWithFormat:@"%d",swit.tag],
                        swit.on ? @"1" : @"0"];
        if ([self.wifiUrl length] > 0) {
            [self SendRequest:fullUrl];
        }
       // [swit release];
    }
    else //if([sender class] == [UIButton class])
    {
        
        UIButton *but = (UIButton*)sender;
        NSString *tag = [NSString stringWithFormat:@"%d",but.tag];    
        self.fullUrl = [NSString stringWithFormat:@"%@r%@%@",self.wifiUrl,tag,@"2"];
        if ([self.wifiUrl length] > 0) {
       [self SendRequest:fullUrl];
        }
       // [but release];
    }    
    

  }
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
	
}
-(void) loadData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
	
	NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
	self.wifiUrl = [restored objectForKey:@"URL"];
    self.relay1.text = [restored objectForKey:@"Relay1"];
    self.relay2.text = [restored objectForKey:@"Relay2"];
    self.relay3.text = [restored objectForKey:@"Relay3"];
    self.relay4.text = [restored objectForKey:@"Relay4"];
    self.relay5.text = [restored objectForKey:@"Relay5"];
    self.relay6.text = [restored objectForKey:@"Relay6"];
    self.relay7.text = [restored objectForKey:@"Relay7"];
    self.relay8.text = [restored objectForKey:@"Relay8"];
    
    if([[restored objectForKey:@"ExpansionON"] isEqualToString: @"ON"])
       {
           [scrollView setContentSize:CGSizeMake(320, 900)]; 
           self.box2.hidden = NO;
           self.relay21.hidden = NO;
           self.relay22.hidden = NO;
           self.relay23.hidden = NO;
           self.relay24.hidden = NO;
           self.relay25.hidden = NO;
           self.relay26.hidden = NO;
           self.relay27.hidden = NO;
           self.relay28.hidden = NO;
           
           self.relay21.text = [restored objectForKey:@"ExpRelay1"];
           self.relay22.text = [restored objectForKey:@"ExpRelay2"];
           self.relay23.text = [restored objectForKey:@"ExpRelay3"];
           self.relay24.text = [restored objectForKey:@"ExpRelay4"];
           self.relay25.text = [restored objectForKey:@"ExpRelay5"];
           self.relay26.text = [restored objectForKey:@"ExpRelay6"];
           self.relay27.text = [restored objectForKey:@"ExpRelay7"];
           self.relay28.text = [restored objectForKey:@"ExpRelay8"];
           self.box2Relay1.hidden = NO;
           self.box2Relay2.hidden = NO;
           self.box2Relay3.hidden = NO;
           self.box2Relay4.hidden = NO;
           self.box2Relay5.hidden = NO;
           self.box2Relay6.hidden = NO;
           self.box2Relay7.hidden = NO;
           self.box2Relay8.hidden = NO;
       }
    else
    {
        [scrollView setContentSize:CGSizeMake(320, 515)]; 
        self.box2.hidden = YES;
        self.relay21.hidden = YES;
        self.relay22.hidden = YES;
        self.relay23.hidden = YES;
        self.relay24.hidden = YES;
        self.relay25.hidden = YES;
        self.relay26.hidden = YES;
        self.relay27.hidden = YES;
        self.relay28.hidden = YES;
        self.box2Relay1.hidden = YES;
        self.box2Relay2.hidden = YES;
        self.box2Relay3.hidden = YES;
        self.box2Relay4.hidden = YES;
        self.box2Relay5.hidden = YES;
        self.box2Relay6.hidden = YES;
        self.box2Relay7.hidden = YES;
        self.box2Relay8.hidden = YES;
        self.b2R1Indicator.hidden = YES;
        self.b2R2Indicator.hidden = YES;
        self.b2R3Indicator.hidden = YES;
        self.b2R4Indicator.hidden = YES;
        self.b2R5Indicator.hidden = YES;
        self.b2R6Indicator.hidden = YES;
        self.b2R7Indicator.hidden = YES;
        self.b2R8Indicator.hidden = YES;
    }
    [self refreshParams];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    [self loadData];
    if ([self.wifiUrl length] == 0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Settings" message:@"Enter Server Address in Settings" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    self.temp1Label = nil;
    self.relay1 = nil;
    self.relay2 = nil;
    self.relay3 = nil;
    self.relay4 = nil;
    self.relay5 = nil;
    self.relay6 = nil;
    self.relay7 = nil;
    self.relay8 = nil;
    self.relay21 = nil;
    self.relay22 = nil;
    self.relay23 = nil;
    self.relay24 = nil;
    self.relay25 = nil;
    self.relay26 = nil;
    self.relay27 = nil;
    self.relay28 = nil;
    self.temp2Label = nil;
    self.temp3Label = nil;
    self.pHLabel = nil;
    self.lastUpdatedLabel = nil;
    }


- (void)viewDidUnload
{
    [super viewDidUnload];

    self.temp1Label = nil;
    self.relay1 = nil;
    self.relay2 = nil;
    self.relay3 = nil;
    self.relay4 = nil;
    self.relay5 = nil;
    self.relay6 = nil;
    self.relay7 = nil;
    self.relay8 = nil;
    self.relay21 = nil;
    self.relay22 = nil;
    self.relay23 = nil;
    self.relay24 = nil;
    self.relay25 = nil;
    self.relay26 = nil;
    self.relay27 = nil;
    self.relay28 = nil;
    self.temp2Label = nil;
    self.temp3Label = nil;
    self.pHLabel = nil;
    self.lastUpdatedLabel = nil;
}


- (void)dealloc
{
    [super dealloc];
}

@end
