//
//  TipsContainerView.m
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import "TipsContainerView.h"
@interface TipsContainerView()

@end

@implementation TipsContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)onTapGesture:(UITapGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:self];
    if ([self.delegate respondsToSelector:@selector(tapTipsContainerView:onPoint:)]) {
        [self.delegate tapTipsContainerView:self onPoint:point];
    }
}

@end
