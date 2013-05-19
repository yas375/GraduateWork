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
<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

/**
  We will store copy of rank matrix from SaatiStrategy in this property.
  This matrix will be updated during ranking. And at the end if user taps 'Done' - we set this value
  into strategy. Otherwise we do just nothing.
 */
@property (copy, nonatomic) SaatiMatrix *rankMatrix;
@property (strong, nonatomic) UIBarButtonItem *nextButton;
@property (strong, nonatomic) UIBarButtonItem *prevButton;
@property (strong, nonatomic) UIBarButtonItem *cancelButton;
@property (strong, nonatomic) UIBarButtonItem *doneButton;

@end

@implementation SaatiRankingPageViewController

- (void)dealloc
{
  self.dataSource = nil;
}

- (id)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options
{
  self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
  if (self) {
    self.dataSource = self;
    self.delegate = self;

    __weak typeof(self) weakSelf = self;
    self.cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel handler:^(id sender) {
      [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone handler:^(id sender) {
      weakSelf.strategy.rankMatrix = weakSelf.rankMatrix;
      [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    self.prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(previous:)];
    self.nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(next:)];
  }

  return self;
}

#pragma mark - Actions

- (void)previous:(id)sender
{
  NSUInteger index = [self currentAlternativeIndex];
  if (index > 0) {
    __weak typeof(self) weakSelf = self;
    [self setViewControllers:@[[self rankViewControllerForAlternativeAtIndex:index - 1]]
                   direction:UIPageViewControllerNavigationDirectionReverse
                    animated:YES
                  completion:^(BOOL finished) {
                    [weakSelf updateButtons];
                  }];
  }
}

- (void)next:(id)sender
{
  NSUInteger index = [self currentAlternativeIndex];
  if (index < self.strategy.alternatives.count - 1) {
    __weak typeof(self) weakSelf = self;
    [self setViewControllers:@[[self rankViewControllerForAlternativeAtIndex:index + 1]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) {
                    [weakSelf updateButtons];
                  }];
  }
}

#pragma mark - Setters

- (void)setStrategy:(SaatiStrategy *)strategy
{
  if (strategy != _strategy)
  {
    _strategy = strategy;
    self.rankMatrix = self.strategy.rankMatrix;
  }
}

#pragma mark - Methods

- (NSUInteger)currentAlternativeIndex
{
  NSString *alternative = [self.viewControllers.lastObject baseAlternative];
  return [self.strategy.alternatives indexOfObject:alternative];
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

- (void)updateButtons
{
  NSUInteger index = [self currentAlternativeIndex];
  if (index == 0) {
    self.navigationItem.leftBarButtonItem = self.cancelButton;
  }
  else {
    self.navigationItem.leftBarButtonItem = self.prevButton;
  }
  if (index == self.strategy.alternatives.count - 1) {
    self.navigationItem.rightBarButtonItem = self.doneButton;
  }
  else {
    self.navigationItem.rightBarButtonItem = self.nextButton;
  }
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

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
  if (finished) {
    [self updateButtons];
  }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  NSAssert(self.strategy.alternatives.count > 1, @"It is required to have at least two alternatives.");

  [self setViewControllers:@[[self rankViewControllerForAlternativeAtIndex:0]]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:NO
                completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self updateButtons];
}

@end
