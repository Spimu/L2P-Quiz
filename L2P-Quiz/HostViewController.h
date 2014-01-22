//
//  HostViewController.h
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 22.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ThoMoNetworking/ThoMoNetworking.h>

@interface HostViewController : UIViewController <ThoMoServerDelegateProtocol, UITableViewDelegate, UITableViewDataSource>
{
    ThoMoServerStub	*server;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end
