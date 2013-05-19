//
//  DroppableAlternativeView.h
//  GraduateWork
//
//  Created by Victor Ilyukevich on 14.05.13.
//  Copyright (c) 2013 Victor Ilyukevich. All rights reserved.
//

@protocol DroppableAlternativeViewDelegate;

@interface DroppableAlternativeView : UIView

@property (nonatomic, copy) NSString *alternative;
@property (nonatomic, weak) id <DroppableAlternativeViewDelegate>delegate;

@property (nonatomic, weak) UIView *viewToDragIn;
@property (nonatomic, weak) UIView *previousContainer;

- (void)moveBack;

@end



@protocol DroppableAlternativeViewDelegate

- (void)didFinishDragging:(DroppableAlternativeView *)view;

@end
