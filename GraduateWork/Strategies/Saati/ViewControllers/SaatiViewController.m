//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//


#import "SaatiViewController.h"
#import "SaatiRankingPageViewController.h"
#import "SaatiRankViewController.h"

static NSString *const kRankSegue = @"kRankSegue";

@interface SaatiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *debugLabel;
@end

@implementation SaatiViewController

#pragma mark - Actions

- (IBAction)rank:(id)sender {

  SaatiRankingPageViewController *pageController = [[SaatiRankingPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
  pageController.strategy = self.strategy;

  UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:pageController];
  [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Methods

- (void)updateStatusLabel
{
  if (self.strategy.canBeCalculated) {
    self.statusLabel.text = [NSString stringWithFormat:@"Наиболее предпочтительная альтернатива: %@", self.strategy.preferredAlternative];
  }
  else {
    self.statusLabel.text = @"Необходимо дать экспертую оценку всем альтернативам";
  }
}

#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:kRankSegue]) {
    SaatiRankingPageViewController *pageController = (SaatiRankingPageViewController *)segue.destinationViewController;
    pageController.strategy = self.strategy;
  }
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.debugLabel.text = self.strategy.rankMatrix.stringValue;
  [self updateStatusLabel];
}

@end