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
@property (nonatomic) int numberOfCorrectSolutions;

// This function initializes all our properties above
// !! THIS FUNCTION IS USED BY THE HOST !!
- (void) initializeQuestionsWithCourses:(NSArray *)courses;

// This function initializes all our properties above
// !! THIS FUNCTION IS USED BY THE CLIENT !!
- (void) initializeQuestionsWithTenQuestionArray:(NSArray *)arrayThatContainsTenQuestionIds;

//This function returns if the answer was correct, and saves our solution in the questiosnWithSolutions-array
- (BOOL) currentQuestionWasAnsweredCorrectlyWithSolution:(NSString *)solution;

//This function returns an NSManagedObject which contains the next question
- (NSManagedObject *) getNextQuestion;

@end
