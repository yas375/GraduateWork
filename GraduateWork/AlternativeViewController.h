//
//  AlternativeViewController.h
//  GraduateWork
//
//  Created by Victor Ilyukevich on 23.06.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlternativeViewControllerDelegate;

@interface AlternativeViewController : UIViewController

@property(nonatomic,weak) IBOutlet NSObject <AlternativeViewControllerDelegate> *delegate;

@end


@protocol AlternativeViewControllerDelegate
- (void)alternativeViewController:(AlternativeViewController *)viewController didAddAlternative:(NSString *)alternative;
@end
