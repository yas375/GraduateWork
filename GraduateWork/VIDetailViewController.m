//
//  VIDetailViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 02.02.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "VIDetailViewController.h"

@interface VIDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end


@implementation VIDetailViewController

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"Алгоритмы";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
