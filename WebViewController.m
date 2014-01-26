//
//  WebViewController.m
//  L2PAPI
//
//  Created by Aaron Krämer on 11/29/13.
//  Copyright (c) 2013 Aaron Krämer. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    id<L2PLoginDelegate> l2pDelegate;
}

@end

@implementation WebViewController

@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setVerificationURL:(NSURL *)url
{
    NSURLRequest *verificationRequest = [NSURLRequest requestWithURL:url];
    [self.webView setDelegate:self];
    [self.webView loadRequest:verificationRequest];
}

#pragma mark WebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *url = [webView.request.URL absoluteString];
    NSRange rangeOfString = [url rangeOfString:@"q=authorized"];
    
    if (rangeOfString.location != NSNotFound) {
        if(l2pDelegate) {
            [l2pDelegate loginSucessful];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
//
}

-(void) setL2PLoginDelegate:(id<L2PLoginDelegate>) delegate
{
    l2pDelegate = delegate;
}

- (IBAction)onClose:(id)sender
{
    if(l2pDelegate) {
        [l2pDelegate loginError:@"Unable to login."];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

@end
