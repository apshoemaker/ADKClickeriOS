//
//  ViewController.h
//  Clicker
//
//  Created by Paul Shoemaker on 3/1/13.
//  Copyright (c) 2013 adk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMXMLDocument.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *numberOfClicks;
@property (strong, nonatomic) NSMutableData *returnData;

- (void) getTotalClicks;
- (void) performRequestFor:(NSString *)method;
- (void) parseResponse:(NSData *)response;

@end
