//
//  BackgroundFetchManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/7/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "BackgroundFetchManager.h"
#import "UserManager.h"
#import "Course.h"

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
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"biggestIdParsed"] != nil) {
            [self restoreBiggestIdParsed];
        } else {
            _biggestIdParsed = 0;
        }
        
    }
    return self;
}


- (void)downloadNewQuestionsWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSError *error = nil;
    
    int counter = 1;
    NSMutableDictionary *courses = [[NSMutableDictionary alloc] init];
    for (Course *course in [[UserManager sharedManager] courses]) {
        [courses setObject:[course identifier] forKey:[NSString stringWithFormat:@"%d",counter]];
        counter++;
    }
    
    //Here we create the POST-Body-String that we will send to the server
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:courses options:NSJSONWritingPrettyPrinted error:&error];
    NSString *coursesJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *completeDataString = [NSString stringWithFormat:@"lastId=%ld&courses=%@", (long)_biggestIdParsed, coursesJsonString];
    
    //Create the session and send our request
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:NEW_QUESTIONS_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [completeDataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
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
    }];
    [postDataTask resume];
    
}


- (void)downloadNewQuestionsTheFirstTime
{
    NSError *error = nil;
    
    int counter = 1;
    NSMutableDictionary *courses = [[NSMutableDictionary alloc] init];
    for (Course *course in [[UserManager sharedManager] courses]) {
        [courses setObject:[course identifier] forKey:[NSString stringWithFormat:@"%d",counter]];
        counter++;
    }
    
    //Here we create the POST-Body-String that we will send to the server
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:courses options:NSJSONWritingPrettyPrinted error:&error];
    NSString *coursesJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *completeDataString = [NSString stringWithFormat:@"lastId=%ld&courses=%@", (long)_biggestIdParsed, coursesJsonString];
    
    //Create the session and send our request
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:NEW_QUESTIONS_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [completeDataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            //Parse the JSON-String that has been returned
            //ParseManager *parseManager = [[ParseManager alloc] init];
            // BOOL newUpdates = [parseManager parseData:data withCompletionHandler:nil];
        }
    }];
    [postDataTask resume];
    
}


- (void) saveBiggestIdParsed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:_biggestIdParsed] forKey:@"biggestIdParsed"];
    [defaults synchronize];
}

- (void) restoreBiggestIdParsed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger bip = [[defaults objectForKey:@"biggestIdParsed"] integerValue];
    _biggestIdParsed = bip;
}


@end
