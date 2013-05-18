//
//  DroppableAlternativeView.h
//  GraduateWork
//
//  Created by Victor Ilyukevich on 14.05.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

#import "Alternative.h"

@protocol DroppableAlternativeViewDelegate;

@interface DroppableAlternativeView : UIView

@property (nonatomic, strong) Alternative *alternative;
@property (nonatomic, weak) id <DroppableAlternativeViewDelegate>delegate;

@property (nonatomic, weak) UIView *viewToDragIn;
- (void)moveBack;

@end



@protocol DroppableAlternativeViewDelegate

- (void)didFinishDragging:(DroppableAlternativeView *)view;

@end
