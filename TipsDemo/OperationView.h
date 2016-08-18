//
//  OperationView.h
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TipView;
@protocol OperationViewDelegate <NSObject>

- (void)onEditOperationWithTipView:(TipView *)tipView;
- (void)onDeleteOperationWithTipView:(TipView *)tipView;
- (void)onFlipOperationWithTipView:(TipView *)tipView;

@end

@interface OperationView : UIView

@property (nonatomic, weak) id<OperationViewDelegate> delegate;

@property (nonatomic, strong) TipView *operatedTipView;

@end
