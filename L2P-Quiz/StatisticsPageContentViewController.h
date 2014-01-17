//
//  StatisticsPageContentViewController.h
//  L2P-Quiz
//
//  Created by Marty Pye on 17/01/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDConstants.h"
#import "CPDStockPriceStore.h"


@interface StatisticsPageContentViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate>

@property NSUInteger pageIndex;
@property NSString *titleText;

@end
