//
//  SelectCourseViewController.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleGameManager.h"

@interface SelectCourseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (IBAction)startPressed:(id)sender;

@end