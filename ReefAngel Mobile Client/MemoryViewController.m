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
@synthesize HeaterOn, HeaterOff, FeedTimer, Overheat, PWMD, PWMA, LCDTimer, wifiURL, enteredURL, fullURL; 
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
}
-(IBAction) save
{
    [self loadData];
    self.fullURL = [NSString stringWithFormat:@"%@ma ",self.wifiURL];
    [self sendUpdate:fullURL];
}
-(void)UpdateUI:(MEM*)mem
{
    NSLog(@"%@", memValues);
    if(memValues)
    {
        NSLog(@"%@", memValues.M822);
        
        HeaterOn.text = [memValues.M822 stringValue];
        HeaterOff.text = [memValues.M824 stringValue];
        FeedTimer.text = [memValues.M814 stringValue];
        Overheat.text = [memValues.M818 stringValue];
        PWMD.text = [memValues.M820 stringValue];
        PWMA.text = [memValues.M821 stringValue];
        LCDTimer.text = [memValues.M816 stringValue];
        //NSLog(@"%@", mem.ATOHIGH);
        //NSLog(@"%@", mem.PWMD);
        

        memValues = nil;
        [memValues release];
    }
    
}

-(void)sendUpdate:(NSString *) controllerUrl
{
    [self.request clearDelegatesAndCancel];
    
    
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
