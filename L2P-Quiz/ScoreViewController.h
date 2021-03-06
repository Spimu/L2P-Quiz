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
#import "StartQuizViewController.h"


@interface ScoreViewController : UIViewController <NetworkManagerScoreDelegate>

@property (weak, nonatomic) IBOutlet UITableView *scoreTableView;
@property (nonatomic) NSDictionary *allScores;
@property (nonatomic) NSNumber *playerScore;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@end
