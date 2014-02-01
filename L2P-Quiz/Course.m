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

-(id)initWithCoder:(NSCoder *)decoder {
    if ((self=[super init])) {
        _title = [decoder decodeObjectForKey:@"title"];
        _identifier = [decoder decodeObjectForKey:@"identifier"];
        _relativeURL = [decoder decodeObjectForKey:@"url"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_identifier forKey:@"identifier"];
    [encoder encodeObject:_relativeURL forKey:@"url"];
}

@end
