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
    
    appDelegate.networkManager = [[NetworkManager alloc]initWithRole:@"client"];
    
}

-(void)viewDidDisappear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateButton {
    
    if (!([self.nameTextField.text isEqualToString:@""]) && connected==true) {
        self.joinGameButton.enabled = true;
    } else {
        self.joinGameButton.enabled = false;
    }
}
@end
