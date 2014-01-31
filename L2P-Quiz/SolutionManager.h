//
//  SolutionManager.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/18/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//
//  This manager should take care of all the answers the user gives
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UserManager.h"

@interface SolutionManager : NSObject

@property (nonatomic) int correctAnswersInCurrentRound;
@property (nonatomic) int wrongAnswersInCurrentRound;
@property (nonatomic) NSMutableArray *questionsWithSolutions;

- (void) answeredQuestion:(NSManagedObject*)question withOwnSolution:(NSString*)ownSolution;

@end
