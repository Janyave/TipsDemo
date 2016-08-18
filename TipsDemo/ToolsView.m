//
//  ToolsView.m
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

static const int MaxStringLenght = 20;

#import "ToolsView.h"

@interface ToolsView()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation ToolsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCancelButtonWithSuperViewFrame:frame];
        [self initSureButtonWithSuperViewFrame:frame];
        [self initTextFieldWithSuperViewFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initCancelButtonWithSuperViewFrame:(CGRect)viewFrame{
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(0, 0, 50, viewFrame.size.height);
    [self.cancelButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

- (void)initSureButtonWithSuperViewFrame:(CGRect)viewFrame{
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureButton.frame = CGRectMake(viewFrame.size.width - 50, 0, 50, viewFrame.size.height);
    [self.sureButton setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureBUttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sureButton];
}

- (void)initTextFieldWithSuperViewFrame:(CGRect)viewFrame{
    self.textField = [[UITextField alloc] init];
    self.textField.frame = CGRectMake(50, 1, viewFrame.size.width - 100, viewFrame.size.height - 2);
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textField addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.textField];
}


- (void)cancelButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(onCancelButtonClicked:)]) {
        [self.delegate onCancelButtonClicked:button];
    }
}

- (void)sureBUttonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(onSureButtonClicked:)]) {
        [self.delegate onSureButtonClicked:button];
    }
}

- (void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    if (hidden) {
        self.textField.text = @"";
        [self.textField resignFirstResponder];
    } else {
        self.textField.text = @"";
        [self.textField becomeFirstResponder];
    }
}

- (void)setTextFieldText:(NSString *)text{
    self.textField.text = text;
}

- (void)textFieldTextChanged:(UITextField *)textField{
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    // 简体中文输入
    if ([lang isEqualToString:@"zh-Hans"])
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MaxStringLenght)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MaxStringLenght];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MaxStringLenght];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MaxStringLenght)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > MaxStringLenght)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MaxStringLenght];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:MaxStringLenght];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MaxStringLenght)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(onTextFieldChangedWithText:)]) {
        [self.delegate onTextFieldChangedWithText:textField.text];
    }

}


@end
