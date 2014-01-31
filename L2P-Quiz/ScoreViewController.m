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
    NSArray *scores;
    NSArray *players;
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
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Quit Game" style:UIBarButtonItemStyleBordered target:self action:@selector(quitGame:)];
    self.navigationItem.leftBarButtonItem=newBackButton;
    
    [_activityIndicator startAnimating];
    
}

-(void)quitGame:(UIBarButtonItem *)sender {
    [appDelegate.networkManager stopServer];
    [appDelegate.networkManager stopClient];
    
    NSArray *viewControllers = [[self navigationController] viewControllers];
    NSLog(@"%@", viewControllers);
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[StartQuizViewController class]]){
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scoresHaveBeenComputed:(NSDictionary*)allScores {
    
    [_activityIndicator stopAnimating];
    [_activityIndicator removeFromSuperview];
    [_activityLabel removeFromSuperview];
    
    _allScores = allScores;
    
    scores = [[_allScores allValues] sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [(NSNumber *)obj2 compare:(NSNumber *)obj1];
    }];
    
    players = [_allScores keysSortedByValueUsingComparator:^(id obj1, id obj2) {
        return [(NSNumber *)obj2 compare:(NSNumber *)obj1];
    }];
    
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
    
    cell.textLabel.text  = [NSString stringWithFormat:@"%@   %@", scores[indexPath.row], players [indexPath.row]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
