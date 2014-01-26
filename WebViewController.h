//
//  WebViewController.h
//  L2PAPI
//
//  Created by Aaron Krämer on 11/29/13.
//  Copyright (c) 2013 Aaron Krämer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "L2PLoginDelegate.h"

@interface WebViewController : UIViewController <UIWebViewDelegate>

-(void)setVerificationURL:(NSURL*)url;
-(void) setL2PLoginDelegate:(id<L2PLoginDelegate>) delegate;
- (IBAction)onClose:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
