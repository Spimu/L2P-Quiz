//
//  SelectCourseViewController.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleGameManager.h"
#import "AppDelegate.h"
#import "NetworkManager.h"
#import "Course.h"

@interface SelectCourseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (IBAction)startPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id selectedCoursesforMultiplayer;

@end
