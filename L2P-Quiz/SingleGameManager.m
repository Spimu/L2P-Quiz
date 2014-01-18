//
//  SingleGameManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "SingleGameManager.h"

@interface SingleGameManager()

@end


@implementation SingleGameManager

//Singleton
+ (id)sharedManager
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}



- (void) incrementCorrectAnswer
{
    _correctAnswersInCurrentRound += 1;
}



- (void) incrementWrongAnswer
{
    _wrongAnswersInCurrentRound += 1;
}

@end
