//
//  CountdownViewController.m
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 27.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "CountdownViewController.h"
#import "GameViewController.h"

@interface CountdownViewController ()

@end

@implementation CountdownViewController

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
    time = 5;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownDuration) userInfo:Nil repeats:YES];
}

-(void)countDownDuration{
    if (time > 0) {
        time -= 1;
        self.countdownLabel.text = [NSString stringWithFormat:@"%i", time];
    } else {
        [timer invalidate];
        NSLog(@"%@", @"Start");
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
