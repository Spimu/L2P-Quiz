//
//  GameCenterManager.h
//  L2P-Quiz
//
//  Created by Michael Bertenburg on 18.01.14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameCenterManagerDelegate <NSObject>
@optional
//- (void) processGameCenterAuth: (NSError*) error;
@end

@interface GameCenterManager : NSObject
{
    id <GameCenterManagerDelegate, NSObject> delegate;
}

@property (nonatomic, readonly) NSError* lastError;
@property (nonatomic, assign)  id <GameCenterManagerDelegate> delegate;

+ (BOOL) isGameCenterAvailable;
- (void) authenticateLocalPlayer;

@end
