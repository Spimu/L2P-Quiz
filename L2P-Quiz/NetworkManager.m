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
            appDelegate.server = [[ThoMoServerStub alloc] initWithProtocolIdentifier:@"examiner"];
            [appDelegate.server setDelegate:self];
            [appDelegate.server start];
            NSLog(@"%@",@"Server gestartet");
        } else if ([role isEqualToString:@"client"]){
            appDelegate.client = [[ThoMoClientStub alloc] initWithProtocolIdentifier:@"examiner"];
            [appDelegate.client setDelegate:self];
            [appDelegate.client start];
            NSLog(@"%@",@"Client gestartet");
        }

    }
    return self;
}


#pragma Server Delegate Implementations

- (void)server:(ThoMoServerStub *)theServer acceptedConnectionFromClient:(NSString *)aClientIdString {
    NSLog(@"%@", @"Client connected");
    [self.delegate updateTableView];
}

- (void)netServiceProblemEncountered:(NSString *)errorMessage onServer:(ThoMoServerStub *)theServer{
    NSLog(@"Serverfehler entdeckt: %@", errorMessage);
}

-(void)server:(ThoMoServerStub *)theServer didReceiveData:(id)theData fromClient:(NSString *)aClientIdString {
    
}





#pragma Client Delegate Implementations

- (void)client:(ThoMoClientStub *)theClient didConnectToServer:(NSString *)aServerIdString{
    NSLog(@"%@", @"Mit Server verbunden");
}

- (void)netServiceProblemEncountered:(NSString *)errorMessage onClient:(ThoMoClientStub *)theClient {
        NSLog(@"Clientfehler entdeckt: %@", errorMessage);
}

-(void)client:(ThoMoClientStub *)theClient didReceiveData:(id)theData fromServer:(NSString *)aServerIdString {
    
}




#pragma mark TableView Delegate Implementations

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appDelegate.server.connectedClients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [appDelegate.server.connectedClients objectAtIndex:indexPath.row];
    return cell;
}


@end
