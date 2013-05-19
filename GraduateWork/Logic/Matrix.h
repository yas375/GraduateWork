//
// Created by Victor Ilyukevich on 06.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "Fraction.h"

@interface Matrix : NSObject <NSCopying>

@property(nonatomic) NSInteger size;

- (id)initWithSize:(NSInteger)size;

- (void)setValue:(Fraction *)value forRow:(NSUInteger)row column:(NSUInteger)column;
- (Fraction *)valueForRow:(NSUInteger)row column:(NSUInteger)column;

- (NSArray *)rowAtIndex:(NSUInteger)row;

- (NSString *)stringValue;

@end