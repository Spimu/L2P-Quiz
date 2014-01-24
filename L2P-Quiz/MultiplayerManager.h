//
//  Multiplayer.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/23/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiplayerManager : NSObject

@property (nonatomic) NSMutableArray *questionsWithSolutions;
@property (nonatomic) NSArray *tenQuestionIds;
@property (nonatomic) int currentQuestionNumber;

//This function initializes all our properties above
- (void) initializeQuestionsWithCourses:(NSArray *)courses;

//This function returns if the answer was correct, and saves our solution in the questiosnWithSolutions-array
- (BOOL) currentQuestionWasAnsweredCorrectlyWithSolution:(NSString *)solution;

//This function returns an NSManagedObject which contains the next question
- (NSManagedObject *) getNextQuestion;

@end