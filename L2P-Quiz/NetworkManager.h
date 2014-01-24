//
//  NetworkManager.h
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 23.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <ThoMoNetworking/ThoMoNetworking.h>


@interface NetworkManager : NSObject <ThoMoServerDelegateProtocol, ThoMoClientDelegateProtocol, UITableViewDelegate, UITableViewDataSource>

-(id)initWithRole:(NSString*)role;


@end
