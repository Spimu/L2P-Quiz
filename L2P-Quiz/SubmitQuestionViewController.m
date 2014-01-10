//
//  SubmitQuestionViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/10/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "SubmitQuestionViewController.h"

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
	
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [_questionTextField resignFirstResponder];
    [_correctAnswerTextField resignFirstResponder];
    [_wrongAnswerTextField1 resignFirstResponder];
    [_wrongAnswerTextField2 resignFirstResponder];
    [_wrongAnswerTextField3 resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


-(void)scrollToY:(float)y
{
    
    [UIView beginAnimations:@"registerScroll" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];
    self.view.transform = CGAffineTransformMakeTranslation(0, y);
    [UIView commitAnimations];
    
}

-(void)scrollToView:(UIView *)view
{
    CGRect theFrame = view.frame;
    float y = theFrame.origin.y;
    y -= (y/1.7);
    [self scrollToY:-y];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self scrollToView:textField];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    [self scrollToY:0];
    [textField resignFirstResponder];
}

- (BOOL)checkIfEverythingIsFilled
{
    if (![_questionTextField.text isEqualToString:@""] &&
          ![_correctAnswerTextField.text isEqualToString:@""] &&
          ![_wrongAnswerTextField1.text isEqualToString:@""] &&
          ![_wrongAnswerTextField2.text isEqualToString:@""] &&
          ![_wrongAnswerTextField3.text isEqualToString:@""]) {
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


- (IBAction)sumbitQuestion:(id)sender
{
    if ([self checkIfEverythingIsFilled])
    {
        //TODO: Modify the following POST-request
        //IMPORTANT: WE STILL NEED TO KNOW HOW EVERY STUDENT CAN BE IDENTIFIED... ID? EMAIL? -> Lab on monday
        
        /*
        //Here we create the POST-Body-String that we will send to the server
        NSString *dataString = [NSString stringWithFormat:@"lastId=%d&courses=%@", _biggestIdParsed, coursesJsonString];
        
        //Create the session and send our request
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSURL *url = [NSURL URLWithString:NEW_QUESTIONS_URL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPBody = [completeDataString dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPMethod = @"POST";
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil)
            {
                //Parse the JSON-String that has been returned
                ParseManager *parseManager = [[ParseManager alloc] init];
                BOOL newUpdates = [parseManager parseData:data withCompletionHandler:completionHandler];
                
                //Update our fetch result and call the completion handler
                UIBackgroundFetchResult result = UIBackgroundFetchResultNoData;
                if(newUpdates) {
                    result = UIBackgroundFetchResultNewData;
                }
                completionHandler(result);
            }
        }];
        [postDataTask resume];
         */
    }
}
@end
