//
//  StartQuizViewController.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleGameManager.h"
#import "SelectCourseViewController.h"
#import <GameKit/GameKit.h>

@interface StartQuizViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *oneMinuteButton;
@property (weak, nonatomic) IBOutlet UIButton *tenQuestionsButton;
@property (weak, nonatomic) IBOutlet UIButton *infinityButton;
@property (weak, nonatomic) IBOutlet UIButton *duelStartButton;
@property (weak, nonatomic) IBOutlet UIButton *duelViewButton;


@end
