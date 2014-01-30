//
//  Course.h
//  L2P-Quiz
//
//  Created by Emil Atanasov on 1/30/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, strong) NSString * relativeURL;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, assign) int status;

@end
