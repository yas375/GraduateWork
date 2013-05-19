//
// Created by Victor Ilyukevich on 06.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "Matrix.h"

#define MATRIX_WIDTH_PER_ITEM 5

@implementation Matrix {
  NSMutableArray *storage;
}

#pragma mark - Lifecycle

- (id)initWithSize:(NSInteger)size
{
  self = [self init];
  if (self) {
    self.size = size;
  }
    
  return self;
}

- (id)init
{
  self = [super init];
  if (self) {
    storage = [NSMutableArray array];
  }
  return self;
}

#pragma mark - Methods

- (NSString *)stringValue
{
  
  NSMutableString *string = [NSMutableString string];
  for (NSArray *row in storage) {
    for (id value in row) {
      NSString *valueString;
      if ([value isKindOfClass:NSNull.class]) {
        valueString = @"-";
      }
      else {
        valueString = [value description];
      }

      for (int i = valueString.length; i < MATRIX_WIDTH_PER_ITEM; i++) {
        [string appendFormat:@" "];
      }
      [string appendFormat:@"%@  ", valueString];
    }
    [string appendString:@"\n"];
  }
  return string;
}

- (NSString *)description
{
  return [@"\n" stringByAppendingString:self.stringValue];
}

- (NSArray *)rowAtIndex:(NSUInteger)row
{
  return [storage[row] copy];
}

// TODO: test
- (void)setSize:(NSInteger)size
{
  if (size != _size) {
    _size = size;

    if (storage.count > size) {
      NSUInteger maxIndex = size - 1;
      [storage removeObjectsInRange:NSMakeRange(size - 1, storage.count - maxIndex)];
      [storage each:^(id sender) {
        [storage removeObjectsInRange:NSMakeRange(size - 1, storage.count - maxIndex)];
      }];
    }
    else {
      NSMutableArray *etalon = [NSMutableArray array];
      for (int i = 0; i < size; i++) {
        [etalon addObject:[NSNull null]];
      }
      while (storage.count < size) {
        [storage addObject:[etalon mutableCopy]];
      }
    }
  }
}

- (void)setValue:(Fraction *)value forRow:(NSUInteger)row column:(NSUInteger)column
{
  [(NSMutableArray *)storage[row] replaceObjectAtIndex:column withObject:value];
}

- (Fraction *)valueForRow:(NSUInteger)row column:(NSUInteger)column
{
  return storage[row][column];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
  Matrix *theCopy = [[self.class allocWithZone:zone] initWithSize:self.size];
  theCopy->storage = [storage copy];

  return theCopy;
}

@end