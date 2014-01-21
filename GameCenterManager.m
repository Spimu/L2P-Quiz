//
//  GameCenterManager.m
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 18.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "GameCenterManager.h"
#import "GameKit/GameKit.h"

@implementation GameCenterManager

- (id) init
{
	self = [super init];
	if(self!= NULL)
	{
        
	}
	return self;
}

+ (BOOL) isGameCenterAvailable
{
	// check for presence of GKLocalPlayer API
	Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
	
	// check if the device is running iOS 4.1 or later
	NSString *reqSysVer = @"4.1";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	
	return (gcClass && osVersionSupported);
}

-(void) setLastError:(NSError*)error {
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@", [[_lastError userInfo]
                                           description]);
    }
}


-(void) authenticateLocalPlayer {
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    } else {
        NSLog(@"Already authenticated!");
    }

    
    //iOS 7 Code, not working yet
//    
//    GKLocalPlayer* localPlayer =
//    [GKLocalPlayer localPlayer];
//    
//    localPlayer.authenticateHandler =
//    ^(UIViewController *viewController,
//      NSError *error) {
//        
//        [self setLastError:error];
//        
//        if (localPlayer.authenticated) {
//            //gameCenterFeaturesEnabled = YES;
//        } else {
//            //gameCenterFeaturesEnabled = NO;
//        }
//        
//    };
}

@end
