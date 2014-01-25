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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate.networkManager = [[NetworkManager alloc]initWithRole:@"server"];
    appDelegate.networkManager.delegate = self;
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
