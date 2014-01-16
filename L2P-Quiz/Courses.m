//
//  Courses.m
//  L2P-Quiz
//
//  Created by Marty Pye on 16/01/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "Courses.h"


// TODO: this class should contain a list of the courses the student is subsribed to.
// e.g. ["DIS I", "DISII", "iPhone Programming"]
// @Emil: This should be read from the L2P, and maybe stored in a singleton?! In that case
// we could always just readout the courses from anywhere.

@interface Courses() {
    NSMutableArray *courses;
}

+ (Courses*) sharedCourses;

@end


@implementation Courses

- (id) init
{
    self = [super init];
    if (self != nil) {
        courses = [[NSMutableArray alloc] init];
        // TODO: fill courses with courses from L2P
        
        // some dummy courses
        [courses addObject:@"Course A"];
        [courses addObject:@"Course B"];
        [courses addObject:@"Course C"];
        
    }
    return self;
}

// ----------------------------------------------------------------------------------------------------
// Singleton
// ----------------------------------------------------------------------------------------------------
+ (Courses*) sharedCourses
{
    static Courses *sharedCourses;
    
    @synchronized(self)
    {
        if (!sharedCourses) {
            sharedCourses = [[Courses alloc] init];
        }
        
        return sharedCourses;
    }
}

// ----------------------------------------------------------------------------------------------------
// Returns total amount of courses
// ----------------------------------------------------------------------------------------------------
- (NSNumber*) totalAmountOfCourses;
{
    return [NSNumber numberWithInteger:courses.count];
}

// ----------------------------------------------------------------------------------------------------
// Returns an array with the course names
// ----------------------------------------------------------------------------------------------------
- (NSArray*) listCourseNames;
{
    NSArray* names = [[NSArray alloc] initWithArray:courses];
    return names;
}





@end
