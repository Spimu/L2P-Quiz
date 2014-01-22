//
//  APIViewController.h
//  L2PAPI
//
//  Created by Aaron Krämer on 30/11/13.
//  Copyright (c) 2013 Aaron Krämer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIViewController : UIViewController <NSURLConnectionDataDelegate, NSXMLParserDelegate>

@property(retain) NSString  *accessToken;

@property(weak, nonatomic) IBOutlet UITextView   *textView;

-(IBAction)discussionButtonPressed:(UIButton*)sender;
-(IBAction)courseRoomsButtonPressed:(UIButton*)sender;
-(IBAction)wikiPageButtonPressed:(UIButton*)sender;
-(IBAction)pdfButtonPressed:(UIButton*)sender;

@end
