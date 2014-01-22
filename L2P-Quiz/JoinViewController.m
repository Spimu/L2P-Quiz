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
}

@end

@implementation JoinViewController

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
    
    client = [[ThoMoClientStub alloc] initWithProtocolIdentifier:@"examiner"];
	[client setDelegate:self];
	[client start];
    connected = false;
}

-(void)viewDidDisappear:(BOOL)animated {
    [client stop];
    connected = false;
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

#pragma mark delegate methods

- (void)client:(ThoMoClientStub *)theClient didConnectToServer:(NSString *)aServerIdString{
    
    self.statusLabel.textColor = [UIColor greenColor];
    self.statusLabel.text = @"Connected to Examiner";
    connected = true;
    [self updateButton];
    
}

- (void)client:(ThoMoClientStub *)theClient didDisconnectFromServer:(NSString *)aServerIdString errorMessage:(NSString *)errorMessage {
    
    self.statusLabel.textColor = [UIColor redColor];
    self.statusLabel.text = @"Disconnected";
    [self updateButton];
}

@end
