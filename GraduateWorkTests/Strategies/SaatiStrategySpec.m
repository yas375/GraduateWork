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

  it(@"can't be calculated", ^{
    [[theValue(saati.canBeCalculated) should] beFalse];
  });

  context(@"partly ranked", ^{
    beforeEach(^{
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:7] forRow:0 column:1];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:3] forRow:0 column:2];
      [saati.rankMatrix setValue:[Fraction fractionWithNumerator:1 denominator:5] forRow:1 column:2];
    });

    it(@"can't be calculated", ^{
      [[theValue(saati.canBeCalculated) should] beFalse];
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
    it(@"can be calculated", ^{
      [[theValue(saati.canBeCalculated) should] beTrue];
    });
    it(@"returns TV as the most preferable alternative", ^{
      [[saati.preferredAlternative should] equal:@"TV"];
    });
  });
});

SPEC_END
