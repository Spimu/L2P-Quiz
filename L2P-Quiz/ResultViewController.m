//
//  ResultViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/18/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

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
    NSString *scoreText = [NSString stringWithFormat:@"%d correct solutions, %d wrong solutions => %d",_solManager.correctAnswersInCurrentRound,_solManager.wrongAnswersInCurrentRound,_solManager.correctAnswersInCurrentRound+_solManager.wrongAnswersInCurrentRound];
    [_scoreLabel setText:scoreText];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//----------------------------------------------------------------------------------------
#pragma mark Table View Delegates
//----------------------------------------------------------------------------------------


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_solManager questionsWithSolutions] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    ResultCell *cell = (ResultCell*)[tableView dequeueReusableCellWithIdentifier:@"resultCell"];

    NSDictionary *questionsWithSolutions = [[_solManager questionsWithSolutions] objectAtIndex:indexPath.row];
    
    [[cell question] setText:[questionsWithSolutions valueForKey:@"question"]];
    [[cell yourSolution] setText:[NSString stringWithFormat:@"You: %@",[questionsWithSolutions valueForKey:@"own_sol"]]];
    [[cell correctSolution] setText:[NSString stringWithFormat:@"Correct: %@",[questionsWithSolutions valueForKey:@"corr_sol"]]];
    
    if ([[questionsWithSolutions valueForKey:@"own_sol"] isEqualToString:[questionsWithSolutions valueForKey:@"corr_sol"]])
    {
        [cell setBackgroundColor:[UIColor greenColor]];
    }
    else
    {
        [cell setBackgroundColor:[UIColor redColor]];
    }
    
    return cell;
}


@end
