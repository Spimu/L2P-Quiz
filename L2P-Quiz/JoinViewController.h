//
//  JoinViewController.h
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 22.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ThoMoNetworking/ThoMoNetworking.h>

@interface JoinViewController : UIViewController <ThoMoClientDelegateProtocol> {
    ThoMoClientStub	*client;
}

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinGameButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end
