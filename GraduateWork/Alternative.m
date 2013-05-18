//
//  Alternative.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 14.05.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "Alternative.h"

@implementation Alternative

+ (id)alternativeWithName:(NSString *)name
{
  Alternative *alternative = [[Alternative alloc] init];
  alternative.name = name;
  return alternative;
}

@end
