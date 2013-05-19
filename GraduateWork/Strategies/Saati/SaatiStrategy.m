//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SaatiStrategy.h"


@implementation SaatiStrategy

#pragma mark - Strategy

@synthesize alternatives = _alternatives;

+ (BOOL)isMultiExpert
{
  return NO;
}

- (void)setAlternatives:(NSArray *)alternatives
{
  if (alternatives != _alternatives) {
    _alternatives = alternatives;
  }
  self.rankMatrix = [[SaatiMatrix alloc] initWithSize:self.alternatives.count];
}

@end