//
//  GameViewController.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleGameManager.h"

@interface GameViewController : UIViewController
- (IBAction)sol1Pressed:(id)sender;
- (IBAction)sol2Pressed:(id)sender;
- (IBAction)sol3Pressed:(id)sender;
- (IBAction)sol4Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *sol1_IV;
@property (weak, nonatomic) IBOutlet UIImageView *sol2_IV;
@property (weak, nonatomic) IBOutlet UIImageView *sol3_IV;
@property (weak, nonatomic) IBOutlet UIImageView *sol4_IV;

@property (weak, nonatomic) IBOutlet UIButton *sol1_button;
@property (weak, nonatomic) IBOutlet UIButton *sol2_button;
@property (weak, nonatomic) IBOutlet UIButton *sol3_button;
@property (weak, nonatomic) IBOutlet UIButton *sol4_button;

@property (weak, nonatomic) IBOutlet UIImageView *questionIV;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end
