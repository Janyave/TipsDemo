//
//  ViewController.m
//  TipsDemo
//
//  Created by hzzhanyawei on 16/8/17.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

#import "ViewController.h"
#import "TipsContainerView.h"
#import "TipView.h"
#import "ToolsView.h"
#import "OperationView.h"

#define TipWidth  60
#define TipHeight 20

@interface ViewController ()<TipsContainerViewDelegate, TipViewDelegate, ToolsViewDelegate, OperationViewDelegate>

@property (nonatomic, strong)TipsContainerView *containtView;
@property (nonatomic, strong)ToolsView *toolsView;
@property (nonatomic, strong)OperationView *operationView;

@property (nonatomic, strong)TipView *focusTipView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (IBAction)OnTipsViewShow:(id)sender {
    self.containtView = [[TipsContainerView alloc] initWithFrame:self.view.frame];
    self.containtView.backgroundColor = [UIColor grayColor];//for test
    self.containtView.delegate = self;
    [self.view addSubview:self.containtView];
    
    self.toolsView = [[ToolsView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    self.toolsView.hidden = YES;
    self.toolsView.delegate = self;
    self.operationView = [[OperationView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 150)];
    self.operationView.delegate = self;
    self.operationView.hidden = YES;
    
    [self.view addSubview:self.toolsView];
    [self.view addSubview:self.operationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Notification Method
- (void)keyBoardWillShow:(NSNotification *) note {
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    void (^animation)(void) = ^void(void) {
        CGRect frame = self.toolsView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - keyBoardHeight - frame.size.height;
        self.toolsView.frame = frame;
    };
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

- (void)keyBoardWillHide:(NSNotification *) note {
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    void (^animation)(void) = ^void(void) {
        CGRect frame = self.toolsView.frame;
        frame.origin.y = self.view.frame.size.height - 50;
        self.toolsView.frame = frame;
    };
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

#pragma mark - TipsContainerViewDelegate
- (void)tapTipsContainerView:(UIView *)view onPoint:(CGPoint)point{
    if (self.toolsView.hidden) {//如果已经在编辑tip 则不再出现新的tip
        self.operationView.hidden = YES;
        //需要做view上弹
        CGRect frame = CGRectMake(point.x, point.y, TipWidth, TipHeight);
        if (point.x + TipWidth > view.bounds.size.width) {
            frame.origin.x -= TipWidth;
        }
        if (point.y + TipHeight > view.bounds.size.height) {
            frame.origin.y -= TipHeight;
        }
        TipView *tipView = [[TipView alloc] initWithFrame:frame];
        tipView.delegate = self;
        [view addSubview:tipView];
        self.focusTipView = tipView;
        self.toolsView.hidden = NO;
    }  
}

#pragma mark - TipViewDelegate
- (void)onTipViewClicked:(TipView *)tipView{
    self.toolsView.hidden = YES;
    
    self.focusTipView = tipView;
    self.operationView.operatedTipView = tipView;
    self.operationView.hidden = NO;
}

#pragma mark - ToolsViewDelegate
- (void)onSureButtonClicked:(UIButton *)button{
    self.toolsView.hidden = YES;
}

- (void)onCancelButtonClicked:(UIButton *)button{
    [self.focusTipView removeFromSuperview];
    self.toolsView.hidden = YES;
}

- (void)onTextFieldChangedWithText:(NSString *)text{
    [self.focusTipView editingTipWithString:text];
}

#pragma mark - OperationViewDelegate
- (void)onEditOperationWithTipView:(TipView *)tipView{
    self.operationView.hidden = YES;
    self.toolsView.hidden = NO;
    [self.toolsView setTextFieldText:[tipView getTipViewContainText]];
}

- (void)onFlipOperationWithTipView:(TipView *)tipView{
    self.operationView.hidden = YES;
    [tipView doFlipTipViewWithSupperFrame:self.containtView.frame];
}

- (void)onDeleteOperationWithTipView:(TipView *)tipView{
    self.operationView.hidden = YES;
    [tipView removeFromSuperview];
}

@end
