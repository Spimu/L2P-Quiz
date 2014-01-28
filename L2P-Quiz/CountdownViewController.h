//
//  CountdownViewController.h
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 27.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CountdownViewController : UIViewController {
    NSTimer *timer;
    int time;
}

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;



@end
