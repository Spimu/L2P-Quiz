//
//  GameViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

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

// This function first checks if the user answered right or wrong
// Then it shows the correct answer if the user is not in 1 minute madness mode
// At the end it jumps to the next question
- (void)proceed
{
    //Checks if the answer was right
    [self checkIfRight];
    
    //Displays the right answer if the user is not im 1minMadnessMode
    [self displayRightAnswer];
    
    //Check if we reached the last question in ?/10
    [self checkIfLastQuestion];
    
    //Show the next question
    NSTimeInterval delay = 5.0;
    if ([[SingleGameManager sharedManager] selectedGameMode] == GameMode_1minute) {
        delay = 1.0;
    }
    [self performSelector:@selector(hideQuestion) withObject:self afterDelay:delay];
    
    [self.view setUserInteractionEnabled:YES];
}


//TODO: submit the result to our SingleGameManager
- (void) checkIfRight
{
    
}


//TODO: if wrong: blink the right answer / if right: set correct_background
- (void) displayRightAnswer
{
    if ([[SingleGameManager sharedManager] selectedGameMode] != GameMode_1minute) {
        //TODO
    }
}


//TODO: check if we are in ?/10-mode and if we reached the last question
- (void) checkIfLastQuestion
{
    
}


- (void) hideQuestion
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [_questionIV setFrame:CGRectMake(0, _questionIV.frame.origin.y-200, _questionIV.frame.size.width, _questionIV.frame.size.height)];
    [_questionLabel setFrame:CGRectMake(_questionLabel.frame.origin.x, _questionLabel.frame.origin.y-200, _questionLabel.frame.size.width, _questionLabel.frame.size.height)];
    
    [_sol1_IV setFrame:CGRectMake(_sol1_IV.frame.origin.x-400, _sol1_IV.frame.origin.y, _sol1_IV.frame.size.width, _sol1_IV.frame.size.height)];
    [_sol1_button setFrame:CGRectMake(_sol1_button.frame.origin.x-400, _sol1_button.frame.origin.y, _sol1_button.frame.size.width, _sol1_button.frame.size.height)];
    
    [_sol2_IV setFrame:CGRectMake(_sol2_IV.frame.origin.x+400, _sol2_IV.frame.origin.y, _sol2_IV.frame.size.width, _sol2_IV.frame.size.height)];
    [_sol2_button setFrame:CGRectMake(_sol2_button.frame.origin.x+400, _sol2_button.frame.origin.y, _sol2_button.frame.size.width, _sol2_button.frame.size.height)];
    
    [_sol3_IV setFrame:CGRectMake(_sol3_IV.frame.origin.x-400, _sol3_IV.frame.origin.y, _sol3_IV.frame.size.width, _sol3_IV.frame.size.height)];
    [_sol3_button setFrame:CGRectMake(_sol3_button.frame.origin.x-400, _sol3_button.frame.origin.y, _sol3_button.frame.size.width, _sol3_button.frame.size.height)];
    
    [_sol4_IV setFrame:CGRectMake(_sol4_IV.frame.origin.x+400, _sol4_IV.frame.origin.y, _sol4_IV.frame.size.width, _sol4_IV.frame.size.height)];
    [_sol4_button setFrame:CGRectMake(_sol4_button.frame.origin.x+400, _sol4_button.frame.origin.y, _sol4_button.frame.size.width, _sol4_button.frame.size.height)];
    
    [self performSelector:@selector(showQuestion) withObject:self afterDelay:1.0];
    
    [UIView commitAnimations];
}

- (void) showQuestion
{
    //TODO: change question
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [_questionIV setFrame:CGRectMake(0, _questionIV.frame.origin.y+200, _questionIV.frame.size.width, _questionIV.frame.size.height)];
    [_questionLabel setFrame:CGRectMake(_questionLabel.frame.origin.x, _questionLabel.frame.origin.y+200, _questionLabel.frame.size.width, _questionLabel.frame.size.height)];
    
    [_sol1_IV setFrame:CGRectMake(_sol1_IV.frame.origin.x+400, _sol1_IV.frame.origin.y, _sol1_IV.frame.size.width, _sol1_IV.frame.size.height)];
    [_sol1_button setFrame:CGRectMake(_sol1_button.frame.origin.x+400, _sol1_button.frame.origin.y, _sol1_button.frame.size.width, _sol1_button.frame.size.height)];
    
    [_sol2_IV setFrame:CGRectMake(_sol2_IV.frame.origin.x-400, _sol2_IV.frame.origin.y, _sol2_IV.frame.size.width, _sol2_IV.frame.size.height)];
    [_sol2_button setFrame:CGRectMake(_sol2_button.frame.origin.x-400, _sol2_button.frame.origin.y, _sol2_button.frame.size.width, _sol2_button.frame.size.height)];
    
    [_sol3_IV setFrame:CGRectMake(_sol3_IV.frame.origin.x+400, _sol3_IV.frame.origin.y, _sol3_IV.frame.size.width, _sol3_IV.frame.size.height)];
    [_sol3_button setFrame:CGRectMake(_sol3_button.frame.origin.x+400, _sol3_button.frame.origin.y, _sol3_button.frame.size.width, _sol3_button.frame.size.height)];
    
    [_sol4_IV setFrame:CGRectMake(_sol4_IV.frame.origin.x-400, _sol4_IV.frame.origin.y, _sol4_IV.frame.size.width, _sol4_IV.frame.size.height)];
    [_sol4_button setFrame:CGRectMake(_sol4_button.frame.origin.x-400, _sol4_button.frame.origin.y, _sol4_button.frame.size.width, _sol4_button.frame.size.height)];
    
    [UIView commitAnimations];
}


- (IBAction)sol1Pressed:(id)sender
{
    [_sol1_IV setImage:[UIImage imageNamed:@"sol_background_selected.png"]];
    [self.view setUserInteractionEnabled:NO];
    [self proceed];
}

- (IBAction)sol2Pressed:(id)sender
{
    [_sol2_IV setImage:[UIImage imageNamed:@"sol_background_selected.png"]];
    [self.view setUserInteractionEnabled:NO];
    [self proceed];
}

- (IBAction)sol3Pressed:(id)sender
{
    [_sol3_IV setImage:[UIImage imageNamed:@"sol_background_selected.png"]];
    [self.view setUserInteractionEnabled:NO];
    [self proceed];
}

- (IBAction)sol4Pressed:(id)sender
{
    [_sol4_IV setImage:[UIImage imageNamed:@"sol_background_selected.png"]];
    [self.view setUserInteractionEnabled:NO];
    [self proceed];
}
@end
