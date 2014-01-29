//
//  HostViewController.h
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 22.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NetworkManager.h"
#import "SelectCourseViewController.h"
#import "MultiGameViewController.h"


@interface HostViewController : UIViewController <NetworkManagerServerDelegate>
{

}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *selectCourse;
//@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@end
