//
//  OperationView.m
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import "OperationView.h"

@interface OperationView ()
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *flipButton;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation OperationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initEditButtonWithSupperViewFrame:frame];
        [self initFlipButtonWithSupperViewFrame:frame];
        [self initDeleteButtonWithSupperViewFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initEditButtonWithSupperViewFrame:(CGRect)frame{
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height/3);
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editButton];
}

- (void)initFlipButtonWithSupperViewFrame:(CGRect)frame{
    self.flipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.flipButton.frame = CGRectMake(0, frame.size.height/3, frame.size.width, frame.size.height/3);
    [self.flipButton setTitle:@"翻转" forState:UIControlStateNormal];
    [self.flipButton addTarget:self action:@selector(flipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.flipButton];
}

- (void)initDeleteButtonWithSupperViewFrame:(CGRect)frame{
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton.frame = CGRectMake(0, frame.size.height * 2/3, frame.size.width, frame.size.height/3);
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteButton];
}

- (void)editButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(onEditOperationWithTipView:)]) {
        [self.delegate onEditOperationWithTipView:self.operatedTipView];
    }
}

- (void)flipButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(onFlipOperationWithTipView:)]) {
        [self.delegate onFlipOperationWithTipView:self.operatedTipView];
    }
}

- (void)deleteButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(onDeleteOperationWithTipView:)]) {
        [self.delegate onDeleteOperationWithTipView:self.operatedTipView];
    }
}

- (void)setHidden:(BOOL)hidden{
    if (hidden) {
        CGRect frame = self.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        [UIView animateWithDuration:0.6 animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            [super setHidden:hidden];
        }];        
    } else{
        [super setHidden:hidden];
        CGRect frame = self.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        [UIView animateWithDuration:0.6 animations:^{
            self.frame = frame;
        }];
    }
}

@end
