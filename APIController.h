//
//  APIViewController.h
//  L2PAPI
//
//  Created by Aaron Krämer on 30/11/13.
//  Copyright (c) 2013 Aaron Krämer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APIController;

@protocol DataLoadedDelegate <NSObject>

-(void) dataLoaded:(APIController *) controller;

@end

@interface APIController : NSObject <NSURLConnectionDataDelegate, NSXMLParserDelegate>

@property(retain) NSString  *accessToken;

//expose some functions, so we can see that the l2P API is working proeprly
-(void)getL2PCourseRooms;
-(void)getWikiPages;
-(void)getDiscussions;
-(void)getDocuments;
-(void)getPDFWithID:(NSString*)documentID;

+(APIController *) getInstance;

-(NSArray*) getAllCourses;

-(void) setDelegate:(id<DataLoadedDelegate>) delegate;

@end
