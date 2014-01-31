//
//  GameViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property (nonatomic) SolutionManager *solManager;
@property (nonatomic) UILabel *rightTopLabel;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDate *previousFireDate;
@property (nonatomic) NSDate *pauseStart;

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
    
    [self initSingleGame];
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


- (void) initSingleGame
{
    //Init the solutionmanager
    _solManager = [[SolutionManager alloc] init];
    
    //Get all the questions depending on the courses we selected
    [[SingleGameManager sharedManager] filterAllPossibleQuestions];
    
    //Align all the solutions to the center
    [_sol1_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_sol2_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_sol3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_sol4_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    //Add an "Abort quiz"-button to the top, but only if we are not on the infinity mode
    if ([[SingleGameManager sharedManager] selectedGameMode] != GameMode_Infinity) {
        UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"Abort quiz"
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(backButtonPressed)];
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    //Add either a timer or the answered questions on the right top
    [self addTimerOrAmountOfQuestions];
    
}



- (void) addTimerOrAmountOfQuestions
{
    if ([[SingleGameManager sharedManager] selectedGameMode] == GameMode_10questions)
    {
        _rightTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,400,40)];
        _rightTopLabel.backgroundColor = [UIColor clearColor];
        _rightTopLabel.font = [UIFont boldSystemFontOfSize:16];
        _rightTopLabel.adjustsFontSizeToFitWidth = NO;
        _rightTopLabel.text = @"0/10";
        _rightTopLabel.textAlignment = NSTextAlignmentRight;
        _rightTopLabel.textColor = [UIColor blackColor];
        
        self.navigationItem.titleView = _rightTopLabel;
    }
    
    if ([[SingleGameManager sharedManager] selectedGameMode] == GameMode_1minute)
    {
        _rightTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,400,40)];
        _rightTopLabel.backgroundColor = [UIColor clearColor];
        _rightTopLabel.font = [UIFont boldSystemFontOfSize:16];
        _rightTopLabel.adjustsFontSizeToFitWidth = NO;
        _rightTopLabel.text = @"60";
        _rightTopLabel.textAlignment = NSTextAlignmentRight;
        _rightTopLabel.textColor = [UIColor blackColor];
        
        self.navigationItem.titleView = _rightTopLabel;
        
        [self startTimer];
    }
}



// This function first checks if the user answered right or wrong
// Then it shows the correct answer if the user is not in 1 minute madness mode
// At the end it jumps to the next question
- (void)proceed:(id)sender
{
    //Pause the timer if we are in minute_mode
    if ([[SingleGameManager sharedManager] selectedGameMode] == GameMode_1minute)
    {
        [self pauseTimer:_timer];
    }
    
    
    //Checks if the answer was right
    [self performSelector:@selector(checkIfRight:) withObject:sender afterDelay:1.0];
    
    //Show the next question
    NSTimeInterval delay = 3.0;

    [self performSelector:@selector(hideQuestion) withObject:self afterDelay:delay];
    
    [self.view setUserInteractionEnabled:YES];
}



- (void) checkIfRight:(id)sender
{
    BOOL answerWasCorrect = NO;
    UIButton *senderButton = (UIButton *)sender;
    NSString *correctSolution = [[[SingleGameManager sharedManager] currentQuestion] valueForKey:@"corr_sol"];
    

    //Inform the SolutionManager about the answer
    [_solManager answeredQuestion:[[SingleGameManager sharedManager] currentQuestion] withOwnSolution:senderButton.titleLabel.text];

 
    //Displays the right answer
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



//TODO: check if we are in ?/10-mode and if we reached the last question
- (void) checkIfLastQuestion
{
    if ([[SingleGameManager sharedManager] selectedGameMode] == GameMode_10questions)
    {
        if ([_solManager correctAnswersInCurrentRound] + [_solManager wrongAnswersInCurrentRound] == 10)
        {
            [_timer invalidate];
            [self performSegueWithIdentifier:@"resultSegue" sender:self];
        }
    }
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
    //Check if we reached the last question in ?/10
    [self checkIfLastQuestion];
    
    //Resume if we are in 1min_mode
    if ([[SingleGameManager sharedManager] selectedGameMode] == GameMode_1minute)
    {
        [self resumeTimer:_timer];
    }
    
    //Increment if we are in 10question_mode
    if ([[SingleGameManager sharedManager] selectedGameMode] == GameMode_10questions)
    {
        [_rightTopLabel setText:[NSString stringWithFormat:@"%d/10",(_solManager.wrongAnswersInCurrentRound+_solManager.correctAnswersInCurrentRound)]];
    }
    
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
#pragma mark UIAlert
//----------------------------------------------------------------------------------------


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
        [_timer invalidate];
        
        //TODO: score of -10
    }
}



//----------------------------------------------------------------------------------------
#pragma mark Timer
//----------------------------------------------------------------------------------------


- (void) startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondPassed) userInfo:nil repeats:YES];
}



- (void) secondPassed
{
    if ([_rightTopLabel.text isEqualToString:@"0"])
    {
        [_timer invalidate];
        [self performSegueWithIdentifier:@"resultSegue" sender:self];
    }
    else
    {
        [_rightTopLabel setText:[NSString stringWithFormat:@"%d",[[_rightTopLabel text] integerValue]-1]];
    }
}



-(void) pauseTimer:(NSTimer *)timer
{
    
    _pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
    _previousFireDate = [timer fireDate];
    
    [timer setFireDate:[NSDate distantFuture]];
}



-(void) resumeTimer:(NSTimer *)timer
{
    float pauseTime = -1*[_pauseStart timeIntervalSinceNow];
    [timer setFireDate:[_previousFireDate initWithTimeInterval:pauseTime sinceDate:_previousFireDate]];
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


- (void) backButtonPressed
{
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle: @"Are you sure you want to quit?"
                               message: @"If you quit, you will get a score of -10!"
                              delegate: self
                     cancelButtonTitle: @"Abort"
                     otherButtonTitles: @"Continue playing",nil];
    [alert show];
}



//----------------------------------------------------------------------------------------
#pragma mark Segues
//----------------------------------------------------------------------------------------


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setSolManager:_solManager];
}


@end
