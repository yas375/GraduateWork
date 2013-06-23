//
//  RootViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 02.02.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "RootViewController.h"
#import "SaatiViewController.h"
#import "SaatiStrategy.h"

static NSString *const kSaatiSegue = @"kSaatiSegue";
static NSString *const kAlternativeCell = @"kAlternativeCell";

@interface RootViewController ()
<UITableViewDataSource>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (copy, nonatomic) NSMutableArray *alternatives;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation RootViewController

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
