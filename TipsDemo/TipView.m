//
//  TipView.m
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import "TipView.h"
#define MaxTipViewWidth  100

#define MaxTipViewHeight 60

#define OriginTipViewWidth 32

#define TextContentLeftInset 10


@interface TipView ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *backGroundImageView;
@end

@implementation TipView

- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(frame.origin.x, frame.origin.y, OriginTipViewWidth, MaxTipViewHeight/2);
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGesture];
        [self addPanGesture];
//        self.backgroundColor = [UIColor greenColor];
        
        self.backGroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        UIImage *image = [UIImage imageNamed:@"tip-right"];
        self.backGroundImageView.image = image;
        self.backGroundImageView.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:self.backGroundImageView];
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(TextContentLeftInset, 0, self.bounds.size.width - TextContentLeftInset, self.bounds.size.height)];
        self.textLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.textLabel];
        self.textLabel.numberOfLines = 0;
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
    
//    CGSize size = [text boundingRectWithSize:CGSizeMake(MaxTipViewWidth * 2, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
   
    CGRect frame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, MaxTipViewWidth * 2, MaxTipViewHeight);
    
    [self.textLabel sizeToFit];
    
    CGSize size = self.textLabel.frame.size;
    if (size.width <= MaxTipViewWidth - TextContentLeftInset) {
        if (size.width > OriginTipViewWidth - TextContentLeftInset) {
            CGRect bounds = self.bounds;
            bounds.size.width = size.width + TextContentLeftInset + 4;
            bounds.size.height = MaxTipViewHeight/2;
            self.bounds = bounds;
            
            self.backGroundImageView.frame = self.bounds;
            
            CGRect frame = self.textLabel.frame;
            frame.size.width = size.width;
            frame.size.height = MaxTipViewHeight/2;
            self.textLabel.frame = frame;
        }
        CGRect frame = self.textLabel.frame;
        frame.size.height = MaxTipViewHeight/2;
        self.textLabel.frame = frame;
    } else {
        CGRect bounds = self.bounds;
        bounds.size.width = MaxTipViewWidth + TextContentLeftInset + 4;
        bounds.size.height = MaxTipViewHeight;
        self.bounds = bounds;
        
        self.backGroundImageView.frame = self.bounds;
        
        CGRect frame = self.textLabel.frame;
        frame.size.height = MaxTipViewHeight;
        frame.size.width = MaxTipViewWidth;
        self.textLabel.frame = frame;
    }
    
    
}
- (void)setFlipLeftOrRight:(BOOL)flipLeftOrRight{
    _flipLeftOrRight = flipLeftOrRight;
    
    if (flipLeftOrRight) {
        UIImage *image = [UIImage imageNamed:@"tip-right"];
        self.backGroundImageView.image = image;
        self.textLabel.frame = CGRectMake(TextContentLeftInset, 0, self.bounds.size.width - TextContentLeftInset, self.bounds.size.height);
    } else {
        UIImage *image = [UIImage imageNamed:@"tip-left"];
        self.backGroundImageView.image = image;
        self.textLabel.frame = CGRectMake(0, 0, self.bounds.size.width - TextContentLeftInset, self.bounds.size.height);
    }
}

- (void)adjustTipViewArrowLeft{
    
}

- (void)adjustBackgroundImageView{
    self.backGroundImageView.frame = self.bounds;
//    UIImage *image = self.backGroundImageView.image;
//    UIImage *stretchImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)];
//    self.backGroundImageView.image = stretchImage;
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
