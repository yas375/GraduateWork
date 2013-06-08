//
//  SaatiStrategy.m
//  GraduateWork
//
//  Created by Victor Ilyukevich on 19.05.13.
//  Copyright 2013 Victor Ilyukevich. All rights reserved.
//

#import "Kiwi.h"
#import "SaatiStrategy.h"

SPEC_BEGIN(SaatiStrategySpec)

describe(@"SaatiStrategy", ^{
  __block SaatiStrategy *saati = nil;
  context(@"with 4 alternatives", ^{
    saati = [[SaatiStrategy alloc] init];
    saati.alternatives = @[@"TV", @"Radio", @"Newspaper", @"Stand"];
  });
  it(@"returns empty SaatiMatrix with size 4", ^{
    SaatiMatrix *emptyMatrix = [[SaatiMatrix alloc] initWithSize:4];
    [[saati.rankMatrix should] equal:emptyMatrix];
  });

  it(@"hasn't all ranks", ^{
    [[theValue(saati.hasAllRanks) should] beFalse];
  });

  context(@"partly ranked", ^{
    beforeEach(^{
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:7] forRow:0 column:1];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:3] forRow:0 column:2];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:1 denominator:5] forRow:1 column:2];
    });

    it(@"hasn't all ranks", ^{
      [[theValue(saati.hasAllRanks) should] beFalse];
    });
  });
  context(@"completely ranked", ^{
    beforeEach(^{
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:7] forRow:0 column:1];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:3] forRow:0 column:2];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:9] forRow:0 column:3];

      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:1 denominator:5] forRow:1 column:2];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:3] forRow:1 column:3];

      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:5] forRow:2 column:3];
    });
    it(@"is valid", ^{
      [[theValue(saati.isValid) should] beTrue];
    });
    it(@"has all ranks", ^{
      [[theValue(saati.hasAllRanks) should] beTrue];
    });
    it(@"returns alternatives in correct order: the most preferrable alternative goes first", ^{
      [[saati.orderedAlternatives should] equal:@[@"TV", @"Newspaper", @"Radio", @"Stand"]];
    });
  });
  context(@"filled in with conflicted ranks", ^{
    beforeEach(^{
      // CONFLICTED RANKS:
      // 1st is worse than 2nd
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:1 denominator:5] forRow:0 column:1];
      // 2nd is worse than 3rd
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:1 denominator:5] forRow:1 column:2];
      // 1st is better than 3rd
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:5] forRow:0 column:2];

      // OTHER RANKS:
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:9] forRow:0 column:3];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:3] forRow:1 column:3];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:5] forRow:2 column:3];
    });
    it(@"has all ranks", ^{
      [[theValue(saati.hasAllRanks) should] beTrue];
    });
    it(@"is not valid", ^{
      [[theValue(saati.isValid) should] beFalse];
    });
  });
});

SPEC_END
