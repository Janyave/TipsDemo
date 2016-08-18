//
//  ToolsView.h
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolsViewDelegate <NSObject>

- (void)onCancelButtonClicked:(UIButton *)button;
- (void)onSureButtonClicked:(UIButton *)button;

- (void)onTextFieldChangedWithText:(NSString *)text;

@end

@interface ToolsView : UIView

@property (nonatomic, weak) id<ToolsViewDelegate> delegate;

- (void)setTextFieldText:(NSString *)text;

@end
