//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//


#import "SaatiViewController.h"
#import "SaatiRankingPageViewController.h"
#import "SaatiRankViewController.h"

static NSString *const kRankSegue = @"kRankSegue";

@interface SaatiViewController ()
<UIPageViewControllerDataSource>

@end

@implementation SaatiViewController



#pragma mark - UIViewController
- (IBAction)rank:(id)sender {
  UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
  pageController.dataSource = self;
  [self.navigationController pushViewController:pageController animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:kRankSegue]) {
    SaatiRankingPageViewController *pageController = (SaatiRankingPageViewController *)segue.destinationViewController;
    pageController.strategy = self.strategy;
  }
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
  SaatiRankViewController *rankViewController = [[SaatiRankViewController alloc] initWithNibName:@"SaatiRankViewController" bundle:nil];
  rankViewController.otherAlternatives = self.strategy.alternatives;
  return rankViewController;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
  SaatiRankViewController *rankViewController = [[SaatiRankViewController alloc] initWithNibName:@"SaatiRankViewController" bundle:nil];
  rankViewController.otherAlternatives = self.strategy.alternatives;
  return rankViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
  return self.strategy.alternatives.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
  return 0;
}


@end