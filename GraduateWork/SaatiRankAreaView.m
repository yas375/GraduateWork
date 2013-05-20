//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreGraphics/CoreGraphics.h>
#import "SaatiRankAreaView.h"


@interface SaatiRankAreaView ()
@property(nonatomic, strong) IBOutlet UILabel *baseAlternativeLabel;
@property(nonatomic, strong) NSArray *rankValues;
@end

@implementation SaatiRankAreaView

- (Fraction *)fractionForY:(CGFloat)y
{
  if (y == self.bounds.size.height) {
    return self.rankValues.lastObject;
  }

  NSUInteger valueIndex = (NSUInteger)(y / self.heightPerValue);

  // XXX: to be safe from crashes in some edge cases
  valueIndex = MAX(MIN(valueIndex, self.rankValues.count - 1), 0);

  return self.rankValues[valueIndex];
}

// todo: maybe make only setter without getter
- (void)setMaxRank:(NSUInteger)maxRank
{
  if (maxRank != _maxRank) {
    _maxRank = maxRank;
    NSMutableArray *values = [NSMutableArray array];
    // 3, 2
    for (int i = maxRank; i > 1; i--) {
      [values addObject:[Fraction fractionWithNumerator:i]];
    }
    // 1
    [values insertObject:[Fraction fractionWithNumerator:1] atIndex:(maxRank - 1)];
    // 1/2, 1/3
    for (int i = 2; i <= maxRank; i++) {
      [values addObject:[Fraction fractionWithNumerator:1 denominator:i]];
    }
    self.rankValues = [values copy];
  }
}

- (CGFloat)yForFraction:(Fraction *)fraction
{
  NSUInteger valueIndex = [self.rankValues indexOfObject:fraction];

  if (valueIndex == NSNotFound) {
    [NSException raise:@"Can't find fraction" format:@"Rank area doesn't have %@ fraction. Max rank is %d", fraction, self.maxRank];
  }

  return (self.heightPerValue * (valueIndex + 0.5));
}

- (CGFloat)heightPerValue
{
  return (self.bounds.size.height / self.rankValues.count);
}

- (void)setBaseAlternative:(NSString *)baseAlternative
{
  self.baseAlternativeLabel.text = baseAlternative;
}

@end