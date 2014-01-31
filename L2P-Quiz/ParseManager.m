//
//  ParseManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/9/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "ParseManager.h"

@implementation ParseManager

//This method gets a json-string of all the new questions.
//First it parses the string, after that, it places everything into core data
- (BOOL)parseData:(NSData*)data withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSError *error = nil;

    NSString *stringToParse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //If we don't have any new questions, return NO
    if ([stringToParse isEqualToString:@""]) {
        return NO;
    }
    
    //If we have new questions, we parse them, and save them into core data
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *questionsArray = [dict objectForKey:@"questions"];
    for (NSDictionary *questionDict in questionsArray) {
        
        //Parse...
        NSInteger identity = [[questionDict objectForKey:@"id"] integerValue];
        NSString *course = [questionDict objectForKey:@"course"];
        NSString *question = [questionDict objectForKey:@"question"];
        NSString *corr_sol = [questionDict objectForKey:@"corr_sol"];
        NSString *wrong_sol1 = [questionDict objectForKey:@"wrong_sol1"];
        NSString *wrong_sol2 = [questionDict objectForKey:@"wrong_sol2"];
        NSString *wrong_sol3 = [questionDict objectForKey:@"wrong_sol3"];
        
        //... and store
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        
        //1) course
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        // Looking for all the course entities
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        // The courseName should be the one we are looking for
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(courseName LIKE[c] %@)", course];
        [fetchRequest setPredicate:predicate];
        
        //Look if the course already exists
        NSArray *fetchedCourses = [context executeFetchRequest:fetchRequest error:&error];
        NSManagedObject *courseEntity;
        if ([fetchedCourses count] == 0)
        {
            courseEntity = [NSEntityDescription
                                               insertNewObjectForEntityForName:@"Courses"
                                               inManagedObjectContext:context];
            [courseEntity setValue:course forKey:@"courseName"];
            [courseEntity setValue:@"theCourseIdentifier" forKey:@"courseIdentifier"];
            
        }
        else
        {
            courseEntity = [fetchedCourses objectAtIndex:0];
        }
        
        //2) the question
        NSManagedObject *questionEntity = [NSEntityDescription
                                           insertNewObjectForEntityForName:@"Question"
                                           inManagedObjectContext:context];
        [questionEntity setValue:[NSNumber numberWithInteger:identity] forKey:@"identity"];
        [questionEntity setValue:question forKey:@"question"];
        [questionEntity setValue:corr_sol forKey:@"corr_sol"];
        [questionEntity setValue:wrong_sol1 forKey:@"wrong_sol1"];
        [questionEntity setValue:wrong_sol2 forKey:@"wrong_sol2"];
        [questionEntity setValue:wrong_sol3 forKey:@"wrong_sol3"];
        
        //Link the course to the question
        NSMutableSet *courseQuestionsSet = [courseEntity valueForKey:@"questions"];
        [courseQuestionsSet addObject:questionEntity];
        [courseEntity setValue:courseQuestionsSet forKey:@"questions"];
        
        //Link the question to the course
        [questionEntity setValue:courseEntity forKey:@"course"];
        
        //Save and handle errors
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        //TODO: remove
        [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
        
        //Save the id of last question that has been saved
        if ([[BackgroundFetchManager sharedManager] biggestIdParsed] < identity) {
            [[BackgroundFetchManager sharedManager] setBiggestIdParsed:identity];
            [[BackgroundFetchManager sharedManager] saveBiggestIdParsed];
        }
    }

    return YES;
}



@end
