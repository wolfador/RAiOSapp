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
@synthesize appDelegate;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    [super viewDidLoad];   
    [self loadData];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 515)];
    url.delegate = self;

    appDelegate = (ReefAngel_Mobile_ClientAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    settingsBox1Relays = [[NSArray arrayWithObjects:@"R1 Name:", @"R2 Name:", @"R3 Name:", @"R4 Name:", @"R5 Name:", @"R6 Name:", @"R7 Name:", @"R8 Name:", nil]retain];

    //TODO: These relay box names need to be pulled from the settings file that doesn't yet exist
    //**Also need to support a second expansion box also**    
    settingsBox1Vals = [[NSArray arrayWithObjects:@"ATO", @"Daylights", @"Actinics", @"WM1", @"WM2", @"Center Pump", @"Heater", @"Skimmer",nil]retain];
    settingsGeneralRows = [[NSArray arrayWithObjects:@"Wifi URL:",nil]retain];
    settingsSectionHeaders = [[NSArray arrayWithObjects:@"General",@"Temp Labels",@"Relay Box1",nil]retain];
    settingsTempLabels = [[NSArray arrayWithObjects:@"Temp1:",@"Temp2",@"Temp3", nil]retain];
    settingsTempVals = [[NSArray arrayWithObjects:@"Water:",@"Room1:",@"Room2:", nil]retain];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.url resignFirstResponder];
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
    //enteredURL = [[NSString alloc] initWithString:url.text];
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
		[Dictionary writeToFile:path atomically:YES];
        
    }    
}
-(void) loadData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
	
	NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
	//NSArray *myKeys = [restored allKeys];
	self.url.text = [restored objectForKey:@"URL"];
    
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
