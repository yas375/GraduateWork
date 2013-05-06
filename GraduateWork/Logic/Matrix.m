//
// Created by Victor Ilyukevich on 06.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "Matrix.h"

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

- (void)setValue:(CGFloat)value forRow:(NSUInteger)row column:(NSUInteger)column
{

  [(NSMutableArray *)storage[row] replaceObjectAtIndex:column withObject:@(value)];
}

- (CGFloat)valueForRow:(NSUInteger)row column:(NSUInteger)column
{
  return [storage[row][column] floatValue];
}

@end