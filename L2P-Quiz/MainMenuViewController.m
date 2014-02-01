//
//  MainMenuViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/9/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "MainMenuViewController.h"
#import "Course.h"
#import "UserManager.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[APIController getInstance] setDelegate:self];
    [[APIController getInstance] getL2PCourseRooms];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (IBAction)onLogout:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) dataLoaded:(APIController *)controller
{
    NSArray *courses = [controller getAllCourses];
    
    
    //PARSING ONLY THE COURSES OF THE CURRENT SEMESTER
    NSString *searchString = @"";
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    
    if (month < 4) {
        searchString = [NSString stringWithFormat:@"%dws",year-2001];
    } else if (month < 10) {
        searchString = [NSString stringWithFormat:@"%dss",year-2000];
    } else {
        searchString = [NSString stringWithFormat:@"%dws",year-2000];
    }
    
    [[[UserManager sharedManager] courses] removeAllObjects];
    
    for (Course *course in courses) {
        NSString *subString = [[course identifier] substringWithRange:NSMakeRange(0,4)];
        
        if ([subString isEqualToString:searchString]) {
            [[[UserManager sharedManager] courses] addObject:course];
        }
    }
    [[UserManager sharedManager] save];
}

@end
