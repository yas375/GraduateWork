//
//  DroppableAlternativeView.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 14.05.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DroppableAlternativeView.h"

@interface DroppableAlternativeView ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic, assign) CGRect previousFrame;
@end

@implementation DroppableAlternativeView


// TODO: xib
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      frame.origin = CGPointZero;
      self.label = [[UILabel alloc] initWithFrame:frame];
      self.label.layer.cornerRadius = 7;
      self.label.layer.borderColor = [UIColor darkGrayColor].CGColor;
      self.label.layer.borderWidth = 2;
      self.label.backgroundColor = [UIColor cyanColor];
      self.label.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
      self.label.textAlignment = NSTextAlignmentCenter;
      self.label.numberOfLines = 0;
      [self addSubview:self.label];
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  return NO;
}

#pragma mark - Methods

- (void)setAlternative:(NSString *)alternative
{
  if ([alternative isEqualToString:_alternative] == NO) {
    _alternative = alternative;
    self.label.text = self.alternative;
  }
}

- (void)moveBack
{
  CGRect frame = [self.previousContainer convertRect:self.previousFrame toView:self.superview];

  [UIView animateWithDuration:0.3 animations:^{
    self.frame = frame;
  } completion:^(BOOL finished) {
    [self.previousContainer addSubview:self];
    self.frame = self.previousFrame;
  }];
}

- (void)prepareForDragging
{
  NSAssert(self.viewToDragIn != nil, @"Droppable view must have a view to be dragged inside of.");

  self.previousFrame = self.frame;
  self.previousContainer = self.superview;

  // move to drag view
  CGRect frame = [self convertRect:self.frame toView:self.viewToDragIn];
  [self.viewToDragIn addSubview:self];
  self.frame = frame;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self prepareForDragging];

  self.center = [[touches anyObject] locationInView:self.superview];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  self.center = [[touches anyObject] locationInView:self.superview];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [self moveBack];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.delegate didFinishDragging:self];
}

@end
