//
//  StatsManager.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 2/2/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Course.h"

@interface StatsManager : NSObject

/* GET THE DAY OF YESTERDAY FOR EXAMPLE
 NSDateComponents *componentsToSubtract = [[[NSDateComponents alloc] init] autorelease];
 [componentsToSubtract setDay:-1];
 
 NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
 */

@property (nonatomic, strong) Course *currentCourse;

+ (id)sharedManager;

- (int) numberOfQuestionsAnsweredInCourse:(Course *)course;
- (int) numberOfQuestionsAnsweredCorrectlyInCourse:(Course *)course;

- (int) numberOfQuestionsAnsweredOnDate:(NSDate *)date inCourse:(Course *)course;
- (int) numberOfQuestionsAnsweredCorrectlyOnDate:(NSDate *)date inCourse:(Course *)course;



@end
