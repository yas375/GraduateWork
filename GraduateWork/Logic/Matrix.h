//
// Created by Victor Ilyukevich on 06.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


@interface Matrix : NSObject <NSCopying>
@property(nonatomic) NSInteger size;

- (id)initWithSize:(NSInteger)size;

- (void)setValue:(CGFloat)value forRow:(NSUInteger)row column:(NSUInteger)column;
- (CGFloat)valueForRow:(NSUInteger)row column:(NSUInteger)column;

@end