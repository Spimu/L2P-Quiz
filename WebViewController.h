//
//  WebViewController.h
//  L2PAPI
//
//  Created by Aaron Krämer on 11/29/13.
//  Copyright (c) 2013 Aaron Krämer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

-(void)setVerificationURL:(NSURL*)url;

@end
