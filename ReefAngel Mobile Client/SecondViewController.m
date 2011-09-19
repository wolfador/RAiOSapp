//
//  SecondViewController.m
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController

@synthesize url;
@synthesize enteredURL, save;
@synthesize appDelegate, relayExp, relay1, relay2, relay3, relay4, relay5, relay6, relay7, relay8;
@synthesize exprelay1, exprelay2, exprelay3, exprelay4, exprelay5, exprelay6, exprelay7, exprelay8;
@synthesize exprelay1Label, exprelay2Label, exprelay3Label, exprelay4Label, exprelay5Label, exprelay6Label, exprelay7Label, exprelay8Label;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    [super viewDidLoad];   
    [self loadData];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 850)];
    url.delegate = self;

    appDelegate = (ReefAngel_Mobile_ClientAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.url resignFirstResponder];
    [self.relay1 resignFirstResponder];
    [self.relay2 resignFirstResponder];
    [self.relay3 resignFirstResponder];
    [self.relay4 resignFirstResponder];
    [self.relay5 resignFirstResponder];
    [self.relay6 resignFirstResponder];
    [self.relay7 resignFirstResponder];
    [self.relay8 resignFirstResponder];
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)activeScrollView {
    
    [self hideKeyboard];
    
}

-(IBAction) textFieldDoneEditing : (id) sender{
    [sender resignFirstResponder];
    }
-(IBAction) hideKeyboard
{
    [self.url resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction) saveData
{
    [self hideKeyboard];
    [self appDelegate].url = url.text;
    if ([self.url.text length] == 0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Enter a URL" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    else
    {

        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
        
        UIAlertView* savedAlertView = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Data Saved" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[savedAlertView show];
		[savedAlertView release];
		
		NSMutableDictionary *Dictionary = [NSMutableDictionary dictionary];
		NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
		[Dictionary addEntriesFromDictionary:restored];
		[Dictionary setObject: self.url.text forKey: @"URL"];
        [Dictionary setObject: self.relay1.text forKey: @"Relay1"];
        [Dictionary setObject: self.relay2.text forKey: @"Relay2"];
        [Dictionary setObject: self.relay3.text forKey: @"Relay3"];
        [Dictionary setObject: self.relay4.text forKey: @"Relay4"];
        [Dictionary setObject: self.relay5.text forKey: @"Relay5"];
        [Dictionary setObject: self.relay6.text forKey: @"Relay6"];
        [Dictionary setObject: self.relay7.text forKey: @"Relay7"];
        [Dictionary setObject: self.relay8.text forKey: @"Relay8"];
		
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
	self.url.text = [restored objectForKey:@"URL"];
    self.relay1.text = [restored objectForKey:@"Relay1"];
    self.relay2.text = [restored objectForKey:@"Relay2"];
    self.relay3.text = [restored objectForKey:@"Relay3"];
    self.relay4.text = [restored objectForKey:@"Relay4"];
    self.relay5.text = [restored objectForKey:@"Relay5"];
    self.relay6.text = [restored objectForKey:@"Relay6"];
    self.relay7.text = [restored objectForKey:@"Relay7"];
    self.relay8.text = [restored objectForKey:@"Relay8"];
    if([restored objectForKey:@"ExpansionON"])   
    {
        [relayExp setOn:YES];
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
    if(relayExp.on)    
    {

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
else
{

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
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}
@end
