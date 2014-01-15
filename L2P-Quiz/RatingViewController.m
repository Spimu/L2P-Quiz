//
//  RatingViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/15/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "RatingViewController.h"

@interface RatingViewController ()

@end

@implementation RatingViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) submitRating
{
    //TODO
}

- (IBAction)ratePressed:(id)sender
{
    [self submitRating];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
