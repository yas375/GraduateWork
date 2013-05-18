//
// Created by Victor Ilyukevich on 14.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Fraction : NSObject
@property(nonatomic) NSUInteger numerator;

@property(nonatomic) NSUInteger denominator;

+ (Fraction *)fractionWithNumerator:(NSUInteger)numerator denominator:(NSUInteger)denominator;

- (id)initWithNumerator:(NSUInteger)numerator denominator:(NSUInteger)denominator;

+ (Fraction *)fractionWithNumerator:(NSUInteger)numerator;

- (Fraction *)reversedFraction;

- (double)doubleValue;
@end