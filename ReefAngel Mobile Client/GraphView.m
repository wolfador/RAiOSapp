//
//  RootViewController.m
//  DemoS7GraphView
//
//  Created by Rudi Farkas on 20.12.09.
//  Copyright Wolfscliff 2009. All rights reserved.
//

// It clips negative y values to 0
// It autoscales y to the max y over all plots

#import "GraphView.h"
#import <QuartzCore/QuartzCore.h> 
#import "ReefAngel_Mobile_ClientAppDelegate.h"

@implementation GraphView

@synthesize graphView;
@synthesize delegate = _delegate, historyData, historyDict, fullArray, timeArray, valueArray, dataString, timeString;

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	self.graphView = [[S7GraphView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.view = self.graphView;
	self.graphView.dataSource = self;
    NSString *testString = [self.historyData substringFromIndex:1];
    NSString *test2String = [testString substringToIndex: [testString length] - 6 ];
    NSString *newString = [test2String stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSString *newString2 = [newString stringByReplacingOccurrencesOfString:@"]," withString:@","];
     NSString *newString3 = [newString2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.fullArray = [newString3 componentsSeparatedByString: @","];
    self.timeArray = [NSMutableArray array];
    self.valueArray = [NSMutableArray array];
    int i;
    int count;
    count = [self.fullArray count];
    
    for (i = 0; i < count; i++) {
      //  NSLog (@"Element %i = %@", i, [self.fullArray objectAtIndex: i]);
        self.dataString = [NSString stringWithString:[self.fullArray objectAtIndex:i]];
        
        //NSLog(@"%@", arrayString);
        if ([self.dataString length] > 4) {
            
            [self.timeArray addObject:[self.fullArray objectAtIndex:i]];
        }
        else {
            
            [self.valueArray addObject:[self.fullArray objectAtIndex:i]];
        }
    }

	[self.graphView reloadData];
}

-(IBAction) keyButton
{
	[self.delegate graphViewDidFinish:self];
	
}
- (IBAction)done
{
    [self.delegate graphViewDidFinish:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
		
	NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setMinimumFractionDigits:0];
	[numberFormatter setMaximumFractionDigits:2];
	
	self.graphView.yValuesFormatter = numberFormatter;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    
    self.graphView.xValuesFormatter = dateFormatter;
	       
	[numberFormatter release];
	
	self.graphView.backgroundColor = [UIColor whiteColor];
	
	self.graphView.drawAxisX = NO;
	self.graphView.drawAxisY = YES;
	self.graphView.drawGridX = YES;
	self.graphView.drawGridY = YES;
	
	self.graphView.xValuesColor = [UIColor blackColor];
	self.graphView.yValuesColor = [UIColor blackColor];
	
	self.graphView.gridXColor = [UIColor blackColor];
	self.graphView.gridYColor = [UIColor blackColor];
	
		
	//update the data:
    
    
	[self.graphView reloadData];
	
	//determine if device is iPad to setup frame for NavBar
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
			nav = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 768.0f, 48.0f)];
			[nav setBarStyle: 0];

		}
		// Landscape Layout
		else{
			nav = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 1024.0f, 48.0f)];
			[nav setBarStyle: 0];
			}
	}
	else { 
        if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
			nav = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 48.0f)];
			[nav setBarStyle: 0];
            
		}
        else {
		nav = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 480.0f, 48.0f)];
		[nav setBarStyle: 0];
        }
	}


		
	UIBarButtonItem *rightButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(keyButton)] autorelease];
    UIBarButtonItem *leftButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionSheet)] autorelease];
    
	UINavigationItem *item = [UINavigationItem alloc] ;
	item.rightBarButtonItem = rightButton;
    item.leftBarButtonItem = leftButton;
	[nav pushNavigationItem:item animated:NO ];
	[item autorelease];
	
	[self.graphView addSubview:nav];
	
}

-(IBAction)showActionSheet {
        ReefAngel_Mobile_ClientAppDelegate *appDelegate = (ReefAngel_Mobile_ClientAppDelegate*)[[UIApplication sharedApplication]delegate];
    	    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Export Graph" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Save to Photo Album", @"Cancel", nil];
    	    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    	   // [popupQuery showInView:self.view];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        [popupQuery showInView:self.view];
    }
    else {
         [popupQuery showInView:appDelegate.window];
        
    }

    popupQuery.cancelButtonIndex = 1;
    	    [popupQuery release];
    	}
- (void) actionSheet:(UIActionSheet *)actionSheet didDismisswithButtonIndex:(NSInteger)buttonIndex
{
    if (!(buttonIndex == [actionSheet cancelButtonIndex])) {
    }
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
     if (buttonIndex == 0) {
                nav.hidden = YES;

                CGSize screenSize = [[UIScreen mainScreen] applicationFrame].size;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                	if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
                        screenSize.height = screenSize.height * .95; 
                    }
                // Landscape Layout
                    else{
                        screenSize.height = screenSize.height * .68;
                        screenSize.width = screenSize.width * 1.35;
                    }
                }
                else {
                        if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
                    screenSize.height = screenSize.height * .89;
                        }
                        else
                        {
                            screenSize.height = screenSize.height * .68;
                            screenSize.width = screenSize.width * 1.35;
                        }
                }
                CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB(); 
                CGContextRef ctx = CGBitmapContextCreate(nil, screenSize.width, screenSize.height, 8, 4*(int)screenSize.width, colorSpaceRef, kCGImageAlphaPremultipliedLast);
                CGContextTranslateCTM(ctx, 0.0, screenSize.height);
                CGContextScaleCTM(ctx, 1.0, -1.0);
                
                
                [(CALayer*) self.view.layer renderInContext:ctx];
                
                CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
                UIImage *image = [UIImage imageWithCGImage:cgImage];
                CGImageRelease(cgImage);
                CGContextRelease(ctx);
                CGColorSpaceRelease(colorSpaceRef);
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); 
                nav.hidden = NO;
                
            	    } 
            else if (buttonIndex == 1) {
                
                	    } 
           
}

 - (void)viewWillAppear:(BOOL)animated 
{
 [super viewWillAppear:animated];
	 
	 [self.graphView reloadData];
 }

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
toInterfaceOrientation duration:(NSTimeInterval)duration 
{
	// Change graphview.frame to make it a litle smaller
	[self.graphView reloadData];
	
	//resize Navbar on rotation
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
			nav.frame = CGRectMake(0.0f, 0.0f, 768.0f, 48.0f);
			
		}
		// Landscape Layout
		else{
			nav.frame = CGRectMake(0.0f, 0.0f, 1024.0f, 48.0f);
		}
	}
	else { 	if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		nav.frame = CGRectMake(0.0f, 0.0f, 320.0f, 48.0f);
    }
    else {
        nav.frame = CGRectMake(0.0f, 0.0f, 480.0f, 48.0f);
        graphView.frame = CGRectMake(0.0f, 0.0f, 310.0f, 480.0f);
    }
	}
}

 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
 // Return YES for supported orientations.
	 return YES;
 }


- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
    self.timeArray = nil;
    self.valueArray = nil;
    self.historyData = nil;
    self.historyDict = nil;
    self.timeString = nil;
}

- (void)dealloc 
{
	[graphView release];
    [timeArray release];
    [valueArray release];
    [timeString release];

	
    [super dealloc];
}

#pragma mark protocol S7GraphViewDataSource

- (NSUInteger)graphViewNumberOfPlots:(S7GraphView *)graphView {
	/* Return the number of plots you are going to have in the view. 1+ */
	return 1;
}

- (NSArray *)graphViewXValues:(S7GraphView *)graphView {
	/* An array of objects that will be further formatted to be displayed on the X-axis.
	 The number of elements should be equal to the number of points you have for every plot. */
    
    int i;
    int count;
    count = [self.timeArray count];
    
    for (i = 0; i < count; i++) {
        self.timeString = [NSString stringWithString:[self.timeArray objectAtIndex:i]];
       
        NSString *time2String = [self.timeString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSString *time3String = [time2String substringToIndex: [time2String length] - 3 ];
        NSInteger timestamp = [time3String integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:date];
        NSDate *localDate = [date dateByAddingTimeInterval:timeZoneOffset];
        [self.timeArray replaceObjectAtIndex:i withObject:localDate];
       
    }
  
    
	return self.timeArray;
	
}

- (NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex {
	/* Return the values for a specific graph. Each plot is meant to have equal number of points.
	 And this amount should be equal to the amount of elements you return from graphViewXValues: method. */
	
	
	return self.valueArray;

}
- (BOOL)graphView:(S7GraphView *)graphView shouldFillPlot:(NSUInteger)plotIndex
{
	return NO;
}

@end

