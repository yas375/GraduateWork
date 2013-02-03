//
//  VIMasterViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 02.02.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "VIMasterViewController.h"

#import "VIDetailViewController.h"

@interface VIMasterViewController () {
  NSMutableArray *_objects;
}
@end

@implementation VIMasterViewController

- (void)awakeFromNib
{
  self.clearsSelectionOnViewWillAppear = NO;
  self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
  [super awakeFromNib];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.detailViewController = (VIDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

@end
