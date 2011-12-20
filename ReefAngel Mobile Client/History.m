//
//  History.m
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "History.h"

@implementation History
@synthesize userName, url, probeList, probes, selected, response, receivedData, basicURL, daysToGraph, days, t1, t2, t3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)reachable
{

        Reachability *r = [Reachability reachabilityWithHostName:self.url];
        NetworkStatus internetStatus = [r currentReachabilityStatus];
        if(internetStatus == NotReachable) {
            return NO;
        }
        else
        {
            return YES;
        }
   }

-(void) loadData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedata.plist"];
	
	NSDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: path];
    
    self.userName = [restored objectForKey:@"UserName"];
    self.url = @"forum.reefangel.com";
    self.basicURL = [NSString stringWithFormat:@"http://forum.reefangel.com/status/jsonp.aspx?id=%@", self.userName];
    
     self.t1 = [restored objectForKey:@"Temp1"];
     self.t2 = [restored objectForKey:@"Temp2"];
     self.t3 = [restored objectForKey:@"Temp3"];
    if ([self.t1 length] == 0) {
        self.t1 = @"T1";
    }
    if ([self.t2 length] == 0) {
        self.t2 = @"T2";
    }
    if ([self.t3 length] == 0) {
        self.t3 = @"T3";
    }
    self.probes = [NSArray arrayWithObjects: self.t1, self.t2, self.t3, @"pH", @"AIW", @"AIB", @"AIRB", nil];
    
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.selected = [self.probes objectAtIndex:row];
    }
    self.daysToGraph = [self.days objectAtIndex:row];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *) probePicker
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)probePicker numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.probes count];
    }
    return [self.days count];

    
}

-(NSString *) pickerView:(UIPickerView *) probePicker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     if (component == 0) {
    return [self.probes objectAtIndex:row];
     }
    return [self.days objectAtIndex:row];
}

- (void)graphViewDidFinish:(GraphView *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)graph
{   
    
        NSInteger probe = [self.probeList selectedRowInComponent:0];
        self.selected = [self.probes objectAtIndex:probe];
    if ([self.selected isEqualToString:self.t1]) {
        self.selected = @"T1";
    }
    if ([self.selected isEqualToString:self.t2]) {
        self.selected = @"T2";
    }
    if ([self.selected isEqualToString:self.t3]) {
        self.selected = @"T3";
    }
    NSInteger numday = [self.probeList selectedRowInComponent:1];
    self.daysToGraph = [self.days objectAtIndex:numday];
    NSMutableString *fullUrl = [[NSMutableString alloc] init];
    [fullUrl appendString:self.basicURL];
    [fullUrl appendFormat:@"&filter=%@&range=%@",self.selected,self.daysToGraph];

    if ([self reachable]) {
        [self download:fullUrl];
        
        
    }
    else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
   [fullUrl release];
}

-(void)download:(NSString *) controllerUrl
{
    
    NSURL *theurl = [NSURL URLWithString: controllerUrl];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:theurl                        
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    NSString *received = [[[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding] autorelease];
       self.response = [NSString stringWithString:received];
    

    if (self.response != NULL) {
        graphcontroller = [[GraphView alloc] initWithNibName:nil bundle:nil] ;
        graphcontroller.delegate = self;
        graphcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        graphcontroller.historyData = [NSString stringWithString:self.response];
        
        [self presentModalViewController:graphcontroller animated:YES];
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
    [self loadData];
    //self.probes = [NSArray arrayWithObjects: @"T1", @"T2", @"T3", @"pH", @"AIW", @"AIB", @"AIRB", nil];
    self.days = [NSArray arrayWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
    [self.probeList reloadAllComponents];
    [self.probeList selectRow:0 inComponent:1 animated:NO];
    [self.probeList selectRow:0 inComponent:0 animated:NO];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.url = nil;
    //self.fullUrl = nil;
    self.userName = nil;
    self.probes = nil;
    self.receivedData = nil;
    self.response = nil;
    
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
- (void)dealloc
{
    [super dealloc];
    [url release];
    //[fullUrl release];
    [userName release];
    [probes release];
    [receivedData release];
    [response release];
}
@end
