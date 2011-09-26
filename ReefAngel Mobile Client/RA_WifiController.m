//
//  RA_WifiController.m
//  ReefAngel Mobile Client
//
//  Created by Dave on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RA_WifiController.h"

@implementation RA_WifiController
@synthesize request,queue;



-(RA *)sendRequest:(NSString *)controllerUrl
{
    [self.request clearDelegatesAndCancel];
    NSURL *url = [NSURL URLWithString: controllerUrl];
    ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:url];   
    [request2 setShouldAttemptPersistentConnection:NO];
    [request2 setRequestMethod:@"GET"];
    request2.timeOutSeconds = 20;

    [request2 setNumberOfTimesToRetryOnTimeout:2];
    
     [request2 setUseHTTPVersionOne:YES];
    [request2 startSynchronous];
    NSError *error = [request2 error];
    NSMutableArray *paramArray;
    if(!error)
    {
        [NSThread sleepForTimeInterval:.5];
        NSString *response = [request2 responseString];
        latestParams = [[[RA alloc] init] autorelease];
        XmlParser *xmlParser = [[[XmlParser alloc] init] autorelease];
        paramArray = [xmlParser fromXml:response withObject:latestParams];
        
        latestParams = [paramArray lastObject];
        [self formatRA:latestParams];
        [self updateRelayBoxes:latestParams];
    }
    else
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    return latestParams;
    
}
/*
 - (IBAction)grabURLInBackground:(id)sender
 {
 NSURL *url = [NSURL URLWithString:@"http://allseeing-i.com"];
 ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
 [request setDelegate:self];
 [request startAsynchronous];
 }
  */
-(void)sendUpdate:(NSString *) controllerUrl
{
    [self.request clearDelegatesAndCancel];
    if (![self queue]) {
        [self setQueue:[[[NSOperationQueue alloc] init] autorelease]];
    }
    
    NSURL *url = [NSURL URLWithString: controllerUrl];
    self.request = [ASIHTTPRequest requestWithURL:url]; 
    [self.request setShouldAttemptPersistentConnection:NO];
    [self.request setRequestMethod:@"GET"];
    [self.request setNumberOfTimesToRetryOnTimeout:2];
    [ASIHTTPRequest setDefaultTimeOutSeconds:20];
    [self.request setUseHTTPVersionOne:YES];
     [self.request setDelegate:self];
   // [self.request startAsynchronous];
    
    [[self queue] addOperation:self.request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"params.xml"];
    
    [self.request setDownloadDestinationPath:path];

    
}

 - (RA *)requestFinished:(ASIHTTPRequest *)request
 {
     NSMutableArray *paramArray;
    // NSString *response = [self.requestUpdate responseString];
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     NSString *path = [documentsDirectory stringByAppendingPathComponent:@"params.xml"];
    // [[self.request responseString] writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];  
     
     BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
     if (fileExists) {
     NSString *response = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
     latestParams = [[[RA alloc] init] autorelease];
    XmlParser *xmlParser = [[[XmlParser alloc] init] autorelease];
     paramArray = [xmlParser fromXml:response withObject:latestParams];
     
     latestParams = [paramArray lastObject];
     
     [self formatRA:latestParams];
     [self updateRelayBoxes:latestParams];
     }
      return latestParams;
 }
 
 - (void)requestFailed:(ASIHTTPRequest *)request
 {
 
     NSError *error = [self.request error];
     NSLog(@"%@", error);

 }


    -(void)formatRA : (RA *)params
    {
        params.formattedTemp1 = [self formatTemp:params.T1];
        params.formattedTemp2 = [self formatTemp:params.T2];
        params.formattedTemp3 = [self formatTemp:params.T3];
        params.formattedpH = [self formatPh:params.PH];
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

    -(void)updateRelayBoxes : (RA *) ra
    {
        NSString *binaryString = [self buildRelayBinary:ra.R];
        NSString *binaryONMask = [self buildRelayBinary:ra.RON];
        NSString *binaryOFFMask = [self buildRelayBinary:ra.ROFF];
        
        ra.isRelay1Active = [[binaryString substringWithRange:NSMakeRange(0,1)] isEqualToString:@"1"] ? YES : NO;
        ra.isRelay2Active = [[binaryString substringWithRange:NSMakeRange(1,1)] isEqualToString:@"1"] ? YES : NO;
        ra.isRelay3Active = [[binaryString substringWithRange:NSMakeRange(2,1)] isEqualToString:@"1"] ? YES : NO;
        ra.isRelay4Active = [[binaryString substringWithRange:NSMakeRange(3,1)] isEqualToString:@"1"] ? YES : NO;
        ra.isRelay5Active = [[binaryString substringWithRange:NSMakeRange(4,1)] isEqualToString:@"1"] ? YES : NO;
        ra.isRelay6Active = [[binaryString substringWithRange:NSMakeRange(5,1)] isEqualToString:@"1"] ? YES : NO;
        ra.isRelay7Active = [[binaryString substringWithRange:NSMakeRange(6,1)] isEqualToString:@"1"] ? YES : NO;
        ra.isRelay8Active = [[binaryString substringWithRange:NSMakeRange(7,1)] isEqualToString:@"1"] ? YES : NO;
        
        ra.isRelay1ONMask = [[binaryONMask substringWithRange:NSMakeRange(0,1)] isEqualToString:@"0"] ? NO : YES;
        ra.isRelay2ONMask = [[binaryONMask substringWithRange:NSMakeRange(1,1)] isEqualToString:@"0"] ? NO : YES;
        ra.isRelay3ONMask = [[binaryONMask substringWithRange:NSMakeRange(2,1)] isEqualToString:@"0"] ? NO : YES;
        ra.isRelay4ONMask = [[binaryONMask substringWithRange:NSMakeRange(3,1)] isEqualToString:@"0"] ? NO : YES;
        ra.isRelay5ONMask = [[binaryONMask substringWithRange:NSMakeRange(4,1)] isEqualToString:@"0"] ? NO : YES;
        ra.isRelay6ONMask = [[binaryONMask substringWithRange:NSMakeRange(5,1)] isEqualToString:@"0"] ? NO : YES;
        ra.isRelay7ONMask = [[binaryONMask substringWithRange:NSMakeRange(6,1)] isEqualToString:@"0"] ? NO : YES;
        ra.isRelay8ONMask = [[binaryONMask substringWithRange:NSMakeRange(7,1)] isEqualToString:@"0"] ? NO : YES;
        
        ra.isRelay1OFFMask = [[binaryOFFMask substringWithRange:NSMakeRange(0,1)] isEqualToString:@"0"] ? YES : NO;
        ra.isRelay2OFFMask = [[binaryOFFMask substringWithRange:NSMakeRange(1,1)] isEqualToString:@"0"] ? YES : NO;
        ra.isRelay3OFFMask = [[binaryOFFMask substringWithRange:NSMakeRange(2,1)] isEqualToString:@"0"] ? YES : NO;
        ra.isRelay4OFFMask = [[binaryOFFMask substringWithRange:NSMakeRange(3,1)] isEqualToString:@"0"] ? YES : NO;
        ra.isRelay5OFFMask = [[binaryOFFMask substringWithRange:NSMakeRange(4,1)] isEqualToString:@"0"] ? YES : NO;
        ra.isRelay6OFFMask = [[binaryOFFMask substringWithRange:NSMakeRange(5,1)] isEqualToString:@"0"] ? YES : NO;
        ra.isRelay7OFFMask = [[binaryOFFMask substringWithRange:NSMakeRange(6,1)] isEqualToString:@"0"] ? YES : NO;
        ra.isRelay8OFFMask = [[binaryOFFMask substringWithRange:NSMakeRange(7,1)] isEqualToString:@"0"] ? YES : NO;  
        
        
         //2nd Relay Box
         
         NSString *binary0String = [self buildRelayBinary:ra.R0];
         NSString *binary0ONMask = [self buildRelayBinary:ra.RON0];
         NSString *binary0OFFMask = [self buildRelayBinary:ra.ROFF0];
         ra.isRelay01Active = [[binary0String substringWithRange:NSMakeRange(0,1)] isEqualToString:@"1"] ? YES : NO;
         ra.isRelay02Active = [[binary0String substringWithRange:NSMakeRange(1,1)] isEqualToString:@"1"] ? YES : NO;
         ra.isRelay03Active = [[binary0String substringWithRange:NSMakeRange(2,1)] isEqualToString:@"1"] ? YES : NO;
         ra.isRelay04Active = [[binary0String substringWithRange:NSMakeRange(3,1)] isEqualToString:@"1"] ? YES : NO;
         ra.isRelay05Active = [[binary0String substringWithRange:NSMakeRange(4,1)] isEqualToString:@"1"] ? YES : NO;
         ra.isRelay06Active = [[binary0String substringWithRange:NSMakeRange(5,1)] isEqualToString:@"1"] ? YES : NO;
         ra.isRelay07Active = [[binary0String substringWithRange:NSMakeRange(6,1)] isEqualToString:@"1"] ? YES : NO;
         ra.isRelay08Active = [[binary0String substringWithRange:NSMakeRange(7,1)] isEqualToString:@"1"] ? YES : NO;
         
         ra.isRelay01ONMask = [[binary0ONMask substringWithRange:NSMakeRange(0,1)] isEqualToString:@"0"] ? NO : YES;
         ra.isRelay02ONMask = [[binary0ONMask substringWithRange:NSMakeRange(1,1)] isEqualToString:@"0"] ? NO : YES;
         ra.isRelay03ONMask = [[binary0ONMask substringWithRange:NSMakeRange(2,1)] isEqualToString:@"0"] ? NO : YES;
         ra.isRelay04ONMask = [[binary0ONMask substringWithRange:NSMakeRange(3,1)] isEqualToString:@"0"] ? NO : YES;
         ra.isRelay05ONMask = [[binary0ONMask substringWithRange:NSMakeRange(4,1)] isEqualToString:@"0"] ? NO : YES;
         ra.isRelay06ONMask = [[binary0ONMask substringWithRange:NSMakeRange(5,1)] isEqualToString:@"0"] ? NO : YES;
         ra.isRelay07ONMask = [[binary0ONMask substringWithRange:NSMakeRange(6,1)] isEqualToString:@"0"] ? NO : YES;
         ra.isRelay08ONMask = [[binary0ONMask substringWithRange:NSMakeRange(7,1)] isEqualToString:@"0"] ? NO : YES;
         
         ra.isRelay01OFFMask = [[binary0OFFMask substringWithRange:NSMakeRange(0,1)] isEqualToString:@"0"] ? YES : NO;
         ra.isRelay02OFFMask = [[binary0OFFMask substringWithRange:NSMakeRange(1,1)] isEqualToString:@"0"] ? YES : NO;
         ra.isRelay03OFFMask = [[binary0OFFMask substringWithRange:NSMakeRange(2,1)] isEqualToString:@"0"] ? YES : NO;
         ra.isRelay04OFFMask = [[binary0OFFMask substringWithRange:NSMakeRange(3,1)] isEqualToString:@"0"] ? YES : NO;
         ra.isRelay05OFFMask = [[binary0OFFMask substringWithRange:NSMakeRange(4,1)] isEqualToString:@"0"] ? YES : NO;
         ra.isRelay06OFFMask = [[binary0OFFMask substringWithRange:NSMakeRange(5,1)] isEqualToString:@"0"] ? YES : NO;
         ra.isRelay07OFFMask = [[binary0OFFMask substringWithRange:NSMakeRange(6,1)] isEqualToString:@"0"] ? YES : NO;
         ra.isRelay08OFFMask = [[binary0OFFMask substringWithRange:NSMakeRange(7,1)] isEqualToString:@"0"] ? YES : NO;    
         

    }
    
    -(NSString *)buildRelayBinary : (NSNumber *)relayByte
    {
        NSMutableString *str = [NSMutableString string];
        int numCopy = [relayByte intValue];
        for(NSInteger i = 0; i<8; i++)
        {
            [str insertString:((numCopy & 1) ? @"1" : @"0") atIndex:i];
            numCopy >>=1;
        }
        return str;
        /*NSMutableString* tempStr = [[NSMutableString string]retain];
        NSUInteger bit = ~(NSUIntegerMax >> 1);
        do {
            [tempStr appendString:(((NSUInteger)relayByte & bit) ? @"1" : @"0")];
        } while (bit >>= 1);
        
        return [tempStr substringFromIndex:[tempStr length]-8];        
         */
        
    }
-(void) dealloc
{
    [queue release];
    [super dealloc];
}
@end
