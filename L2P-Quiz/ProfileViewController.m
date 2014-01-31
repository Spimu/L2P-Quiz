//
//  ProfileViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/31/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserManager.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    
    [_scoreLabel setText:[NSString stringWithFormat:@"%d",[[UserManager sharedManager] userScore]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
