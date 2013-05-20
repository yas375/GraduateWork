#import <Kiwi/Kiwi.h>
#import "Matrix.h"


SPEC_BEGIN(MatrixSpec)
  describe(@"Matrix", ^{
    __block Matrix *matrix = nil;
    context(@"initialized with size of 3", ^{
      beforeEach(^{
        matrix = [[Matrix alloc] initWithSize:3];
      });
      it(@"has size of 3", ^{
        [[theValue(matrix.size) should] equal:theValue(3)];
      });
      context(@"set value 3 to row 2 column 1", ^{
        beforeEach(^{
          [matrix setValue:[Fraction fractionWithNumerator:3] forRow:2 column:1];
        });
        it(@"returns value 3", ^{
          [[[matrix valueForRow:2 column:1] should] equal:[Fraction fractionWithNumerator:3]];
        });
        it(@"changes value to 4 and returns correct value", ^{
          [matrix setValue:[Fraction fractionWithNumerator:4] forRow:2 column:1];
          [[[matrix valueForRow:2 column:1] should] equal:[Fraction fractionWithNumerator:4]];
        });
      });
      it(@"can be copied", ^{
        [matrix setValue:[Fraction fractionWithNumerator:42] forRow:2 column:1];
        Matrix *copy = [matrix copy];
        [[[copy valueForRow:2 column:1] should] equal:[Fraction fractionWithNumerator:42]];
      });
      context(@"value change in matrix copy", ^{
        it(@"doesn't affect original", ^{
          [matrix setValue:[Fraction fractionWithNumerator:2] forRow:2 column:1];
          Matrix *copy = [matrix copy];
          [copy setValue:[Fraction fractionWithNumerator:42] forRow:2 column:1];
          [[[matrix valueForRow:2 column:1] should] equal:[Fraction fractionWithNumerator:2]];
        });
      });
      it(@"returns row of objects", ^{
        [matrix setValue:[Fraction fractionWithNumerator:42] forRow:2 column:0];
        [matrix setValue:[Fraction fractionWithNumerator:14] forRow:2 column:2];
        NSArray *row = [matrix rowAtIndex:2];
        [[row should] equal:@[
                [Fraction fractionWithNumerator:42],
                [NSNull null],
                [Fraction fractionWithNumerator:14]
        ]];
      });
    });

    context(@"almost filled in with values matrix", ^{
      beforeEach(^{
        matrix = [[Matrix alloc] initWithSize:2];
        [matrix setValue:[Fraction fractionWithNumerator:1] forRow:0 column:0];
        [matrix setValue:[Fraction fractionWithNumerator:2] forRow:0 column:1];
        [matrix setValue:[Fraction fractionWithNumerator:3] forRow:1 column:0];
      });
      it(@"returns YES to containsNulls", ^{
        [[theValue(matrix.containsNulls) should] beTrue];
      });
      it(@"returns NO to containsNulls when it is filled in", ^{
        [matrix setValue:[Fraction fractionWithNumerator:4] forRow:1 column:1];
        [[theValue(matrix.containsNulls) should] beFalse];
      });

      it(@"equals to the same matrix", ^{
        Matrix *anotherMatrix = [[Matrix alloc] initWithSize:2];
        [anotherMatrix setValue:[Fraction fractionWithNumerator:1] forRow:0 column:0];
        [anotherMatrix setValue:[Fraction fractionWithNumerator:2] forRow:0 column:1];
        [anotherMatrix setValue:[Fraction fractionWithNumerator:3] forRow:1 column:0];
        [[matrix should] equal:anotherMatrix];
      });
      it(@"doesn't equal to a different matrix", ^{
        Matrix *anotherMatrix = [[Matrix alloc] initWithSize:2];
        [anotherMatrix setValue:[Fraction fractionWithNumerator:1] forRow:0 column:0];
        [anotherMatrix setValue:[Fraction fractionWithNumerator:2] forRow:0 column:1];
        [[matrix shouldNot] equal:anotherMatrix];
      });
    });
  });
SPEC_END
