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
    
    [_sol1_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_sol2_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_sol3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_sol4_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self getAllPossibleQuestions];
}



- (void) viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(showQuestion) withObject:nil afterDelay:0.5];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//----------------------------------------------------------------------------------------
#pragma mark Helper functions
//----------------------------------------------------------------------------------------


// This function first checks if the user answered right or wrong
// Then it shows the correct answer if the user is not in 1 minute madness mode
// At the end it jumps to the next question
- (void)proceed:(id)sender
{
    //Checks if the answer was right
    [self performSelector:@selector(checkIfRight:) withObject:sender afterDelay:1.0];
    
    //Check if we reached the last question in ?/10
    [self checkIfLastQuestion];
    
    //Show the next question
    NSTimeInterval delay = 4.0;
    if ([[SingleGameManager sharedManager] selectedGameMode] == GameMode_1minute) {
        delay = 0.3;
    }
    [self performSelector:@selector(hideQuestion) withObject:self afterDelay:delay];
    
    [self.view setUserInteractionEnabled:YES];
}



//TODO: submit the result to our SingleGameManager
- (void) checkIfRight:(id)sender
{
    BOOL answerWasCorrect = NO;
    UIButton *senderButton = (UIButton *)sender;
    NSString *correctSolution = [[[SingleGameManager sharedManager] currentQuestion] valueForKey:@"corr_sol"];
    
    if ([senderButton.titleLabel.text isEqualToString:correctSolution])
    {
        answerWasCorrect = YES;
    }
    
    //TODO: submit to stats
 
    //Displays the right answer if the user is not im 1minMadnessMode
    if ([[SingleGameManager sharedManager] selectedGameMode] != GameMode_1minute)
    {
        int senderTag = [senderButton tag];
        UIImageView *correctIV = (UIImageView *)[self.view viewWithTag:senderTag-10];
        if (answerWasCorrect)
        {
            [correctIV setImage:[UIImage imageNamed:@"sol_background_correct"]];
        }
        else
        {
            [correctIV setImage:[UIImage imageNamed:@"sol_background_wrong"]];
            for (int i = 11; i < 15; i++)
            {
                UIButton *tempButton = (UIButton *)[self.view viewWithTag:i];
                if ([tempButton.titleLabel.text isEqualToString:correctSolution])
                {
                    UIImageView *actuallyCorrectIV = (UIImageView *)[self.view viewWithTag:i-10];
                    [actuallyCorrectIV setImage:[UIImage imageNamed:@"sol_background_correct"]];
                }
            }
        }
    }
}



//TODO: if wrong: blink the right answer / if right: set correct_background
- (void) displayRightAnswer
{
    
}



//TODO: check if we are in ?/10-mode and if we reached the last question
- (void) checkIfLastQuestion
{
    
}



- (void) getAllPossibleQuestions
{
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    // Looking for all the course entities
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Filter all the courses we selected
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName IN %@", [[SingleGameManager sharedManager] selectedCourses]];
    [fetchRequest setPredicate:predicate];
    
    //Get all the possible questions and save them in our sanglegamemanager
    NSArray *fetchedCourses = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableSet *questions = [[NSMutableSet alloc] init];
    for (NSManagedObject *course in fetchedCourses)
    {
        NSSet *set = [course valueForKeyPath:@"questions"];
        [questions unionSet:set];
    }
    
    [[SingleGameManager sharedManager] setPossibleQuestions:[questions allObjects]];
}



- (NSArray *) shuffleArray:(NSArray *)inputArray
{
    NSMutableArray *outputArray = [[NSMutableArray alloc] initWithArray:inputArray];
    NSUInteger count = [inputArray count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        
        [outputArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return outputArray;
}


//----------------------------------------------------------------------------------------
#pragma mark GUI functions
//----------------------------------------------------------------------------------------


// Displays the new question
- (void) setQuestionWithAnswers
{
    uint32_t rnd = arc4random_uniform([[[SingleGameManager sharedManager] possibleQuestions] count]);
    NSManagedObject *questionsObject = [[[SingleGameManager sharedManager] possibleQuestions] objectAtIndex:rnd];
    [[SingleGameManager sharedManager] setCurrentQuestion:questionsObject];
    
    NSArray *keyArray = @[@"corr_sol",@"wrong_sol1",@"wrong_sol2",@"wrong_sol3"];
    NSArray *shuffledKeyArray = [self shuffleArray:keyArray];
    
    _questionLabel.text = [questionsObject valueForKey:@"question"];
    [_sol1_button setTitle:[questionsObject valueForKey:shuffledKeyArray[0]] forState:UIControlStateNormal];
    [_sol2_button setTitle:[questionsObject valueForKey:shuffledKeyArray[1]] forState:UIControlStateNormal];
    [_sol3_button setTitle:[questionsObject valueForKey:shuffledKeyArray[2]] forState:UIControlStateNormal];
    [_sol4_button setTitle:[questionsObject valueForKey:shuffledKeyArray[3]] forState:UIControlStateNormal];
    
    _sol1_button.titleLabel.textColor = [UIColor blackColor];
    _sol2_button.titleLabel.textColor = [UIColor blackColor];
    _sol3_button.titleLabel.textColor = [UIColor blackColor];
    _sol4_button.titleLabel.textColor = [UIColor blackColor];
}



- (void) hideQuestion
{
    //TODO: stop timer
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [_questionIV setFrame:CGRectMake(0, _questionIV.frame.origin.y-200, _questionIV.frame.size.width, _questionIV.frame.size.height)];
    [_questionLabel setFrame:CGRectMake(_questionLabel.frame.origin.x, _questionLabel.frame.origin.y-200, _questionLabel.frame.size.width, _questionLabel.frame.size.height)];
    
    [_sol1_IV setFrame:CGRectMake(_sol1_IV.frame.origin.x-400, _sol1_IV.frame.origin.y, _sol1_IV.frame.size.width, _sol1_IV.frame.size.height)];
    //[_sol1_button setFrame:CGRectMake(_sol1_button.frame.origin.x-400, _sol1_button.frame.origin.y, _sol1_button.frame.size.width, _sol1_button.frame.size.height)];
    
    [_sol2_IV setFrame:CGRectMake(_sol2_IV.frame.origin.x+400, _sol2_IV.frame.origin.y, _sol2_IV.frame.size.width, _sol2_IV.frame.size.height)];
    //[_sol2_button setFrame:CGRectMake(_sol2_button.frame.origin.x+400, _sol2_button.frame.origin.y, _sol2_button.frame.size.width, _sol2_button.frame.size.height)];
    
    [_sol3_IV setFrame:CGRectMake(_sol3_IV.frame.origin.x-400, _sol3_IV.frame.origin.y, _sol3_IV.frame.size.width, _sol3_IV.frame.size.height)];
    //[_sol3_button setFrame:CGRectMake(_sol3_button.frame.origin.x-400, _sol3_button.frame.origin.y, _sol3_button.frame.size.width, _sol3_button.frame.size.height)];
    
    [_sol4_IV setFrame:CGRectMake(_sol4_IV.frame.origin.x+400, _sol4_IV.frame.origin.y, _sol4_IV.frame.size.width, _sol4_IV.frame.size.height)];
    //[_sol4_button setFrame:CGRectMake(_sol4_button.frame.origin.x+400, _sol4_button.frame.origin.y, _sol4_button.frame.size.width, _sol4_button.frame.size.height)];
    
    [self performSelector:@selector(showRating) withObject:self afterDelay:1.0];
    
    [UIView commitAnimations];
    
    [_sol1_button setHidden:YES];
    [_sol2_button setHidden:YES];
    [_sol3_button setHidden:YES];
    [_sol4_button setHidden:YES];
}



- (void) showQuestion
{
    //deselect all answers
    [_sol1_IV setImage:[UIImage imageNamed:@"sol_background"]];
    [_sol2_IV setImage:[UIImage imageNamed:@"sol_background"]];
    [_sol3_IV setImage:[UIImage imageNamed:@"sol_background"]];
    [_sol4_IV setImage:[UIImage imageNamed:@"sol_background"]];
    
    //TODO: set question
    [self setQuestionWithAnswers];
    
    //TODO: start timer
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [_questionIV setFrame:CGRectMake(0, _questionIV.frame.origin.y+200, _questionIV.frame.size.width, _questionIV.frame.size.height)];
    [_questionLabel setFrame:CGRectMake(_questionLabel.frame.origin.x, _questionLabel.frame.origin.y+200, _questionLabel.frame.size.width, _questionLabel.frame.size.height)];
    
    [_sol1_IV setFrame:CGRectMake(_sol1_IV.frame.origin.x+400, _sol1_IV.frame.origin.y, _sol1_IV.frame.size.width, _sol1_IV.frame.size.height)];
    //[_sol1_button setFrame:CGRectMake(_sol1_button.frame.origin.x+400, _sol1_button.frame.origin.y, _sol1_button.frame.size.width, _sol1_button.frame.size.height)];
    
    [_sol2_IV setFrame:CGRectMake(_sol2_IV.frame.origin.x-400, _sol2_IV.frame.origin.y, _sol2_IV.frame.size.width, _sol2_IV.frame.size.height)];
    //[_sol2_button setFrame:CGRectMake(_sol2_button.frame.origin.x-400, _sol2_button.frame.origin.y, _sol2_button.frame.size.width, _sol2_button.frame.size.height)];
    
    [_sol3_IV setFrame:CGRectMake(_sol3_IV.frame.origin.x+400, _sol3_IV.frame.origin.y, _sol3_IV.frame.size.width, _sol3_IV.frame.size.height)];
    //[_sol3_button setFrame:CGRectMake(_sol3_button.frame.origin.x+400, _sol3_button.frame.origin.y, _sol3_button.frame.size.width, _sol3_button.frame.size.height)];
    
    [_sol4_IV setFrame:CGRectMake(_sol4_IV.frame.origin.x-400, _sol4_IV.frame.origin.y, _sol4_IV.frame.size.width, _sol4_IV.frame.size.height)];
    //[_sol4_button setFrame:CGRectMake(_sol4_button.frame.origin.x-400, _sol4_button.frame.origin.y, _sol4_button.frame.size.width, _sol4_button.frame.size.height)];
    
    [_sol1_button setHidden:NO];
    [_sol2_button setHidden:NO];
    [_sol3_button setHidden:NO];
    [_sol4_button setHidden:NO];
    
    [UIView commitAnimations];
}



//----------------------------------------------------------------------------------------
#pragma mark View transistions
//----------------------------------------------------------------------------------------


- (void) showRating
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RatingViewController *rating = (RatingViewController*)[storyboard instantiateViewControllerWithIdentifier:@"rating"];    
    [self presentViewController:rating animated:YES completion:nil];
}



//----------------------------------------------------------------------------------------
#pragma mark Button presses
//----------------------------------------------------------------------------------------


- (IBAction)sol1Pressed:(id)sender
{
    [_sol1_IV setImage:[UIImage imageNamed:@"sol_background_selected.png"]];
    [self.view setUserInteractionEnabled:NO];
    [self proceed:sender];
}


- (IBAction)sol2Pressed:(id)sender
{
    [_sol2_IV setImage:[UIImage imageNamed:@"sol_background_selected.png"]];
    [self.view setUserInteractionEnabled:NO];
    [self proceed:sender];
}


- (IBAction)sol3Pressed:(id)sender
{
    [_sol3_IV setImage:[UIImage imageNamed:@"sol_background_selected.png"]];
    [self.view setUserInteractionEnabled:NO];
    [self proceed:sender];
}


- (IBAction)sol4Pressed:(id)sender
{
    [_sol4_IV setImage:[UIImage imageNamed:@"sol_background_selected.png"]];
    [self.view setUserInteractionEnabled:NO];
    [self proceed:sender];
}


@end
