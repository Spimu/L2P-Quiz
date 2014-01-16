//
//  Courses.h
//  L2P-Quiz
//
//  Created by Marty Pye on 16/01/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Courses : NSObject

+ (Courses*) sharedCourses;
- (NSNumber*) totalAmountOfCourses;
- (NSArray*) listCourseNames;

@end
