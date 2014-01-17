//
//  StatisticsPageContentViewController.h
//  L2P-Quiz
//
//  Created by Marty Pye on 17/01/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsPageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property NSUInteger pageIndex;
@property NSString *titleText;

@end
