//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//


#import "SaatiViewController.h"
#import "SaatiRankingPageViewController.h"
#import "SaatiRankViewController.h"

static NSString *const kRankSegue = @"kRankSegue";

@interface SaatiViewController ()

@end

@implementation SaatiViewController

#pragma mark - UIViewController

- (IBAction)rank:(id)sender {

  SaatiRankingPageViewController *pageController = [[SaatiRankingPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
  pageController.strategy = self.strategy;

  UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:pageController];
  [self presentViewController:navigation animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:kRankSegue]) {
    SaatiRankingPageViewController *pageController = (SaatiRankingPageViewController *)segue.destinationViewController;
    pageController.strategy = self.strategy;
  }
}

@end