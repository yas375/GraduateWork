//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//


#import "SaatiViewController.h"
#import "SaatiRankingPageViewController.h"
#import "SaatiRankViewController.h"

static NSString *const kAlternativeCell = @"kAlternativeCell";
static NSString *const kRankSegue = @"kRankSegue";

@interface SaatiViewController ()
<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *initialAlternativesTableView;
@property (weak, nonatomic) IBOutlet UITableView *finalAlternativesTableView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *debugLabel;

@property (strong, nonatomic) NSArray *orderedAlternatives;

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

- (void)setStatusText:(NSString *)text
{
  self.statusLabel.text = text;
}

- (void)updateStatusLabel
{
  if (self.strategy.isValid) {
    self.orderedAlternatives = self.strategy.orderedAlternatives;
    [self setStatusText:@"Решение найдено"];
  }
  else if (self.strategy.hasAllRanks) {
    self.orderedAlternatives = nil;
    [self setStatusText:@"Пожалуйста, уточните оценки. Имеются противоречащие друг другу оценки."];
  }
  else {
    self.orderedAlternatives = nil;
    [self setStatusText:@"Необходимо дать экспертую оценку всем альтернативам"];
  }
  [self.finalAlternativesTableView reloadData];
}

#pragma mark - UITablewViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAlternativeCell];

  if (tableView == self.finalAlternativesTableView) {
    cell.textLabel.text = self.orderedAlternatives[indexPath.row];
  }
  else {
    cell.textLabel.text = self.strategy.alternatives[indexPath.row];
  }

  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (tableView == self.finalAlternativesTableView) {
    return self.orderedAlternatives.count;
  }
  else {
    return self.strategy.alternatives.count;
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