//
//  SubmitQuestionViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/10/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "SubmitQuestionViewController.h"
#import "UserManager.h"

#define SUBMIT_QUESTIONS_URL @"http://www.spivan.com/l2pquiz/saveQuestion.php"

@interface SubmitQuestionViewController ()

@end

@implementation SubmitQuestionViewController

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
    
    [_activityIndicator setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [_coursePicker reloadAllComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//----------------------------------------------------------------------------------------
#pragma mark Keyboard functions
//----------------------------------------------------------------------------------------


- (void) dismissKeyboard
{
    [_questionTextField resignFirstResponder];
    [_correctAnswerTextField resignFirstResponder];
    [_wrongAnswerTextField1 resignFirstResponder];
    [_wrongAnswerTextField2 resignFirstResponder];
    [_wrongAnswerTextField3 resignFirstResponder];
}



- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



- (void) scrollToY:(float)y
{
    [UIView beginAnimations:@"registerScroll" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];
   
    self.view.transform = CGAffineTransformMakeTranslation(0, y);
    
    [UIView commitAnimations];
    
}



- (void) scrollToView:(UIView *)view
{
    CGRect theFrame = view.frame;
    float y = theFrame.origin.y;
    y -= (y/2.4);
    [self scrollToY:-y];
}



- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [self scrollToView:textField];
}



- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [self scrollToY:0];
    [textField resignFirstResponder];
}


//----------------------------------------------------------------------------------------
#pragma mark Helper functions
//----------------------------------------------------------------------------------------


- (BOOL)checkIfEverythingIsFilled
{
    if (![_questionTextField.text isEqualToString:@""] &&
          ![_correctAnswerTextField.text isEqualToString:@""] &&
          ![_wrongAnswerTextField1.text isEqualToString:@""] &&
          ![_wrongAnswerTextField2.text isEqualToString:@""] &&
          ![_wrongAnswerTextField3.text isEqualToString:@""])
    {
        return YES;
    }
    else
    {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Alzheimer?"
                                   message: @"I think you forgot to fill in a textfield."
                                  delegate: self
                         cancelButtonTitle: @"Oh yeah, you are right!"
                         otherButtonTitles: nil];
        [alert show];
        return NO;
    }
}




//----------------------------------------------------------------------------------------
#pragma mark Picker View Delegates
//----------------------------------------------------------------------------------------


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;// or the number of vertical "columns" the picker will show...
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[[UserManager sharedManager] courses] count];//this will tell the picker how many rows it has - in this case, the size of your loaded array...
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"";
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [tView setTextAlignment:NSTextAlignmentCenter];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:10]];
    }
    
    Course *course = [[[UserManager sharedManager] courses] objectAtIndex:row];
    [tView setText:[course title]];
    
    return tView;
}


//----------------------------------------------------------------------------------------
#pragma mark Button presses
//----------------------------------------------------------------------------------------


- (IBAction)sumbitQuestion:(id)sender
{
    Course *selectedCourse = [[[UserManager sharedManager] courses] objectAtIndex:[_coursePicker selectedRowInComponent:0]];
    NSString *courseString = [selectedCourse identifier];
    
    [self.view setUserInteractionEnabled:NO];
    [_activityIndicator setHidden:NO];
    [_activityIndicator startAnimating];
    
    if ([self checkIfEverythingIsFilled])
    {
        //Here we create the POST-Body-String that we will send to the server
        NSString *dataString = [NSString stringWithFormat:@"course=%@&q=%@&ca=%@&wa1=%@&wa2=%@&wa3=%@", courseString, _questionTextField.text, _correctAnswerTextField.text, _wrongAnswerTextField1.text, _wrongAnswerTextField2.text, _wrongAnswerTextField3.text];
        NSString *finalDataString = [dataString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //Create the session and send our request
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSURL *url = [NSURL URLWithString:SUBMIT_QUESTIONS_URL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPBody = [finalDataString dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPMethod = @"POST";
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil)
            {
                [_questionTextField setText:@""];
                [_correctAnswerTextField setText:@""];
                [_wrongAnswerTextField1 setText:@""];
                [_wrongAnswerTextField2 setText:@""];
                [_wrongAnswerTextField3 setText:@""];
                
                UIAlertView *alert =
                [[UIAlertView alloc] initWithTitle: @"Success!"
                                           message: @"Your question has been submitted successfully!"
                                          delegate: self
                                 cancelButtonTitle: @"OK"
                                 otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert =
                [[UIAlertView alloc] initWithTitle: @"Oops!"
                                           message: @"Something went wrong, please try again! (Do you have an active internet connection?)"
                                          delegate: self
                                 cancelButtonTitle: @"OK"
                                 otherButtonTitles: nil];
                [alert show];
            }
            
            [self.view setUserInteractionEnabled:YES];
            [_activityIndicator setHidden:YES];
            [_activityIndicator stopAnimating];
        }];
        
        [postDataTask resume];
    }
}
@end
