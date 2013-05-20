//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


@protocol Strategy <NSObject>

@required
@property (nonatomic, copy) NSArray *alternatives;

+ (BOOL)isMultiExpert;
- (BOOL)canBeCalculated;

- (NSString *)preferredAlternative;

@end