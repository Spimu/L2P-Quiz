//
//  HostViewController.m
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 22.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "HostViewController.h"

@interface HostViewController () {
    
    AppDelegate *appDelegate;
    
}

@end

@implementation HostViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    appDelegate.networkManager = [[NetworkManager alloc]initWithRole:@"server"];
    appDelegate.networkManager.serverDelegate = self;
    [self.tableView setDelegate:appDelegate.networkManager];
    [self.tableView setDataSource:appDelegate.networkManager];
	
}

-(void)viewWillDisappear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Network delegate implementation
-(void)updateTableView {
    [self.tableView reloadData];
}

@end
