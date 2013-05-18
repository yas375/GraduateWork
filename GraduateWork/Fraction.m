//
// Created by Victor Ilyukevich on 14.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Fraction.h"


@implementation Fraction

#pragma mark - Class methods

+ (Fraction *)fractionWithNumerator:(NSUInteger)numerator
{
  return [Fraction fractionWithNumerator:numerator denominator:1];
}

+ (Fraction *)fractionWithNumerator:(NSUInteger)numerator denominator:(NSUInteger)denominator
{
  return [[Fraction alloc] initWithNumerator:numerator denominator:denominator];
}

#pragma mark - Lifecycle

- (id)initWithNumerator:(NSUInteger)numerator denominator:(NSUInteger)denominator
{
  self = [super init];
  if (self) {
    self.numerator = numerator;
    self.denominator = denominator;
  }
  return self;
}

#pragma mark - Methods

- (Fraction *)reversedFraction
{
  return [Fraction fractionWithNumerator:self.denominator denominator:self.numerator];
}

- (double)doubleValue
{
  return ((double)self.numerator / self.denominator);
}

- (NSString *)description
{
  if (self.denominator == 1) {
    return [NSString stringWithFormat:@"%d", self.numerator];
  }
  else {
    return [NSString stringWithFormat:@"%d/%d", self.numerator, self.denominator];
  }
}

- (BOOL)isEqual:(Fraction *)object
{
  if (self == object) {
    return YES;
  }
  if ([object isMemberOfClass:self.class] == NO) {
    return NO;
  }
  return (self.numerator == object.numerator && self.denominator == object.denominator);
}

- (void)setDenominator:(NSUInteger)denominator
{
  if (denominator != _denominator) {
    if (denominator == 0) {
      [NSException raise:@"Denominator can't be zero. Devide by zero is prohibited." format:nil];
    }
    _denominator = denominator;
  }
}

@end