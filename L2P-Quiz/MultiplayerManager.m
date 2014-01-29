//
//  Multiplayer.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/23/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "MultiplayerManager.h"
#import "AppDelegate.h"

@implementation MultiplayerManager



- (void) initializeQuestionsWithCourses:(NSArray *)courses
{
    //Initialize the starting questoinNumber
    _currentQuestionNumber = 0;
    
    //Initalize our solutionArray
    _questionsWithSolutions = [[NSMutableArray alloc] init];
    
    //Initialize our array that contains the 10 questions
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Looking for all the course entities
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Filter all the courses we selected
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName IN %@", courses];
    [fetchRequest setPredicate:predicate];
    
    //Get all the possible questions
    NSArray *fetchedCourses = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableSet *questions = [[NSMutableSet alloc] init];
    for (NSManagedObject *course in fetchedCourses)
    {
        NSSet *set = [course valueForKeyPath:@"questions"];
        [questions unionSet:set];
    }
    
    //get the number of available questions
    NSArray *allQuestions = [questions allObjects];
    
    NSMutableArray *tenQuestions = [[NSMutableArray alloc] init];
    
    //Save the 10 questions to our array
    for (int i = 0; i < 10; i++)
    {
        int randomQuestionNumber = arc4random_uniform([allQuestions count]);
        
        NSManagedObject *tempQuestion = allQuestions[randomQuestionNumber];
        
        [tenQuestions addObject:[NSNumber numberWithInt:[[tempQuestion valueForKey:@"identity"] integerValue]]];
    }
    
    _tenQuestionIds = tenQuestions;
}



- (void) initializeQuestionsWithTenQuestionArray:(NSArray *)arrayThatContainsTenQuestionIds
{
    //Initialize the starting questoinNumber
    _currentQuestionNumber = 0;
    
    //Initalize our solutionArray
    _questionsWithSolutions = [[NSMutableArray alloc] init];
    
    // Initialize our tenQuestionIdArray
    _tenQuestionIds = [NSArray arrayWithArray:arrayThatContainsTenQuestionIds];
}




- (BOOL) currentQuestionWasAnsweredCorrectlyWithSolution:(NSString*)solution
{
    //Get the questionId
    int questionID = [_tenQuestionIds[_currentQuestionNumber] integerValue];
    
    NSManagedObject *question = [self getQuestionsById:questionID];
    
    //Add our answer to the questiosnWithSolutions-array
    NSDictionary *tempDict = [[NSDictionary alloc] init];
    tempDict = @{@"question": [question valueForKey:@"question"],
                 @"corr_sol": [question valueForKey:@"corr_sol"],
                 @"own_sol": solution};
    [_questionsWithSolutions addObject:tempDict];
    
    //Increment the questionNumber
    _currentQuestionNumber++;
    
    //Check if the answer was correct
    if ([[tempDict valueForKey:@"own_sol"] isEqualToString:[tempDict valueForKey:@"corr_sol"]])
    {
        return YES;
    }
    
    NSLog(@"QuestionNumber: %d",_currentQuestionNumber);

    return NO;
}





- (NSManagedObject *) getNextQuestion
{
    //Get the questionId
    int questionID = [_tenQuestionIds[_currentQuestionNumber] integerValue];
    
    return [self getQuestionsById:questionID];
}




- (NSManagedObject *) getQuestionsById:(int)ident
{
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Looking for all the question entities
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Question" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Filter the id we selected
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identity == %d", ident];
    [fetchRequest setPredicate:predicate];
    
    //Get our question
    NSArray *fetchedQuestions = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedQuestions[0];
}




@end
