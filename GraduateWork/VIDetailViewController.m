//
//  VIDetailViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 02.02.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "VIDetailViewController.h"
#import "SaatiViewController.h"
#import "SaatiStrategy.h"

static NSString *const kSaatiSegue = @"kSaatiSegue";

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

#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:kSaatiSegue]) {
    SaatiStrategy *strategy = [[SaatiStrategy alloc] init];
    strategy.alternatives = @[
            @"В метро",
            @"На TV",
            @"На радио",
            @"В интернете"
    ];

    SaatiViewController *controller = (SaatiViewController *)segue.destinationViewController;
    controller.strategy = strategy;
  }
}

@end
