//
//  SelectCourseViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/14/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "SelectCourseViewController.h"

@interface SelectCourseViewController ()

@property (nonatomic) NSArray *allCourses;
@property (nonatomic) NSMutableArray *allSelectedCourses;

@end

@implementation SelectCourseViewController

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
	
    //TODO:
    //_allCourses = [L2PManager getAllCoursesOfThisYear];
    
    _allCourses = [[NSArray alloc] init];
    _allCourses = @[@"DIS", @"Current topics", @"iPhone"];
    
    _allSelectedCourses = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_allCourses count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] ;
    }
    
    cell.textLabel.text = _allCourses[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [_allSelectedCourses removeObject:cellText];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [_allSelectedCourses addObject:cellText];
    }
    
}


- (IBAction)startPressed:(id)sender
{
    //Tell our GameManager which courses the user selected
    [[SingleGameManager sharedManager] setSelectedCourses:_allSelectedCourses];
}

@end
