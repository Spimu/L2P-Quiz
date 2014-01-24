//
//  NetworkManager.m
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 23.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager {
    
    AppDelegate *appDelegate;
}

- (id)initWithRole:(NSString*)role {
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if ([role isEqualToString:@"server"]) {
            [appDelegate.server start];
            [appDelegate.server setDelegate:self];
        } else if ([role isEqualToString:@"client"]){
            [appDelegate.client start];
            [appDelegate.client setDelegate:self];
        }

    }
    return self;
}

#pragma mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellId];
    }
    //[cell setText:[NSString stringWithFormat:@"e%i",indexPath:[indexPath row]];
     return cell;
     }


#pragma Server Delegate Implementations

- (void)server:(ThoMoServerStub *)theServer acceptedConnectionFromClient:(NSString *)aClientIdString {
    
}

#pragma Client Delegate Implementations



@end
