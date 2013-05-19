//
//  SaatiRankViewController.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 14.05.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "SaatiRankViewController.h"
#import "DroppableAlternativeView.h"
#import "SaatiRankAreaView.h"

static const CGFloat kAlternativeViewHeight = 30.0f;
static const CGFloat kAlternativeSpacer = 5.0f;

@interface SaatiRankViewController ()
<DroppableAlternativeViewDelegate>

@property (weak, nonatomic) IBOutlet SaatiRankAreaView *rankArea;
@property (weak, nonatomic) IBOutlet UIView *waitContainer;
@property (weak, nonatomic) IBOutlet UILabel *debugLabel;

@property (strong, nonatomic) NSArray *alternativeViews; // droppable views

@end

@implementation SaatiRankViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.rankArea.maxRank = 9; // TODO: calculate

  self.rankArea.baseAlternative = self.baseAlternative;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  // given all views are created, but probably not added somewhere

  NSArray *ranks = [self.delegate ranksOfAlternatives:self];
  NSAssert(ranks.count == self.alternativeViews.count, @"Number of ranks and alternative views should be the same.");


  CGFloat width = self.waitContainer.bounds.size.width - kAlternativeSpacer * 2;
  CGRect frame = CGRectMake(kAlternativeSpacer, kAlternativeSpacer, width, kAlternativeViewHeight);


  for (int i = 0; i < ranks.count; i++) {
    Fraction *rank = ranks[i];
    DroppableAlternativeView *view = self.alternativeViews[i];

    if ([rank isKindOfClass:NSNull.class]) {
      if (view.superview != self.waitContainer) {
        [self.waitContainer addSubview:view];
      }
      // set position
      view.frame = frame;
      // prepare frame for next
      frame.origin.y += kAlternativeViewHeight + kAlternativeSpacer;
      [self.waitContainer addSubview:view];
    }
    else {
      if (view.superview == self.rankArea) {
        // check if it belongs to the same fraction. If not - update the position
        Fraction *currentRank = [self.rankArea fractionForY:view.center.y];
        if ([currentRank isEqual:rank] == NO) {
          // update position
          CGPoint center = view.center;
          center.y = [self.rankArea yForFraction:rank];
          view.center = center;
        }
      }
      else {
        [self.rankArea addSubview:view];
        // set position
        CGPoint center;
        center.x = (self.rankArea.bounds.size.width + view.frame.size.width) / 2;
        center.y = [self.rankArea yForFraction:rank];
        view.center = center;
      }
    }
  }
  [self updateDebugInfo];
}

#pragma mark - Methods

- (void)updateDebugInfo
{
  self.debugLabel.text = self.delegate.matrix.stringValue;
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
    // TODO: cache positions
    Fraction *rank = [self.rankArea fractionForY:view.center.y];
    [self.delegate rankPage:self didUpdateRank:rank ofAlternative:view.alternative];

    [self updateDebugInfo];
  }
  else {
    [view moveBack];
  }
}

- (NSArray *)alternativeViews
{
  if (_alternativeViews == nil && self.otherAlternatives != nil) {
    NSMutableArray *views = [NSMutableArray array];

    CGFloat width = self.waitContainer.bounds.size.width - kAlternativeSpacer * 2;
    CGRect frame = CGRectMake(0, 0, width, kAlternativeViewHeight);

    for (NSString *alternative in self.otherAlternatives) {
      DroppableAlternativeView *view = [[DroppableAlternativeView alloc] initWithFrame:frame];
      view.viewToDragIn = self.view;
      view.alternative = alternative;
      view.delegate = self;
      [views addObject:view];
    }

    _alternativeViews = [views copy];
  }
  return _alternativeViews;
}

@end
