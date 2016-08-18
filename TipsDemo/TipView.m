//
//  TipView.m
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import "TipView.h"

@interface TipView ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation TipView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGesture];
        [self addPanGesture];
        self.backgroundColor = [UIColor greenColor];
        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:self.textLabel];
        self.flipLeftOrRight = YES;//默认向左翻转。
    }
    return self;
}

- (void)addTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)addPanGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    [self addGestureRecognizer:pan];
}

- (void)onTapGesture:(UITapGestureRecognizer *)recognizer{
    if ([self.delegate respondsToSelector:@selector(onTipViewClicked:)]) {
        [self.delegate onTipViewClicked:self];
    }
}

- (void)onPanGesture:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self.superview];
    CGPoint center = self.center;
    center.x += translation.x;
    center.y += translation.y;
    self.center = center;
    [recognizer setTranslation:CGPointZero inView:self.superview];
}

- (void)editingTipWithString:(NSString *)text{
    self.textLabel.text = text;
}

- (void)doFlipTipViewWithSupperFrame:(CGRect)frame{
    CGRect tipFrame = self.frame;
    if (_flipLeftOrRight) {//向左
        if (tipFrame.origin.x - tipFrame.size.width > 0){
            [self flipLeft];
            self.flipLeftOrRight = NO;//下次向右
        } else {
            [self flipRight];
            self.flipLeftOrRight = YES;//下次向左
        }
    } else {
        if (tipFrame.origin.x + tipFrame.size.width < frame.size.width) {
            [self flipRight];
            self.flipLeftOrRight = YES;
        } else {
            [self flipLeft];
            self.flipLeftOrRight = NO;
        }
    }   

}

- (void)flipLeft{
    [UIView transitionWithView:self duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        CGRect frame = self.frame;
        frame.origin.x -= frame.size.width;
        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)flipRight{
    [UIView transitionWithView:self duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        CGRect frame = self.frame;
        frame.origin.x += frame.size.width;
        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (NSString *)getTipViewContainText{
    return self.textLabel.text;
}
                                   
@end
