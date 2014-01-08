//
//  BackgroundFetchManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/7/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "BackgroundFetchManager.h"

#define NEW_QUESTIONS_URL @"http://www.spivan.com/l2pquiz/getQuestions.php"

@implementation BackgroundFetchManager

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


- (id)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"Initializing Manager");
        
    }
    return self;
}


- (void)downloadNewQuestions
{
    //New GET-request with the last received questionID as a parameter
    NSString *urlString = [NSString stringWithFormat:@"%@?lastId=%d",NEW_QUESTIONS_URL,2];
    NSURL *weatherURL = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:weatherURL];
    NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}



@end
