//
//  ParseManager.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/9/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "ParseManager.h"

@implementation ParseManager

- (BOOL)parseData:(NSData*)data withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSString *stringToParse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //Just to test if it has worked...
    [UIApplication sharedApplication].applicationIconBadgeNumber = 9;
    
    NSLog(stringToParse);
    
    //If we don't have any new questions, return NO
    if ([stringToParse isEqualToString:@""]) {
        return NO;
    }
    
    //TODO: parse and save to Core Data!
    
    return YES;
}

@end
