//
//  StartQuizViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "StartQuizViewController.h"

@interface StartQuizViewController ()

@end

@implementation StartQuizViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"1minSegue"])
    {
        [[SingleGameManager sharedManager] setSelectedGameMode:GameMode_1minute];
    }
    if([segue.identifier isEqualToString:@"10questionsSegue"])
    {
        [[SingleGameManager sharedManager] setSelectedGameMode:GameMode_1minute];
    }
    if([segue.identifier isEqualToString:@"InfinitySegue"])
    {
        [[SingleGameManager sharedManager] setSelectedGameMode:GameMode_1minute];
    }
}

@end
