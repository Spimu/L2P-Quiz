//
//  RatingViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/15/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "RatingViewController.h"

@interface RatingViewController ()

@property (nonatomic) NSMutableDictionary *ratingDict;

@end

#define RATING_ARRAY @[@"Good question",@"I doubt the answer",@"Duplicate",@"Bullshit"]

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
	
    NSMutableArray *nullArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[RATING_ARRAY count]; i++) {
        [nullArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    _ratingDict = [[NSMutableDictionary alloc] initWithObjects:nullArray forKeys:RATING_ARRAY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) submitRating
{
    NSMutableArray *nullArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[RATING_ARRAY count]; i++) {
        [nullArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    if(![[_ratingDict allValues] isEqualToArray:nullArray])
    {
        //TODOOO
    }
}

- (IBAction)ratePressed:(id)sender
{
    [self submitRating];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [RATING_ARRAY count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier] ;
    }
    
    cell.textLabel.text = RATING_ARRAY[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [_ratingDict setValue:[NSNumber numberWithBool:NO] forKey:cellText];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [_ratingDict setValue:[NSNumber numberWithBool:YES] forKey:cellText];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
