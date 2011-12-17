//
//  History.m
//  ReefAngel Mobile Client
//
//  Created by John Wiebalk on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "History.h"

@implementation History
@synthesize userName, url, fullUrl, probeList, probes, selected, response, receivedData, basicURL;

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
    
}

-(NSString *) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selected = [self.probes objectAtIndex:row];
    self.fullUrl = [self.basicURL stringByAppendingFormat:@"&filter=%@",self.selected];
    return self.selected;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *) probePicker
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)probePicker numberOfRowsInComponent:(NSInteger)component
{
    return [self.probes count];
}

-(NSString *) pickerView:(UIPickerView *) probePicker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.probes objectAtIndex:row];
}
- (void)graphViewDidFinish:(GraphView *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)graph
{   
    
    
    if ([self reachable]) {
        [self download:self.fullUrl];
        
    }
    else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
   
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
    self.probes = [NSArray arrayWithObjects:@"T1",@"T2",@"T3",@"pH", nil];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.url = nil;
    self.fullUrl = nil;
    self.userName = nil;
    self.probes = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

@end
