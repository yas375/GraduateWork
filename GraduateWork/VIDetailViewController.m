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
static NSString *const kAlternativeCell = @"kAlternativeCell";

@interface VIDetailViewController ()
<UITableViewDataSource>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (copy, nonatomic) NSMutableArray *alternatives;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    strategy.alternatives = self.alternatives;

    SaatiViewController *controller = (SaatiViewController *)segue.destinationViewController;
    controller.strategy = strategy;
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

@end
