//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "Fraction.h"

@interface SaatiRankAreaView : UIView

@property(nonatomic, assign) NSUInteger maxRank;

- (Fraction *)fractionForY:(CGFloat)y;
- (CGFloat)yForFraction:(Fraction *)fraction;

@end