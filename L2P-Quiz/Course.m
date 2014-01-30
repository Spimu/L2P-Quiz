//
//  Course.m
//  L2P-Quiz
//
//  Created by Emil Atanasov on 1/30/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "Course.h"

@implementation Course

- (NSString *)description
{
    NSString * desc = [NSString stringWithFormat:@"Title: %@, id: %@, url: %@", self.title, self.identifier, self.relativeURL];
    return desc;
}

@end
