//
//  VIMasterViewController.h
//  GraduateWork
//
//  Created by Victor Ilyukevich on 02.02.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VIDetailViewController;

@interface VIMasterViewController : UITableViewController

@property (strong, nonatomic) VIDetailViewController *detailViewController;

@end
