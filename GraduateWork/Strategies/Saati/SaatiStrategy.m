//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SaatiStrategy.h"

@implementation SaatiStrategy

#pragma mark - Methods

- (NSArray *)alternativeWeights
{
  if (self.hasAllRanks == NO) {
    return nil;
  }
  NSUInteger size = self.alternatives.count;
  // Находятся цены альтернатив - средние геометрические строк матрицы, т.е. элементы строки перемножаются, и из
  // их произведения извлекается корень N-й степени.
  NSMutableArray *prices = [NSMutableArray arrayWithCapacity:size];
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
  NSMutableArray *weights = [NSMutableArray arrayWithCapacity:size];
  for (int i = 0; i < size; i++) {
    double weight = [prices[i] doubleValue] / summaCenAlternative;
    NSLog(@"Вес альтернативы %d: %f", i, weight);
    [weights addObject:@(weight)];
  }
  return [weights copy];
}

- (double)conformityValue
{
  static NSDictionary *values = nil;
  if (values == nil) {
    values = @{
               @3 : @(0.58), @4 : @(0.9),
               @5 : @(1.12), @6 : @(1.24),
               @7 : @(1.32), @8 : @(1.41),
               @9 : @(1.45), @10 : @(1.49)
               };
  }
  return [values[@(self.alternativeWeights.count)] doubleValue];
}

#pragma mark - Strategy

@synthesize alternatives = _alternatives;

+ (NSUInteger)minimumNumberOfAlternatives
{
  return 3;
}

+ (NSUInteger)maximumNumberOfAlternatives
{
  return 5;
}

+ (NSUInteger)minimumNumberOfExperts
{
  return 1;
}

+ (NSUInteger)maximumNumberOfExperts
{
  return 1;
}

- (BOOL)hasAllRanks
{
  return (self.rankMatrix.containsNulls == NO);
}

- (BOOL)isValid
{
  if (self.hasAllRanks == NO) {
    return NO;
  }

  NSUInteger size = self.alternatives.count;
  // 1. Находятся суммы столбцов матрицы парных сравнений
  NSMutableArray *sums = [NSMutableArray arrayWithCapacity:size];
  for (int column = 0; column < size; column++) {
    double sum = 0.0;
    for (int row = 0; row < size; row++) {
      sum += [[self.rankMatrix valueForRow:row column:column] doubleValue];
    }
    [sums addObject:@(sum)];
    NSLog(@"Сумма столбца %d: %f", column, sum);
  }
  // 2. Рассчитывается вспомогательная величина λ путем суммирования произведений сумм столбцов матрицы на веса альтернатив:
  NSArray *prices = [self alternativeWeights];
  double lambda = 0.0;
  for (int i = 0; i < size; i++) {
    lambda += [sums[i] doubleValue] * [prices[i] doubleValue];
  }
  NSLog(@"λ = %f", lambda);
  // 3. Находится величина, называемая индексом согласованности (ИС):
  double conformityIndex = (lambda - size)/(size - 1);
  NSLog(@"Индекс согласованности: %f", conformityIndex);
  // 4. В зависимости от размерности матрицы парных сравнений находится величина случайной согласованности (СлС).
  double conformityValue = [self conformityValue];
  NSLog(@"Величина случайной согласованности: %f", conformityValue);
  double conformityRatio = conformityIndex / conformityValue;
  NSLog(@"Отношение согласованности: %f", conformityRatio);

  return (conformityRatio <= 0.2);
}

- (NSArray *)orderedAlternatives
{
  if (self.isValid == NO) {
    return nil;
  }

  NSArray *weights = [self alternativeWeights];
  // put weights and alternatives into one dictionary
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  for (int i = 0; i < self.alternatives.count; i++) {
    dict[self.alternatives[i]] = weights[i];
  }
  return [[[dict keysSortedByValueUsingSelector:@selector(compare:)] reverseObjectEnumerator] allObjects];
}

- (void)setAlternatives:(NSArray *)alternatives
{
  if (alternatives != _alternatives) {
    _alternatives = [alternatives copy];
  }
  self.rankMatrix = [[SaatiMatrix alloc] initWithSize:self.alternatives.count];
}

@end