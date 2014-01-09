//
//  Question.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/9/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Question : NSManagedObject

@property (nonatomic, retain) NSNumber * identity;
@property (nonatomic, retain) NSString * course;
@property (nonatomic, retain) NSString * corr_sol;
@property (nonatomic, retain) NSString * wrong_sol1;
@property (nonatomic, retain) NSString * wrong_sol2;
@property (nonatomic, retain) NSString * wrong_sol3;
@property (nonatomic, retain) NSString * question;

@end
