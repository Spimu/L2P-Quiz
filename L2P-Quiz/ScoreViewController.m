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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scoresHaveBeenComputed:(NSDictionary*)allScores {
    NSLog(@"%@", allScores);
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [clients count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *simpleTableIdentifier = @"SimpleTableItem";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//    
//    NSString *key = [clients allKeys][indexPath.row];
//    
//    NSString *providerNameString = clients[key];
//    NSString *providerIdString = key;
//    cell.textLabel.text  = providerNameString;
//    cell.detailTextLabel.text  = providerIdString;
//    
//    return cell;
//}

@end
