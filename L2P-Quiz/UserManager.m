//
//  UserManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/25/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

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



- (id)init {
    self = [super init];
    
    if (self)
    {
        [self restore];
    }
    
    return self;
}



- (void) save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:_userScore] forKey:@"score"];
    [defaults setObject:[NSNumber numberWithInt:_duelsLost] forKey:@"duelsLost"];
    [defaults setObject:[NSNumber numberWithInt:_duelsWon] forKey:@"duelsWon"];
    if (_courses != nil && [_courses count] != 0) {
        NSData *courseData = [NSKeyedArchiver archivedDataWithRootObject:_courses];
        [defaults setObject:courseData forKey:@"courses"];
    }
    [defaults synchronize];
}



- (void) restore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"score"])
    {
        _userScore = 0;
    }
    else
    {
        _userScore = [[defaults objectForKey:@"score"] integerValue];
    }
    
    
    if (![defaults objectForKey:@"duelsLost"])
    {
        _duelsLost = 0;
    }
    else
    {
        _duelsLost = [[defaults objectForKey:@"duelsLost"] integerValue];
    }
    
    
    if (![defaults objectForKey:@"duelsWon"])
    {
        _duelsWon = 0;
    }
    else
    {
        _duelsWon = [[defaults objectForKey:@"duelsWon"] integerValue];
    }
    
    if (![defaults objectForKey:@"courses"])
    {
        _courses = [[NSMutableArray alloc] init];
    }
    else
    {
        NSData *coursesData = [defaults objectForKey:@"courses"];
        _courses = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:coursesData]];
    }
    
}






@end
