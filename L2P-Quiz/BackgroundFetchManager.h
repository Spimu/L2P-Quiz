//
//  BackgroundFetchManager.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/7/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseManager.h"

@interface BackgroundFetchManager : NSObject

@property (nonatomic) int biggestIdParsed;

+ (id)sharedManager;

- (void)downloadNewQuestionsWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void) saveBiggestIdParsed;

@end
