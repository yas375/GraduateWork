//
//  SaatiRankViewController.h
//  GraduateWork
//
//  Created by Victor Ilyukevich on 14.05.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

@protocol SaatiRankViewControllerDelegate;
#import "Fraction.h"

@interface SaatiRankViewController : UIViewController

@property (nonatomic,copy) NSString *baseAlternative;
@property (nonatomic,copy) NSArray *otherAlternatives;

@property (nonatomic,weak) id<SaatiRankViewControllerDelegate> delegate;

@end

@protocol SaatiRankViewControllerDelegate
/**
* Delegate should return array of Fraction objects for `otherAlternatives`.
*/
- (NSArray *)ranksOfAlternatives:(SaatiRankViewController *)page;
- (void)rankPage:(SaatiRankViewController *)page didUpdateRank:(Fraction *)rank ofAlternative:(NSString *)alternative;

@end

