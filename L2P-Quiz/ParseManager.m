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
        NSManagedObject *questionEntity = [NSEntityDescription
                                           insertNewObjectForEntityForName:@"Question"
                                           inManagedObjectContext:context];
        [questionEntity setValue:[NSNumber numberWithInteger:identity] forKey:@"identity"];
        [questionEntity setValue:course forKey:@"course"];
        [questionEntity setValue:question forKey:@"question"];
        [questionEntity setValue:corr_sol forKey:@"corr_sol"];
        [questionEntity setValue:wrong_sol1 forKey:@"wrong_sol1"];
        [questionEntity setValue:wrong_sol2 forKey:@"wrong_sol2"];
        [questionEntity setValue:wrong_sol3 forKey:@"wrong_sol3"];
        
        //Save and handle errors
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        //Save the id of last question that has been saved
        if ([[BackgroundFetchManager sharedManager] biggestIdParsed] < identity) {
            [[BackgroundFetchManager sharedManager] setBiggestIdParsed:identity];
            [[BackgroundFetchManager sharedManager] saveBiggestIdParsed];
        }
    }

    return YES;
}


@end
