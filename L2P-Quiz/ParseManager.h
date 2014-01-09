//
//  ParseManager.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/9/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseManager : NSObject

- (BOOL)parseData:(NSData*)data withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
