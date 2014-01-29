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
#import "MultiplayerManager.h"

@protocol NetworkManagerServerDelegate <NSObject>
-(void)updateTableView;
-(void)gameHasBeenStarted;
@end

@protocol NetworkManagerClientDelegate <NSObject>
-(void)connectionToServerEstablished;
-(void)connectionToServerAborted;
-(void)gameHasBeenStarted;
@end



@interface NetworkManager : NSObject <ThoMoServerDelegateProtocol, ThoMoClientDelegateProtocol, UITableViewDelegate, UITableViewDataSource>{
}


@property (assign) id<NetworkManagerServerDelegate> serverDelegate;
@property (assign) id<NetworkManagerClientDelegate> clientDelegate;
@property (nonatomic) NSMutableArray *selectedCoursesByHost;
@property (nonatomic) NSMutableArray *selectedCoursesSentToClients;
@property (nonatomic) MultiplayerManager *multiplayerManager;

-(id)initWithRole:(NSString*)role andName:(NSString*)name;
-(void)stopServer;
-(void)stopClient;
-(void)gameWasStarted;
-(void)notifyClientThatGameWasStarted;


@end
