#import "Kiwi.h"
#import "Matrix.h"


SPEC_BEGIN(MatrixSpec)
  describe(@"Matrix", ^{
    context(@"initialized with size of 3", ^{
      __block Matrix *matrix = nil;
      beforeEach(^{
        matrix = [[Matrix alloc] initWithSize:3];
      });
      it(@"has size of 3", ^{
        [[theValue(matrix.size) should] equal:theValue(3)];
      });
      context(@"set value 3 to row 2 column 1", ^{
        beforeEach(^{
          [matrix setValue:3 forRow:2 column:1];
        });
        it(@"returns value 3", ^{
          [[theValue([matrix valueForRow:2 column:1]) should] equal:theValue(3)];
        });
        it(@"changes value to 4 and returns correct value", ^{
          [matrix setValue:4 forRow:2 column:1];
          [[theValue([matrix valueForRow:2 column:1]) should] equal:theValue(4)];
        });
      });
    });
  });
SPEC_END
