//
//  AppDelegate.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/7/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

@class NetworkManager;

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "BackgroundFetchManager.h"
#import <ThoMoNetworking/ThoMoNetworking.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) ThoMoClientStub *client;
@property (nonatomic, retain) ThoMoServerStub *server;
@property (nonatomic) NetworkManager *networkManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end