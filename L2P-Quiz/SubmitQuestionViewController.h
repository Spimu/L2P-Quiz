//
//  SubmitQuestionViewController.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/10/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitQuestionViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (weak, nonatomic) IBOutlet UITextField *correctAnswerTextField;
@property (weak, nonatomic) IBOutlet UITextField *wrongAnswerTextField1;
@property (weak, nonatomic) IBOutlet UITextField *wrongAnswerTextField2;
@property (weak, nonatomic) IBOutlet UITextField *wrongAnswerTextField3;
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)sumbitQuestion:(id)sender;

@end
