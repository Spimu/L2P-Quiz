//
//  SingleGameManager.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GameMode) {
    GameMode_1minute,
    GameMode_10questions,
    GameMode_Infinity
};

@interface SingleGameManager : NSObject

+ (id)sharedManager;

@property (nonatomic) NSInteger selectedGameMode;
@property (nonatomic) NSMutableArray *selectedCourses;
@property (nonatomic) NSArray *possibleQuestions;

@end
