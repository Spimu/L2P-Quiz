//
//  StatsManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 2/2/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "StatsManager.h"

@implementation StatsManager




- (int) numberOfQuestionsAnsweredInCourse:(Course *)course
{
    int counter = 0;
    
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Looking for all the course entities
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName == %@", [course identifier]];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedCourse = [context executeFetchRequest:fetchRequest error:&error];
    NSSet *questions = [fetchedCourse[0] valueForKeyPath:@"questions"];
    
    for (NSManagedObject *question in questions)
    {
        NSSet *stats = [question valueForKeyPath:@"stats"];
        counter += [stats count];
    }
    
    return counter;
}


- (int) numberOfQuestionsAnsweredCorrectlyInCourse:(Course *)course
{
    int counter = 0;
    
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Looking for all the course entities
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName == %@", [course identifier]];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedCourse = [context executeFetchRequest:fetchRequest error:&error];
    NSSet *questions = [fetchedCourse[0] valueForKeyPath:@"questions"];
    
    for (NSManagedObject *question in questions)
    {
        NSSet *stats = [question valueForKeyPath:@"stats"];
        
        for (NSManagedObject *stat in stats) {
            NSNumber *answeredCorrect = [stat valueForKey:@"answered_correct"];
            if ([answeredCorrect boolValue]) {
                counter++;
            }
        }
    }
    
    return counter;
}







- (int) numberOfQuestionsAnsweredOnDate:(NSDate *)date inCourse:(Course *)course
{
    
    int counter = 0;
    
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Looking for all the course entities
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName == %@", [course identifier]];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedCourse = [context executeFetchRequest:fetchRequest error:&error];
    NSSet *questions = [fetchedCourse[0] valueForKeyPath:@"questions"];
    
    for (NSManagedObject *question in questions)
    {
        NSSet *stats = [question valueForKeyPath:@"stats"];
        for (NSManagedObject *stat in stats) {
            if ([stat valueForKey:@"answered_correct"] == date) {
                counter++;
            }
        }
    }
    
    return counter;
}


- (int) numberOfQuestionsAnsweredCorrectlyOnDate:(NSDate *)date inCourse:(Course *)course
{
    int counter = 0;
    
    NSError *error = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Looking for all the course entities
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName == %@", [course identifier]];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedCourse = [context executeFetchRequest:fetchRequest error:&error];
    NSSet *questions = [fetchedCourse[0] valueForKeyPath:@"questions"];
    
    for (NSManagedObject *question in questions)
    {
        NSSet *stats = [question valueForKeyPath:@"stats"];
        
        for (NSManagedObject *stat in stats) {
            NSNumber *answeredCorrect = [stat valueForKey:@"answered_correct"];
            if ([answeredCorrect boolValue] && ([stat valueForKey:@"answered_correct"] == date)) {
                counter++;
            }
        }
    }
    
    return counter;
}




@end
