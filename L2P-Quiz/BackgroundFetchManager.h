//
//  BackgroundFetchManager.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/7/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackgroundFetchManager : NSObject

+ (id)sharedManager;

- (void)downloadNewQuestions;

@end
