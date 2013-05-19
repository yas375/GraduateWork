//
//  SaatiRankingPageViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 19.05.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "SaatiRankingPageViewController.h"
#import "SaatiRankViewController.h"

@interface SaatiRankingPageViewController ()
<UIPageViewControllerDataSource>

@end

@implementation SaatiRankingPageViewController

- (void)dealloc
{
  self.dataSource = nil;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  NSAssert(self.strategy.alternatives.count > 1, @"It is required to have at least two alternatives.");

  [self setViewControllers:@[[self rankViewControllerForAlternativeAtIndex:0]]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:NO
                completion:NULL];

  self.dataSource = self;
}

- (SaatiRankViewController *)rankViewControllerForAlternativeAtIndex:(NSUInteger)index
{
  SaatiRankViewController *rankViewController = [[SaatiRankViewController alloc] initWithNibName:@"SaatiRankViewController" bundle:nil];
  rankViewController.baseAlternative = self.strategy.alternatives[index];

  NSMutableArray *otherAlternatives = [self.strategy.alternatives mutableCopy];
  [otherAlternatives removeObject:rankViewController.baseAlternative];
  rankViewController.otherAlternatives = otherAlternatives;
  return rankViewController;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(SaatiRankViewController *)viewController
{
  NSUInteger index = [self.strategy.alternatives indexOfObject:viewController.baseAlternative];
  if (index == 0) {
    return nil;
  }
  return [self rankViewControllerForAlternativeAtIndex:(index - 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(SaatiRankViewController *)viewController
{
  NSUInteger index = [self.strategy.alternatives indexOfObject:viewController.baseAlternative];
  if (index == self.strategy.alternatives.count - 1) {
    return nil;
  }
  return [self rankViewControllerForAlternativeAtIndex:(index + 1)];
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
