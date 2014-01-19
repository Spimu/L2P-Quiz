//
//  ResultCell.h
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/19/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UILabel *yourSolution;
@property (weak, nonatomic) IBOutlet UILabel *correctSolution;

@end
