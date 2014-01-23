//
//  SolutionManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/18/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "SolutionManager.h"

@implementation SolutionManager

- (id)init {
    self = [super init];
    if (self) {
        _wrongAnswersInCurrentRound = 0;
        _correctAnswersInCurrentRound = 0;
        _questionsWithSolutions = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void) answeredQuestion:(NSManagedObject*)question withOwnSolution:(NSString*)ownSolution
{
    NSError *error = nil;
    BOOL answeredCorrect = [[question valueForKey:@"corr_sol"] isEqualToString:ownSolution];
    
    
    //Save everything to core data
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    NSManagedObject *statsEntity = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"Stats"
                                       inManagedObjectContext:context];
    [statsEntity setValue:[NSDate date] forKey:@"answerDate"];
    [statsEntity setValue:[NSNumber numberWithBool:answeredCorrect] forKey:@"answered_correct"];

    
    //Link the stats to the question
    NSMutableSet *questionStatsSet = [question valueForKey:@"stats"];
    [questionStatsSet addObject:statsEntity];
    [question setValue:questionStatsSet forKey:@"stats"];
    
    //Link the question to the stats
    [statsEntity setValue:question forKey:@"question"];
    
    //Save and handle errors
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    

    //Add our answer to the questiosnWithSolutions-array
    NSDictionary *tempDict = [[NSDictionary alloc] init];
    tempDict = @{@"question": [question valueForKey:@"question"],
                 @"corr_sol": [question valueForKey:@"corr_sol"],
                 @"own_sol": ownSolution};
    [_questionsWithSolutions addObject:tempDict];
    
    
    //Increment the wrong-/correct-answer
    if (answeredCorrect)
    {
        [self incrementCorrectAnswer];
    }
    else
    {
        [self incrementWrongAnswer];
    }
    
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
