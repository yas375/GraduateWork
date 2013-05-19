//
//  SaatiRankViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 14.05.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "SaatiRankViewController.h"
#import "DroppableAlternativeView.h"

static const CGFloat kAlternativeViewHeight = 80.0f;
static const CGFloat kAlternativeSpacer = 10.0f;

@interface SaatiRankViewController ()
<DroppableAlternativeViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *rankArea;
@property (weak, nonatomic) IBOutlet UIView *waitContainer;

@end

@implementation SaatiRankViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupViewForOtherAlternatives];
  [self setupViewForBaseAlternative];
}

#pragma mark - Methods

- (void)setupViewForOtherAlternatives
{
  CGFloat width = self.waitContainer.bounds.size.width - kAlternativeSpacer * 2;
  CGRect frame = CGRectMake(kAlternativeSpacer,
                            kAlternativeSpacer,
                            width, kAlternativeViewHeight);
  for (NSString *alternative in self.otherAlternatives) {
    DroppableAlternativeView *view = [[DroppableAlternativeView alloc] initWithFrame:frame];
    view.viewToDragIn = self.view;
    view.alternative = alternative;
    view.delegate = self;
    // prepare frame for next
    frame.origin.y += kAlternativeViewHeight + kAlternativeSpacer;
    [self.waitContainer addSubview:view];
  }
}

- (void)setupViewForBaseAlternative
{
  
}

#pragma mark - DroppableAlternativeViewDelegate

- (void)didFinishDragging:(DroppableAlternativeView *)view
{
  CGRect frame = [view.superview convertRect:view.frame toView:self.rankArea.superview];
  if (CGRectContainsRect(self.rankArea.frame, frame)) {
    if (view.previousContainer == self.waitContainer) {
      view.frame = [view.superview convertRect:view.frame toView:self.rankArea];
      [self.rankArea addSubview:view];
    }
  }
  else {
    [view moveBack];
  }
}

@end
