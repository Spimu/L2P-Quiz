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
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.networkManager = [[NetworkManager alloc]initWithRole:@"client"];
    appDelegate.networkManager.clientDelegate = self;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(stopClient:)];
    self.navigationItem.leftBarButtonItem=newBackButton;
    
}

-(void)stopClient:(UIBarButtonItem *)sender {
    [appDelegate.networkManager stopClient];
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
    
}

-(void)connectionToServerAborted{
    
}

@end
