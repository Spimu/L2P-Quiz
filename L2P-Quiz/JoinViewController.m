//
//  JoinViewController.m
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 22.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "JoinViewController.h"

@interface JoinViewController () {
    BOOL connected;
    AppDelegate *appDelegate;
    
    NSTimer *timer;
    int time;
    UILabel *timerLabel;
    UIView *timerView;
}

@end

@implementation JoinViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameTextField.text = [[UIDevice currentDevice] name];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.networkManager = [[NetworkManager alloc]initWithRole:@"client" andName:self.nameTextField.text];
    appDelegate.networkManager.clientDelegate = self;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(stopClient:)];
    self.navigationItem.leftBarButtonItem=newBackButton;
    
    
    
}

-(void)stopClient:(UIBarButtonItem *)sender {
    [appDelegate.networkManager stopClient];
    
    self.statusLabel.textColor = [UIColor redColor];
    self.statusLabel.text = @"Disconnected";
    
    
    [self.activityIndicatorView stopAnimating];
    self.serverStatus.text = @"";
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Implementation of NetworkManagerClientDelegate methods

-(void)connectionToServerEstablished{
    self.statusLabel.textColor = [UIColor greenColor];
    self.statusLabel.text = @"Connected";
    
    [self.activityIndicatorView startAnimating];
    self.serverStatus.text = @"Waiting for host...";
    
    
}

-(void)connectionToServerAborted{
    self.statusLabel.textColor = [UIColor redColor];
    self.statusLabel.text = @"Disconnected";
    
    [self.activityIndicatorView stopAnimating];
    self.serverStatus.text = @"";
}



-(void)gameHasBeenStarted {
    //Timer until game starts
    // Window bounds.
    CGRect frame = self.view.frame;
    
    // Create a view and add it to the window.
    timerView = [[UIView alloc] initWithFrame: frame];
    [timerView setBackgroundColor: [UIColor colorWithRed:0.231 green:0.49 blue:0.87 alpha:1.0]];
    [self.view addSubview:timerView];
    
    UILabel *startText = [[UILabel alloc] initWithFrame:CGRectMake(90, 120, 200, 25)];
    startText.text = [NSString stringWithFormat:@"The game starts in"];
    startText.textAlignment = NSTextAlignmentCenter;
    startText.textColor = [UIColor whiteColor];
    startText.font = [UIFont systemFontOfSize:20.0];
    [timerView addSubview:startText];
    
    timerLabel = [[UILabel alloc]initWithFrame: CGRectMake(133, 200, 55, 63)];
    timerLabel.textAlignment = NSTextAlignmentCenter;
    timerLabel.textColor = [UIColor whiteColor];
    timerLabel.font = [UIFont systemFontOfSize:60.0];
    [timerView addSubview:timerLabel];
    
    time = 5;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownDuration) userInfo:Nil repeats:YES];
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)countDownDuration{
    if (time > 0) {
        time -= 1;
        timerLabel.text = [NSString stringWithFormat:@"%i", time];
    } else {
        [timer invalidate];
        //start game
        [timerView removeFromSuperview];
        [self.navigationController setNavigationBarHidden:NO];
        [self performSegueWithIdentifier:@"multiplayerSegue" sender:nil];
        NSLog(@"%@", @"Start");
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"multiplayerSegue"]) {
        [[segue destinationViewController] setMultiplayerManager:appDelegate.networkManager.multiplayerManager];
    }
}

@end
