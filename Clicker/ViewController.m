//
//  ViewController.m
//  Clicker
//
//  Created by Paul Shoemaker on 3/1/13.
//  Copyright (c) 2013 adk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize numberOfClicks = _numberOfClicks;
@synthesize returnData = _returnData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add ourselves as an observer to this protocol delegate in case the click count is altered
    //outside of the app when it is inactive
    //also takes care of first time gather
    [[NSNotificationCenter defaultCenter] addObserver:self
                                        selector:@selector(getTotalClicks)
                                        name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) getTotalClicks{
    [self performRequestFor:@"getTotalClicks"];
}

- (void) performRequestFor:(NSString *)method{
    NSString *base = @"http://166.78.136.254:8080/AdkServiceProject/services/Service/";
    NSString *url = [base stringByAppendingString:method];
    
    NSMutableURLRequest *request =  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    if(connection){
        NSLog(@"connection is good");
        _returnData = [NSMutableData data];
    } else {
        NSLog(@"connection is bad");
    }
}

- (IBAction)doClick:(UIButton *)sender {
    [self performRequestFor:@"clickIt"];
}


- (void) parseResponse:(NSData *)response{
    //parse integer return - same for all requests
    NSError *error;
    
    SMXMLDocument *document = [SMXMLDocument documentWithData:response error:&error];
    
    NSString *returnValue = [document.root valueWithPath:@"return"];
    
    [_numberOfClicks setText:returnValue];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"Received response");
    [_returnData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_returnData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection failed to load");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self parseResponse:_returnData];
}

- (void)connection:(NSURLConnection *)connection{
    
}

@end
