//
//  StatisticsViewController.h
//  L2P-Quiz
//
//  Created by Marty Pye on 17/01/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticsPageContentViewController.h"

@interface StatisticsViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSString* nameOfCourse;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;


@end
