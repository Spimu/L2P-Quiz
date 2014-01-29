//
//  HostViewController.m
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 22.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "HostViewController.h"
#import "GameViewController.h"


@interface HostViewController () {
    
    AppDelegate *appDelegate;
    NSTimer *timer;
    int time;
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"multiplayer"]) {
        [[segue destinationViewController]setDetailItem:@"multi"];
        [[segue destinationViewController]setSelectedCoursesforMultiplayer:[appDelegate.networkManager selectedCoursesByHost]];
    }
    if ([[segue identifier] isEqualToString:@"multiplayerSegue"]) {
        [[segue destinationViewController] setMultiplayerManager:appDelegate.networkManager.multiplayerManager];
    }
}

- (IBAction)startGame:(id)sender {
    
    
//    if (!appDelegate.networkManager.selectedCoursesByHost || !appDelegate.networkManager.selectedCoursesByHost.count){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                        message:@"You have not chosen any courses." delegate:self cancelButtonTitle:@"Cancel"
//                                              otherButtonTitles:@"OK", nil];
//        [alert show];
//    } else if (!appDelegate.server.connectedClients || !appDelegate.server.connectedClients.count) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                    message:@"No clients are connected to the server." delegate:self cancelButtonTitle:@"Cancel"
//                                          otherButtonTitles:@"OK", nil];
//        [alert show];
//    } else {
    
        //Timer until game starts
        
//        // Window bounds.
//        CGRect frame = self.view.frame;
//        
//        // Create a view and add it to the window.
//        UIView* timerView = [[UIView alloc] initWithFrame: frame];
//        [timerView setBackgroundColor: [UIColor colorWithRed:0.231 green:0.49 blue:0.87 alpha:1.0]];
//        [self.view addSubview:timerView];
//    
//        UILabel *timerLabel = [[UILabel alloc]init];
//    
//        [self.navigationController setNavigationBarHidden:YES];

        [appDelegate.networkManager gameWasStarted];
//    }
}

-(void)gameHasBeenStarted {
    
    [self performSegueWithIdentifier:@"multiplayerSegue" sender:nil];

    //[self.navigationController pushViewController:gameViewController animated:YES];
    

}


@end
