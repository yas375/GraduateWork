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
@property (nonatomic, weak) UIView *previousSuperview;
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

#pragma mark - Methods

- (void)setAlternative:(Alternative *)alternative
{
  if (alternative != _alternative) {
    _alternative = alternative;
    self.label.text = self.alternative.name;
  }
}

- (void)moveBack
{
  CGRect frame = [self.previousSuperview convertRect:self.previousFrame toView:self.superview];

  [UIView animateWithDuration:0.3 animations:^{
    self.frame = frame;
  } completion:^(BOOL finished) {
    [self.previousSuperview addSubview:self];
    self.frame = self.previousFrame;
  }];
}

- (void)prepareForDragging
{
  NSAssert(self.viewToDragIn != nil, @"Droppable view must have a view to be dragged inside of.");

  self.previousFrame = self.frame;
  self.previousSuperview = self.superview;

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
