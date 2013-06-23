//
//  RootViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 02.02.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "AlternativeViewController.h"
#import "RootViewController.h"
#import "SaatiViewController.h"
#import "SaatiStrategy.h"

static NSString *const kSaatiSegue = @"kSaatiSegue";
static NSString *const kAddAlternativeSegue = @"kAddAlternativeSegue";
static NSString *const kAlternativeCell = @"kAlternativeCell";

@interface RootViewController ()
<AlternativeViewControllerDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) NSMutableArray *alternatives;
@property (weak, nonatomic) UIPopoverController *popover;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saatiButton;

@end


@implementation RootViewController

#pragma mark - Methods

- (void)updateButtonState
{
  NSUInteger numberOfAlternatives = self.alternatives.count;
  self.saatiButton.enabled = (numberOfAlternatives >= [SaatiStrategy minimumNumberOfAlternatives] && numberOfAlternatives <= [SaatiStrategy maximumNumberOfAlternatives]);
}

#pragma mark - AlternativeViewControllerDelegate

- (void)alternativeViewController:(AlternativeViewController *)viewController didAddAlternative:(NSString *)alternative
{
  [self.alternatives addObject:alternative];
  [self updateButtonState];
  [self.popover dismissPopoverAnimated:YES];
  [self.tableView reloadData];
}

#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:kSaatiSegue]) {
    SaatiStrategy *strategy = [[SaatiStrategy alloc] init];
    strategy.alternatives = self.alternatives;

    SaatiViewController *controller = (SaatiViewController *)segue.destinationViewController;
    controller.strategy = strategy;
  }
  else if ([segue.identifier isEqualToString:kAddAlternativeSegue]) {
    AlternativeViewController *controller = segue.destinationViewController;
    controller.delegate = self;
    self.popover = [(UIStoryboardPopoverSegue *)segue popoverController];
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.alternatives = [NSMutableArray arrayWithArray:@[
                       @"TV",
                       @"Radio",
                       @"Newspaper",
                       @"Stand"]
                       ];
  self.tableView.editing = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self updateButtonState];
}

#pragma mark - UITablewViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAlternativeCell];

  cell.textLabel.text = self.alternatives[indexPath.row];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.alternatives.count;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.alternatives removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
    [self updateButtonState];
  }
}

@end
