#import <Kiwi/Kiwi.h>
#import "Fraction.h"


SPEC_BEGIN(FractionSpec)

describe(@"Fraction", ^{
  __block Fraction *fraction = nil;

  context(@"with numerator 2 and denominator 9", ^{
    beforeEach(^{
      fraction = [Fraction fractionWithNumerator:2 denominator:9];
    });
    it(@"has numerator 2", ^{
      [[theValue(fraction.numerator) should] equal:theValue(2)];
    });
    it(@"has denominator 9", ^{
      [[theValue(fraction.denominator) should] equal:theValue(9)];
    });
    it(@"returns 2/9 as description", ^{
      [[[fraction description] should] equal:@"2/9"];
    });
    it(@"returns 0.22 as double value", ^{
      [[theValue([fraction doubleValue]) should] equal:0.22 withDelta:0.01];
    });
    context(@"comparing", ^{
      it(@"equals to 2/9 fraction", ^{
        Fraction *otherFraction = [Fraction fractionWithNumerator:2 denominator:9];
        [[fraction should] equal:otherFraction];
      });
      it(@"doesn't equal to 1/9 fraction", ^{
        Fraction *otherFraction = [Fraction fractionWithNumerator:1 denominator:9];
        [[fraction shouldNot] equal:otherFraction];
      });
    });
    it(@"returns 9/2 as reversed fraction", ^{
      [[[fraction reversedFraction] should] equal:[Fraction fractionWithNumerator:9 denominator:2]];
    });
    context(@"update", ^{
      it(@"can set numerator to 5", ^{
        fraction.numerator = 5;
        [[theValue(fraction.numerator) should] equal:theValue(5)];
      });
      it(@"can set denominator to 7", ^{
        fraction.denominator = 7;
        [[theValue(fraction.denominator) should] equal:theValue(7)];
      });
      it(@"raises exception on attempt to set 0 as denominator", ^{
        [[theBlock(^{
          fraction.denominator = 0;
        }) should] raise];
      });
    });

  });
  context(@"with numerator 9 and without denominator", ^{
    beforeEach(^{
      fraction = [Fraction fractionWithNumerator:9];
    });
    it(@"has denominator 1", ^{
      [[theValue(fraction.denominator) should] equal:theValue(1)];
    });
    it(@"returns 9 as description", ^{
      [[[fraction description] should] equal:@"9"];
    });
    it(@"returns 1/9 as revesed fraction", ^{
      [[[fraction reversedFraction] should] equal:[Fraction fractionWithNumerator:1 denominator:9]];
    });
  });
});

SPEC_END