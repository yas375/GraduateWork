//
//  SaatiRankAreaViewSpec.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 19.05.13.
//  Copyright 2013 Victor Ilyukevich. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "SaatiRankAreaView.h"


@interface SaatiRankAreaView ()
@property(nonatomic, strong) NSArray *rankValues;
@end


SPEC_BEGIN(SaatiRankAreaViewSpec)

describe(@"SaatiRankAreaView", ^{
  context(@"with height 170 and maximum rank 9", ^{
    __block SaatiRankAreaView *rankArea = nil;
    beforeEach(^{
      rankArea = [[SaatiRankAreaView alloc] initWithFrame:CGRectMake(0, 0, 170, 170)];
      rankArea.maxRank = 9;
    });

    it(@"has correct values", ^{
      [[rankArea.rankValues should] equal:@[
              [Fraction fractionWithNumerator:9],
              [Fraction fractionWithNumerator:8],
              [Fraction fractionWithNumerator:7],
              [Fraction fractionWithNumerator:6],
              [Fraction fractionWithNumerator:5],
              [Fraction fractionWithNumerator:4],
              [Fraction fractionWithNumerator:3],
              [Fraction fractionWithNumerator:2],
              [Fraction fractionWithNumerator:1],
              [Fraction fractionWithNumerator:1 denominator:2],
              [Fraction fractionWithNumerator:1 denominator:3],
              [Fraction fractionWithNumerator:1 denominator:4],
              [Fraction fractionWithNumerator:1 denominator:5],
              [Fraction fractionWithNumerator:1 denominator:6],
              [Fraction fractionWithNumerator:1 denominator:7],
              [Fraction fractionWithNumerator:1 denominator:8],
              [Fraction fractionWithNumerator:1 denominator:9]
      ]];
    });

    context(@"max rank is changed to 3", ^{
      it(@"has correct values", ^{
        rankArea.maxRank = 3;
        [[rankArea.rankValues should] equal:@[
                [Fraction fractionWithNumerator:3],
                [Fraction fractionWithNumerator:2],
                [Fraction fractionWithNumerator:1],
                [Fraction fractionWithNumerator:1 denominator:2],
                [Fraction fractionWithNumerator:1 denominator:3]
        ]];
      });
    });

    it(@"returns correct fractions for Y values", ^{
      [[[rankArea fractionForY:0] should] equal:[Fraction fractionWithNumerator:9]];
      [[[rankArea fractionForY:5] should] equal:[Fraction fractionWithNumerator:9]];
      [[[rankArea fractionForY:10] should] equal:[Fraction fractionWithNumerator:8]];
      [[[rankArea fractionForY:20] should] equal:[Fraction fractionWithNumerator:7]];
      [[[rankArea fractionForY:53] should] equal:[Fraction fractionWithNumerator:4]];
      [[[rankArea fractionForY:77] should] equal:[Fraction fractionWithNumerator:2]];

      [[[rankArea fractionForY:81] should] equal:[Fraction fractionWithNumerator:1]];
      [[[rankArea fractionForY:85] should] equal:[Fraction fractionWithNumerator:1]];

      [[[rankArea fractionForY:90] should] equal:[Fraction fractionWithNumerator:1 denominator:2]];
      [[[rankArea fractionForY:120] should] equal:[Fraction fractionWithNumerator:1 denominator:5]];
      [[[rankArea fractionForY:137] should] equal:[Fraction fractionWithNumerator:1 denominator:6]];
      [[[rankArea fractionForY:160] should] equal:[Fraction fractionWithNumerator:1 denominator:9]];
      [[[rankArea fractionForY:163] should] equal:[Fraction fractionWithNumerator:1 denominator:9]];
      [[[rankArea fractionForY:170] should] equal:[Fraction fractionWithNumerator:1 denominator:9]];
    });

    it(@"returns correct Y values for fractions", ^{
      [[theValue([rankArea yForFraction:[Fraction fractionWithNumerator:9]]) should] equal:5 withDelta:0.01];
      [[theValue([rankArea yForFraction:[Fraction fractionWithNumerator:4]]) should] equal:55 withDelta:0.01];
      [[theValue([rankArea yForFraction:[Fraction fractionWithNumerator:1]]) should] equal:85 withDelta:0.01];
      [[theValue([rankArea yForFraction:[Fraction fractionWithNumerator:1 denominator:3]]) should] equal:105 withDelta:0.01];
      [[theValue([rankArea yForFraction:[Fraction fractionWithNumerator:1 denominator:9]]) should] equal:165 withDelta:0.01];
    });

    it(@"raises exception on attemp to get Y for 1/15 fraction", ^{
      [[theBlock(^{
        [rankArea yForFraction:[Fraction fractionWithNumerator:1 denominator:15]];
      }) should] raise];
    });
  });
});

SPEC_END
