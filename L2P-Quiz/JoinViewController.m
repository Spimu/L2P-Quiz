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
    self.serverStatus.text = @"Waiting for host to start the game";
    
    
}

-(void)connectionToServerAborted{
    self.statusLabel.textColor = [UIColor redColor];
    self.statusLabel.text = @"Disconnected";
    
    [self.activityIndicatorView stopAnimating];
    self.serverStatus.text = @"";
}

@end
