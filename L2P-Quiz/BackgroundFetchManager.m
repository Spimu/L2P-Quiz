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
        
        //Do further initializations right here
        
    }
    return self;
}


- (void)downloadNewQuestionsWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //New GET-request with the last received questionID as a parameter
    NSString *urlString = [NSString stringWithFormat:@"%@?lastId=%d",NEW_QUESTIONS_URL,10];
    NSURL *downloadURL = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:downloadURL];
    
    //Parse the JSON-String that has been returned
    ParseManager *parseManager = [[ParseManager alloc] init];
    BOOL newUpdates = [parseManager parseData:data withCompletionHandler:completionHandler];
    
    //Update our fetch result and call the completion handler
    UIBackgroundFetchResult result = UIBackgroundFetchResultNoData;
    if(newUpdates) {
        result = UIBackgroundFetchResultNewData;
    }
    completionHandler(result);
    
}



@end
