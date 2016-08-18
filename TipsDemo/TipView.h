//
//  TipView.h
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TipViewDelegate <NSObject>

- (void)onTipViewClicked:(UIView *)tipView;

@end

@interface TipView : UIView
@property (nonatomic, weak) id<TipViewDelegate> delegate;
@property (nonatomic, assign) BOOL flipLeftOrRight; //ture for left false for right;

- (void)editingTipWithString:(NSString *)text;
- (void)doFlipTipViewWithSupperFrame:(CGRect)frame;

- (NSString *)getTipViewContainText;
@end
