//
//  ScoreViewController.h
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 29.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NetworkManager.h"


@interface ScoreViewController : UIViewController <NetworkManagerScoreDelegate>

@property (weak, nonatomic) IBOutlet UITableView *scoreTableView;
@property (nonatomic) NSDictionary *scores;
@end
