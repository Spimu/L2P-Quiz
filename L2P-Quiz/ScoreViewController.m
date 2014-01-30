//
//  ScoreViewController.m
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 29.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController () {
    
    AppDelegate *appDelegate;
}

@end

@implementation ScoreViewController

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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.networkManager.scoreDelegate = self;
    [appDelegate.networkManager sendScoreToHost:_playerScore];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scoresHaveBeenComputed:(NSDictionary*)allScores {
    _allScores = allScores;
    [self.scoreTableView reloadData];
    NSLog(@"%@", allScores);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allScores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *key = [_allScores allKeys][indexPath.row];
    
    NSString *providerNameString = [NSString stringWithFormat:@"%@: %@", [[_allScores objectForKey:key] stringValue], key];
    cell.textLabel.text  = providerNameString;
    
    return cell;
}

@end
