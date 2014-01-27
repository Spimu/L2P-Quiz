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
    
    self.nameTextField.text = [[UIDevice currentDevice] name];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    appDelegate.networkManager = [[NetworkManager alloc]initWithRole:@"server" andName:self.nameTextField.text];
    appDelegate.networkManager.serverDelegate = self;
    [self.tableView setDelegate:appDelegate.networkManager];
    [self.tableView setDataSource:appDelegate.networkManager];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop Server" style:UIBarButtonItemStyleBordered target:self action:@selector(stopServer:)];
    self.navigationItem.leftBarButtonItem=newBackButton;

	
}

-(void)stopServer:(UIBarButtonItem *)sender {
    [appDelegate.networkManager stopServer];
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)openCourses:(id)sender {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"multiplayer"]) {
        [[segue destinationViewController]setDetailItem:@"multi"];
    }
}

- (IBAction)startGame:(id)sender {
    @try {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CountdownViewController *viewController = (CountdownViewController *)[storyboard instantiateViewControllerWithIdentifier:@"countdown"];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Caught exception %@", exception);
    }
    @finally {
        
    }
    
}



@end
