//
// Created by Victor Ilyukevich on 19.05.13.
// Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "Strategy.h"
#import "SaatiMatrix.h"

@interface SaatiStrategy : NSObject <Strategy>

@property (nonatomic, copy) SaatiMatrix *rankMatrix;

@end