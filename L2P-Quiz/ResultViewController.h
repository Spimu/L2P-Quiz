//
//  ResultViewController.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/18/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SolutionManager.h"
#import "ResultCell.h"

@interface ResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) SolutionManager *solManager;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
