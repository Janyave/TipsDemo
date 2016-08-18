//
//  TipsContainerView.h
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TipsContainerViewDelegate <NSObject>

- (void)tapTipsContainerView:(UIView *)view onPoint:(CGPoint)point;

@end

@interface TipsContainerView : UIView

@property (nonatomic, weak) id<TipsContainerViewDelegate> delegate;
@end
