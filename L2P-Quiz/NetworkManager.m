//
//  NetworkManager.m
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 23.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#define tellMeyourName 1

#import "NetworkManager.h"

@implementation NetworkManager {
    
    AppDelegate *appDelegate;
    NSMutableDictionary *clients;
    NSString *playerName;
}

- (id)initWithRole:(NSString*)role andName:(NSString*)name {
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        clients = [[NSMutableDictionary alloc] init];
        
        playerName = name;
        
        if ([role isEqualToString:@"server"]) {
            appDelegate.server = [[ThoMoServerStub alloc] initWithProtocolIdentifier:@"examiner"];
            [appDelegate.server setDelegate:self];
            [appDelegate.server start];
            NSLog(@"%@",@"Server started");
        } else if ([role isEqualToString:@"client"]){
            appDelegate.client = [[ThoMoClientStub alloc] initWithProtocolIdentifier:@"examiner"];
            [appDelegate.client setDelegate:self];
            [appDelegate.client start];
            NSLog(@"%@",@"Client started");
        }

    }
    return self;
}


#pragma Server Delegate Implementations

- (void)server:(ThoMoServerStub *)theServer acceptedConnectionFromClient:(NSString *)aClientIdString {
    NSLog(@"%@", @"Client connected");
    
    NSLog(@"%@", @"Sag mir deinen Namen!");
   NSMutableDictionary *command = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"-",@"tellMeYourName", nil];
   [appDelegate.server send:command toClient:aClientIdString];
    [self.serverDelegate updateTableView];
}

- (void)server:(ThoMoServerStub *)theServer lostConnectionToClient:(NSString *)aClientIdString errorMessage:(NSString *)errorMessage {
    [self.serverDelegate updateTableView];
}


- (void)netServiceProblemEncountered:(NSString *)errorMessage onServer:(ThoMoServerStub *)theServer{
    NSLog(@"Error on server: %@", errorMessage);
}

-(void)server:(ThoMoServerStub *)theServer didReceiveData:(id)theData fromClient:(NSString *)aClientIdString {

}

- (void)serverDidShutDown:(ThoMoServerStub *)theServer{
    [self.clientDelegate connectionToServerAborted];
}



#pragma Client Delegate Implementations

- (void)client:(ThoMoClientStub *)theClient didConnectToServer:(NSString *)aServerIdString{
    [self.clientDelegate connectionToServerEstablished];
    NSLog(@"%@", @"Client connected to server");
    
}

- (void)client:(ThoMoClientStub *)theClient didDisconnectFromServer:(NSString *)aServerIdString errorMessage:(NSString *)errorMessage{
    [self.clientDelegate connectionToServerAborted];
    NSLog(@"%@", @"Client disconnected from server");
}


- (void)clientDidShutDown:(ThoMoClientStub *)theClient {
    [self.clientDelegate connectionToServerAborted];
}

- (void)netServiceProblemEncountered:(NSString *)errorMessage onClient:(ThoMoClientStub *)theClient {
        NSLog(@"Error on client: %@", errorMessage);
}

-(void)client:(ThoMoClientStub *)theClient didReceiveData:(id)theData fromServer:(NSString *)aServerIdString {
    NSMutableDictionary *test = theData;
    

    NSString *bla = [[test allKeys]objectAtIndex:0];
    if ([bla isEqualToString:@"tellMeYourName"]) {
        NSLog(@"%@", @"My name is Michael");
    }
    
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

#pragma mark Easy ThoMo Actions

-(void)stopServer{
    [appDelegate.server stop];
    NSLog(@"%@", @"Server shut down");
    
}

-(void)stopClient{
    [appDelegate.client stop];
    NSLog(@"%@", @"Client shut down");
}


@end
