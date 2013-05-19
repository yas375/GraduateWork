//
// Created by Victor Ilyukevich on 06.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "SaatiMatrix.h"

@implementation SaatiMatrix

#pragma mark - Matrix

- (void)setSize:(NSInteger)size
{
  [super setSize:size];
  for (int i = 0; i < size; i++) {
    [super setValue:[Fraction fractionWithNumerator:1] forRow:i column:i];
  }
}

- (void)setValue:(Fraction *)value forRow:(NSUInteger)row column:(NSUInteger)column
{
  if (row == column) {
    [NSException raise:@"Don't touch main diagonal" format:@"Attempt to set %@ on (%d,%d)", value, row, column];
  }

  [super setValue:value forRow:row column:column];
  [super setValue:[value reversedFraction] forRow:column column:row];
}

@end