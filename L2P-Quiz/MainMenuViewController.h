//
//  MainMenuViewController.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/9/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIController.h"
#import "SingleGameManager.h"

@interface MainMenuViewController : UIViewController <DataLoadedDelegate>
- (IBAction)onLogout:(id)sender;

@end
