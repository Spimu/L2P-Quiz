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
    NSMutableDictionary *allClientsScores;
    NSString *serverID;
    NSNumber * hostScore;
}

- (id)initWithRole:(NSString*)role andName:(NSString*)name {
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        clients = [[NSMutableDictionary alloc] init];
        
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
    playerName =  @"Opponent";
    allClientsScores = [[NSMutableDictionary alloc]init];
    return self;
}


#pragma Server Delegate Implementations

- (void)server:(ThoMoServerStub *)theServer acceptedConnectionFromClient:(NSString *)aClientIdString {
    
    NSMutableDictionary *command = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"-",@"tellMeYourName", nil];
    [appDelegate.server send:command toClient:aClientIdString];
    
    
    [clients setObject:playerName forKey:aClientIdString];
    [self.serverDelegate updateTableView];
}

- (void)server:(ThoMoServerStub *)theServer lostConnectionToClient:(NSString *)aClientIdString errorMessage:(NSString *)errorMessage {
    [clients removeObjectForKey:aClientIdString];
    [self.serverDelegate updateTableView];
    
}

- (void)netServiceProblemEncountered:(NSString *)errorMessage onServer:(ThoMoServerStub *)theServer{
    NSLog(@"Error on server: %@", errorMessage);
}

- (void)serverDidShutDown:(ThoMoServerStub *)theServer{
    [self.clientDelegate connectionToServerAborted];
}

-(void)server:(ThoMoServerStub *)theServer didReceiveData:(id)theData fromClient:(NSString *)aClientIdString {
    NSMutableDictionary *commands = theData;
    
    NSString *command = [[commands allKeys]objectAtIndex:0];
    if ([command isEqualToString:@"myName"]) {
        playerName = [commands objectForKey:@"myName"];
        [clients setObject:playerName forKey:aClientIdString];
        [self.serverDelegate updateTableView];
        
    } else if ([command isEqualToString:@"myScore"]) {
        [allClientsScores setObject:[commands objectForKey:@"myScore"] forKey:playerName];
        
        NSSet *set1 = [NSSet setWithArray:[clients allValues]];
        NSSet *set2 = [NSSet setWithArray:[allClientsScores allKeys]];
        
        if ([set1 isEqualToSet:set2]) {
            if ([allClientsScores objectForKey:[[UIDevice currentDevice] name]] == nil) {
                [allClientsScores setObject:hostScore forKey:[[UIDevice currentDevice] name]];
            }
            
            NSMutableDictionary *command = [[NSMutableDictionary alloc]initWithObjectsAndKeys:allClientsScores,@"updateYourScore", nil];
            [appDelegate.server sendToAllClients:command];
            
            [self.scoreDelegate scoresHaveBeenComputed:allClientsScores];
        }
    }
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
    NSMutableDictionary *commands = theData;
    serverID = aServerIdString;
    NSString *command = [[commands allKeys]objectAtIndex:0];
    
    if ([command isEqualToString:@"tellMeYourName"]) {
        NSMutableDictionary *clientreplies = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[UIDevice currentDevice] name],@"myName", nil];
        [appDelegate.client send:clientreplies toServer:aServerIdString];
        
    } else if ([command isEqualToString:@"gameStarts"]){
        
        _multiplayerManager = [[MultiplayerManager alloc] init];
        [_multiplayerManager initializeQuestionsWithTenQuestionArray:[commands objectForKey:@"gameStarts"]];
        [self.clientDelegate gameHasBeenStarted];
        
    } else if ([command isEqualToString:@"updateYourScore"]){
        
        [self.scoreDelegate scoresHaveBeenComputed:[commands objectForKey:@"updateYourScore"]];
        
    }
}

#pragma mark NetworkManager Methods Implementation

-(void)stopServer{
    if (appDelegate.server){
        [appDelegate.server stop];
        appDelegate.server = nil;
        NSLog(@"%@", @"Server shut down");
    }
}

-(void)stopClient{
    
    if (appDelegate.client){
        [appDelegate.client stop];
        appDelegate.client = nil;
        NSLog(@"%@", @"Client shut down");
    }
    
}

-(void)gameWasStarted {
    
    [self.serverDelegate gameHasBeenStarted];
    
}

//-(BOOL)didAllClientsSendTheirScore {
//    NSSet *set1 = [NSSet setWithArray:[clients allValues]];
//    NSSet *set2 = [NSSet setWithArray:[allClientsScores allKeys]];
//
//    if ([set1 isEqualToSet:set2]) {
//        return true;
//    }
//
//    return false;
//}

-(void)notifyClientThatGameWasStarted {
    _multiplayerManager = [[MultiplayerManager alloc]init];
    [_multiplayerManager initializeQuestionsWithCourses:_selectedCoursesByHost];
    
    NSArray *arrayToSend = [_multiplayerManager tenQuestionIds];
    
    NSMutableDictionary *command = [[NSMutableDictionary alloc]initWithObjectsAndKeys:arrayToSend,@"gameStarts", nil];
    [appDelegate.server sendToAllClients:command];
}

-(void)sendScoreToHost:(NSNumber*)score {
    
    if (appDelegate.server != nil) {
        hostScore = score;
    }
    
    if([appDelegate.server connectedClients].count ==0 && appDelegate.server) {
        if ([allClientsScores objectForKey:[[UIDevice currentDevice] name]] == nil) {
            [allClientsScores setObject:hostScore forKey:[[UIDevice currentDevice] name]];
        }
        [self.scoreDelegate scoresHaveBeenComputed:allClientsScores];
    } else {
        
        NSMutableDictionary *command = [[NSMutableDictionary alloc]initWithObjectsAndKeys:score,@"myScore", nil];
        [appDelegate.client send:command toServer:serverID];
        
    }
}

#pragma mark TableView Delegate Implementations

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [clients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *key = [clients allKeys][indexPath.row];
    
    NSString *providerNameString = clients[key];
    NSString *providerIdString = key;
    cell.textLabel.text  = providerNameString;
    cell.detailTextLabel.text  = providerIdString;
    
    return cell;
}




@end
