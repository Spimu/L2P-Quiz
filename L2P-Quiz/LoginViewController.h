//
//  LoginViewController.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/7/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "L2PLoginDelegate.h"

@interface LoginViewController : UIViewController <L2PLoginDelegate>
- (IBAction)onLogin:(id)sender;

@end
