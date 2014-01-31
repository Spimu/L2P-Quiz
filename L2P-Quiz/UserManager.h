//
//  UserManager.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/25/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

+ (id)sharedManager;


//Always call "save" whenever we cahnged sth
- (void) save;



@property (nonatomic) int userScore;
@property (nonatomic) int duelsWon;
@property (nonatomic) int duelsLost;


//The identity and the courses, we should get them from the L2P API
@property (nonatomic) NSString *identity;
@property (nonatomic) NSMutableArray *courses;




@end
