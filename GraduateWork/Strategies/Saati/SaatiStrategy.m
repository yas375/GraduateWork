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

- (BOOL)canBeCalculated
{
  return (self.rankMatrix.containsNulls == NO);
}

+ (BOOL)isMultiExpert
{
  return NO;
}

- (NSString *)preferredAlternative
{
  if (self.canBeCalculated == NO) {
    return nil;
  }

  NSUInteger size = self.alternatives.count;
  // Находятся цены альтернатив - средние геометрические строк матрицы, т.е. элементы строки перемножаются, и из
  // их произведения извлекается корень N-й степени.
  NSMutableArray *prices = [NSMutableArray array];
  for (int i = 0; i < size; i++) {
    NSArray *row = [self.rankMatrix rowAtIndex:i];
    double proizvedenie = 1.0;
    for (Fraction *value in row) {
      proizvedenie *= value.doubleValue;
    }
    double c = pow(proizvedenie, 1.0 / size);
    [prices addObject:@(c)];
    NSLog(@"Цена альтернативы %d: %f", i, c);

  }

  // Находится сумма цен альтернатив:
  __block double summaCenAlternative = 0.0;
  [prices each:^(NSNumber *sender) {
    summaCenAlternative += [sender doubleValue];
  }];
  NSLog(@"Сумма цен альтернатив: %f", summaCenAlternative);

  // Находятся веса альтернатив
  // Наиболее предпочтительной, по мнению эксперта, является альтернатива, имеющая максимальный вес.
  NSUInteger indexOfPreferredAlternative = 0;
  double maxWeight = 0.0;
  for (int i = 0; i < size; i++) {
    double weigth = [prices[i] doubleValue] / summaCenAlternative;
    NSLog(@"Вес альтернативы %d: %f", i, weigth);
    if (weigth > maxWeight) {
      maxWeight = weigth;
      indexOfPreferredAlternative = i;
    }
  }
  return self.alternatives[indexOfPreferredAlternative];
}

- (void)setAlternatives:(NSArray *)alternatives
{
  if (alternatives != _alternatives) {
    _alternatives = alternatives;
  }
  self.rankMatrix = [[SaatiMatrix alloc] initWithSize:self.alternatives.count];
}

@end