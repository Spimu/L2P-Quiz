//
//  SingleGameManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "SingleGameManager.h"
#import "Course.h"

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




- (void) filterAllPossibleQuestions
{
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Looking for all the course entities
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Filter all the courses we selected
    NSMutableArray *tempSelectedCourses = [[NSMutableArray alloc] init];
    for (Course *course in _selectedCourses) {
        [tempSelectedCourses addObject:[course identifier]];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName IN %@", tempSelectedCourses];
    [fetchRequest setPredicate:predicate];
    
    //Get all the possible questions and save them in our singlegamemanager
    NSArray *fetchedCourses = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableSet *questions = [[NSMutableSet alloc] init];
    for (NSManagedObject *course in fetchedCourses)
    {
        NSSet *set = [course valueForKeyPath:@"questions"];
        [questions unionSet:set];
    }
    
    _possibleQuestions = [questions allObjects];
}


@end
