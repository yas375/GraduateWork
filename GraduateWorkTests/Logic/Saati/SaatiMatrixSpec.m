#import <Kiwi/Kiwi.h>
#import "SaatiMatrix.h"

SPEC_BEGIN(SaatiMatrixSpec)

describe(@"SaatiMatrix", ^{
  context(@"with size 4", ^{
    __block SaatiMatrix *matrix = nil;
    beforeEach(^{
      matrix = [[SaatiMatrix alloc] initWithSize:4];
    });
    it(@"returns 1 for values on main diagonal", ^{
      [[[matrix valueForRow:0 column:0] should] equal:[Fraction fractionWithNumerator:1]];
      [[[matrix valueForRow:1 column:1] should] equal:[Fraction fractionWithNumerator:1]];
      [[[matrix valueForRow:2 column:2] should] equal:[Fraction fractionWithNumerator:1]];
      [[[matrix valueForRow:3 column:3] should] equal:[Fraction fractionWithNumerator:1]];
    });
    it(@"inserts reversed value as well", ^{
      [matrix setValue:[Fraction fractionWithNumerator:9] forRow:2 column:3];
      [[[matrix valueForRow:3 column:2] should] equal:[Fraction fractionWithNumerator:1 denominator:9]];
    });
    it(@"raises an exception on attempt to set value for on main diagonal", ^{
      [[theBlock(^{
        [matrix setValue:[Fraction fractionWithNumerator:9] forRow:2 column:2];
      }) should] raise];
    });
  });
});

SPEC_END